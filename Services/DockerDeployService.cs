using Docker.DotNet;
using ICSharpCode.SharpZipLib.Tar;
using IrBuilder.Api.Services.Interfaces;
using IrBuilder.Api.Helpers;
using Docker.DotNet.Models;

namespace IrBuilder.Api.Services
{
    public class DockerDeployService : IDockerDeployService
    {
        private readonly IWebHostEnvironment _env;
        private readonly ILogger<DockerDeployService> _logger;
        private readonly DockerClient _dockerClient;

        public DockerDeployService(
            IWebHostEnvironment env,
            ILogger<DockerDeployService> logger)
        {
            _env = env;
            _logger = logger;
            _dockerClient = new DockerClientConfiguration().CreateClient();
        }

        // Standard base images pushed by 
        public async Task<DeployedIrAppResult> DeployCompanyContainersAsync(string ticker, string dbName, string configUrl, string companyName)
        {
            string cleanTicker = ticker.ToLowerInvariant();

            // 1. Resolve paths to sibling repositories (frontend and backend)
            // Adjust these relative paths based on your folder structure
            string rootDir = Path.GetFullPath(Path.Combine(_env.ContentRootPath, "..", "..", "UserRegistration"));
            string backendSourcePath = Path.Combine(rootDir, "Backend");
            string frontendSourcePath = Path.Combine(rootDir, "Frontend", "FocusPortal");

            // Diagnostic Logging & Path Validation
            _logger.LogInformation("Resolved Backend Source Path: {Path}", backendSourcePath);
            _logger.LogInformation("Resolved Frontend Source Path: {Path}", frontendSourcePath);

            if (!Directory.Exists(backendSourcePath))
            {
                throw new DirectoryNotFoundException($"IR Backend source directory not found at resolved path: '{backendSourcePath}'");
            }

            if (!Directory.Exists(frontendSourcePath))
            {
                throw new DirectoryNotFoundException($"IR Frontend source directory not found at resolved path: '{frontendSourcePath}'");
            }

            string backendImageTag = $"ir-backend-{cleanTicker}:latest";
            string frontendImageTag = $"ir-frontend-{cleanTicker}:latest";

            // 2. Programmatically build local Dockerfiles
            _logger.LogInformation("Building Docker image for backend from context {Path}...", backendSourcePath);
            await BuildImageFromSourceAsync(
                sourceDirPath: backendSourcePath, 
                imageTag: backendImageTag,
                dockerfilePath: "FocusPortal/Dockerfile"
            );

            _logger.LogInformation("Building Docker image for frontend from context {Path}...", frontendSourcePath);
            await BuildImageFromSourceAsync(
                sourceDirPath: frontendSourcePath, 
                imageTag: frontendImageTag,
                dockerfilePath: "Dockerfile"    
            );

            // 3. Assing Host Ports
            ushort backendHostPort = 5080;
            ushort frontendHostPort = 4300;

            // 4. Instantiate & Run Backend Container
            await CreateAndStartContainerAsync(
                image: backendImageTag,
                containerName: $"ir-backend-{cleanTicker}",
                containerPort: "8080",
                hostPort: backendHostPort,
                envVars: new[]
                {
                    $"ConnectionStrings__DefaultConnection=Server=host.docker.internal,1433;Database={dbName};User Id=sa;Password=Bshaj_1978;TrustServerCertificate=True;",
                    $"CompanySettings__TickerSymbol={cleanTicker}",
                    $"CompanySettings__CompanyName={companyName}",
                    $"CdnSettings__BaseUrl=http://127.0.0.1:10010/devstoreaccount1",
                    $"CONFIG_URL={configUrl}"
                }
            );

            // 5. Instantiate & Run Frontend Container
            await CreateAndStartContainerAsync(
                image: frontendImageTag,
                containerName: $"ir-frontend-{cleanTicker}",
                containerPort: "80",
                hostPort: frontendHostPort,
                envVars: new[]
                {
                    $"API_URL=http://localhost:{backendHostPort}/api",
                    $"CDN_URL=http://127.0.0.1:10010/devstoreaccount1",
                    $"CONFIG_URL={configUrl}"
                }
            );

            return new DeployedIrAppResult(
                FrontendUrl: $"http://localhost:{frontendHostPort}",
                BackendUrl: $"http://localhost:{backendHostPort}",
                ContainerGroupPrefix: cleanTicker
            );
        }

        private async Task BuildImageFromSourceAsync(string sourceDirPath, string imageTag, string dockerfilePath = "Dockerfile")
        {
            if (!Directory.Exists(sourceDirPath))
            {
                throw new DirectoryNotFoundException($"Source directory for docker build not found at '{sourceDirPath}'.");
            }

            using var tarStream = TarHelper.CreateTarballFromDirectory(sourceDirPath);

            var buildParams = new ImageBuildParameters
            {
                Tags = new[] { imageTag },
                Dockerfile = dockerfilePath,
                NoCache = true,
            };

            bool buildHasErrors = false;
            string lastErrorMessage = string.Empty;

            // Create a progress handler to stream build output to logging
            var progress = new Progress<JSONMessage>(message =>
            {
                if (!string.IsNullOrEmpty(message.Stream))
                {
                    _logger.LogInformation("[Docker Build] {Message}", message.Stream.TrimEnd());
                }
                if (!string.IsNullOrEmpty(message.ErrorMessage))
                {
                    buildHasErrors = true;
                    lastErrorMessage = message.ErrorMessage;
                    _logger.LogError("[Docker Build Error] {Error}", message.ErrorMessage);
                }
            });

            // Triggers the local Docker daemon build engine
            await _dockerClient.Images.BuildImageFromDockerfileAsync(
                buildParams,
                tarStream,
                null,
                null,
                progress,
                CancellationToken.None
            );

            if (buildHasErrors)
            {
                throw new Exception($"Docker image build failed for tag '{imageTag}'. Cause: {lastErrorMessage}");
            }
        }

        private async Task CreateAndStartContainerAsync(string image, string containerName, string containerPort, ushort hostPort, string[] envVars)
        {
            // Stop/Remove existing container if re-publishing same ticker
            try
            {
                await _dockerClient.Containers.StopContainerAsync(containerName, new ContainerStopParameters());
                await _dockerClient.Containers.RemoveContainerAsync(containerName, new ContainerRemoveParameters());
            }
            catch { /* Container didn't exist */ }

            var createParams = new CreateContainerParameters
            {
                Image = image,
                Name = containerName,
                Env = envVars,
                HostConfig = new HostConfig
                {
                    PortBindings = new Dictionary<string, IList<PortBinding>>
                    {
                        { $"{containerPort}/tcp", new List<PortBinding> { new() { HostPort = hostPort.ToString() } } }
                    }
                }
            };

            await _dockerClient.Containers.CreateContainerAsync(createParams);
            await _dockerClient.Containers.StartContainerAsync(containerName, new ContainerStartParameters());
        }
    }
}
