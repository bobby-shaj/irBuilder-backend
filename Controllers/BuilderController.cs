using IrBuilder.Api.Models;
using IrBuilder.Api.Services;
using IrBuilder.Api.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace IrBuilder.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BuilderController : ControllerBase
    {
        private readonly ILogger<BuilderController> _logger;
        private readonly IIrDatabaseService _databaseService;
        private readonly IBlobStorageService _blobStorageService;
        private readonly IDockerDeployService _dockerDeployService;

        public BuilderController(
            ILogger<BuilderController> logger, 
            IIrDatabaseService irDatabaseService,
            IBlobStorageService blobStorageService,
            IDockerDeployService dockerDeployService)
        {
            _logger = logger;
            _databaseService = irDatabaseService;
            _blobStorageService = blobStorageService;
            _dockerDeployService = dockerDeployService;
        }

        [HttpPost("publish")]
        [Consumes("multipart/form-data")]
        public async Task<IActionResult> Publish([FromForm] PublishIrAppRequest request)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            _logger.LogInformation("Processing publication for {CompanyName} ({Ticker}))",
                request.Company.CompanyName, request.Company.TickerSymbol);

            string containerName = request.Company.TickerSymbol.Trim().ToLowerInvariant();

            // 1. Upload Logo -> {ticker}/assets/logo.png
            string? logoUrl = null;
            if (request.LogoFile is { Length: > 0 })
            {
                _logger.LogInformation("Received Logo File: {FileName} ({Size} bytes)",
                    request.LogoFile.FileName, request.LogoFile.Length);

                string logoExt = Path.GetExtension(request.LogoFile.FileName ?? ".png");
                string logoBlobPath = $"assets/logo{logoExt}";

                 logoUrl = await _blobStorageService.UploadFileAsync(
                    request.LogoFile,
                    containerName: containerName,
                    filePrefix: logoBlobPath
                );
            }

            // 2. Process Presentations to 'presentations/' virtual folder inside company container
            foreach (var presentation in request.Presentations)
            {
                _logger.LogInformation("Presentation: {Title}, Date: {Date}, IsActive: {IsActive}",
                    presentation.Title, presentation.PresentationDate, presentation.IsActive);

                if (presentation.File is { Length: > 0 })
                {
                    _logger.LogInformation("Attached PDF: {FileName} ({Size} bytes)", 
                        presentation.File.FileName, presentation.File.Length);

                    string pdfExt = Path.GetExtension(presentation.File.FileName ?? ".pdf");
                    string safeTitle = System.Text.RegularExpressions.Regex.Replace(presentation.Title, @"[^\w]", "_");
                    string presBlobPath = $"presentations/{safeTitle}{pdfExt}";

                    await _blobStorageService.UploadFileAsync(
                        presentation.File,
                        containerName: containerName,
                        filePrefix: presBlobPath
                    );
                }
            }

            // 3. Generate & Upload config.json -> {ticker}/config.json
            var config = new IrAppConfig
            {
                CompanyName = request.Company.CompanyName,
                TickerSymbol = request.Company.TickerSymbol,
                PrimaryColor = request.Branding.PrimaryColor,
                SecondaryColor = request.Branding.SecondaryColor,
                LogoUrl = logoUrl
            };

            string? configUrl = await _blobStorageService.UploadJsonAsync(
                config,
                containerName,
                filePrefix: "config.json"
            );


            // 4. Provision & Seed Database 
            string dbName = await _databaseService.ProvisionAndSeedDatabaseAsync(request);
            _logger.LogInformation($"{dbName} created and database seed completed successfully.");

            // 5. Orchestration: Build images on-demand & spin up local containers
            var deployment = await _dockerDeployService.DeployCompanyContainersAsync(containerName, dbName, configUrl!);

            // 6. Return live URL for dashboard navigation
            return Ok(new
            {
                Success = true,
                Message = "IR Application published and deployed to local containers successfully!",
                Company = request.Company.CompanyName,
                Ticker = request.Company.TickerSymbol,
                DatabaseName = dbName,
                ConfigUrl = configUrl,
                LiveAppUrl = deployment.FrontendUrl,
                PublishedAt = DateTime.UtcNow
            });
        }
    }
}
