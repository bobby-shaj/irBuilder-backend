using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;

namespace IrBuilder.Api.Services;

public class AssetUploadService
{
    private readonly string _azureConnectionString;
    private readonly IWebHostEnvironment _env;
    private readonly ILogger<AssetUploadService> _logger;

    public AssetUploadService(IConfiguration configuration, IWebHostEnvironment env, ILogger<AssetUploadService> logger)
    {
        _azureConnectionString = configuration["ConnectionStrings:AzureBlobStorage"]
            ?? throw new ArgumentNullException("AzureBlobStorage connection string is missing");
        _env = env;
        _logger = logger;
    }

    /// <summary>
    /// Uploads all static assets from IrBuilder/assets/images to the target company's Blob container.
    /// </summary>
    public async Task UploadTenantAssetsAsync(string containerName)
    {
        // Path to IrBuilder's root assets/images directory
        string localAssetsPath = Path.Combine(_env.ContentRootPath, "assets");

        if (!Directory.Exists(localAssetsPath))
        {
            _logger.LogWarning("Local assets directory not found at {Path}. Skipping asset upload.", localAssetsPath);
            return;
        }

        var blobServiceClient = new BlobServiceClient(_azureConnectionString);
        var containerClient = blobServiceClient.GetBlobContainerClient(containerName.ToLowerInvariant());

        // Ensure container exists with public Blob access so the frontend can display images
        await containerClient.CreateIfNotExistsAsync(PublicAccessType.Blob);

        // Scan all files in local assets/images directory (including subdirectories)
        var files = Directory.GetFiles(localAssetsPath, "*.*", SearchOption.AllDirectories);

        foreach (var filePath in files)
        {
            // Calculate relative path inside the container (e.g., "assets/images/logo.jpg")
            string relativePath = Path.GetRelativePath(_env.ContentRootPath, filePath);

            // Convert Windows backward slashes to forward slashes for Blob paths
            string blobName = relativePath.Replace('\\', '/');

            var blobClient = containerClient.GetBlobClient(blobName);

            // Determine Content-Type header based on extension
            string contentType = GetContentType(filePath);

            var options = new BlobUploadOptions
            {
                HttpHeaders = new BlobHttpHeaders { ContentType = contentType }
            };

            await using var fileStream = File.OpenRead(filePath);
            await blobClient.UploadAsync(fileStream, options);

            _logger.LogInformation("Uploaded asset '{BlobName}' to container '{Container}'", blobName, containerName);
        }
    }

    private static string GetContentType(string filePath)
    {
        string extension = Path.GetExtension(filePath).ToLowerInvariant();
        return extension switch
        {
            ".jpg" or ".jpeg" => "image/jpeg",
            ".png" => "image/png",
            ".gif" => "image/gif",
            ".svg" => "image/svg+xml",
            ".webp" => "image/webp",
            ".ico" => "image/x-icon",
            _ => "application/octet-stream"
        };
    }
}