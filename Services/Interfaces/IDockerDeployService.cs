namespace IrBuilder.Api.Services.Interfaces
{
    public interface IDockerDeployService
    {
        Task<DeployedIrAppResult> DeployCompanyContainersAsync(string ticker, string dbName, string configUrl, string companyName);
    }

    public record DeployedIrAppResult(string FrontendUrl, string BackendUrl, string ContainerGroupPrefix);
}
