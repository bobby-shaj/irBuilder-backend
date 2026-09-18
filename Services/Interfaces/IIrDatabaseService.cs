using IrBuilder.Api.Models;

namespace IrBuilder.Api.Services.Interfaces
{
    public interface IIrDatabaseService
    {
        Task<string> ProvisionAndSeedDatabaseAsync(PublishIrAppRequest request);
    }
}
