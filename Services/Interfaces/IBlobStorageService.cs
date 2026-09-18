using Microsoft.AspNetCore.Http;

namespace IrBuilder.Api.Services.Interfaces
{
    public interface IBlobStorageService
    {
        Task<string?> UploadFileAsync(IFormFile? file, string containerName, string filePrefix);
        Task<string?> UploadJsonAsync<T>(T data, string containerName, string filePrefix);
    }
}
