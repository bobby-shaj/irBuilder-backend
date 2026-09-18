namespace IrBuilder.Api.Services.Interfaces
{
    public interface IDockerDeployService
    {
        Task<DeployedIrAppResult> DeployCompanyContainersAsync(string ticker, string dbName, string configUrl);
    }

    public record DeployedIrAppResult(string FrontendUrl, string BackendUrl, string ContainerGroupPrefix);
}
