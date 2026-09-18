using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using IrBuilder.Api.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using System.Text.Json;

namespace IrBuilder.Api.Services;

public class BlobStorageService : IBlobStorageService
{
    private readonly BlobServiceClient _blobServiceClient;
    private readonly ILogger<BlobStorageService> _logger;

    public BlobStorageService(IConfiguration configuration, ILogger<BlobStorageService> logger)
    {
        string connectionString = configuration.GetConnectionString("AzureBlobStorage")
            ?? throw new InvalidOperationException("AzureBlobStorage connection string missing.");

        _blobServiceClient = new BlobServiceClient(connectionString);
        _logger = logger;
    }

    public async Task<string?> UploadFileAsync(IFormFile? file, string containerName, string filePrefix)
    {
        if (file is null || file.Length == 0) return null;

        // 1. Get or Create Container with Public Blob Read Access
        var containerClient = _blobServiceClient.GetBlobContainerClient(containerName.ToLowerInvariant());
        await containerClient.CreateIfNotExistsAsync(PublicAccessType.Blob);

        // 2. Generate Unique Blob Name to avoid overwrites (e.g., acme_logo_20260814.png)
        var blobClient = containerClient.GetBlobClient(filePrefix);

        // 3. Upload File Stream with Content-Type Header
        _logger.LogInformation("Uploading {FileName} ({Size} bytes) to Azurite container '{Container}/{filePrefix}'",
            file.FileName, file.Length, containerName, filePrefix);

        using var stream = file.OpenReadStream();
        var uploadOptions = new BlobUploadOptions
        {
            HttpHeaders = new BlobHttpHeaders
            {
                ContentType = string.IsNullOrWhiteSpace(file.ContentType)
                    ? "application/octet-stream"
                    : file.ContentType
            }
        };

        await blobClient.UploadAsync(stream, uploadOptions);

        // 4. Return Direct Public Blob URL
        return blobClient.Uri.ToString();
    }

    public async Task<string?> UploadJsonAsync<T>(T data, string containerName, string filePrefix)
    {
        var containerClient = _blobServiceClient.GetBlobContainerClient(containerName.ToLowerInvariant());
        await containerClient.CreateIfNotExistsAsync(PublicAccessType.Blob);

        var blobClient = containerClient.GetBlobClient(filePrefix);

        string jsonString = JsonSerializer.Serialize(data, new JsonSerializerOptions
        {
            WriteIndented = true
        });

        using var stream = new MemoryStream(System.Text.Encoding.UTF8.GetBytes(jsonString));

        var uploadOptions = new BlobUploadOptions
        {
            HttpHeaders = new BlobHttpHeaders { ContentType = "application/json" }
        };

        await blobClient.UploadAsync(stream, uploadOptions);

        return blobClient.Uri.ToString();
    }
}