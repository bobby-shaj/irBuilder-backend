namespace IrBuilder.Api.Models
{
    public class IrAppConfig
    {
        public string CompanyName { get; set; } = string.Empty;
        public string TickerSymbol { get; set; } = string.Empty;
        public string PrimaryColor { get; set; } = string.Empty;
        public string SecondaryColor { get; set; } = string.Empty;
        public string? LogoUrl { get; set; }
        public DateTime PublishedAt { get; set; } = DateTime.UtcNow;
    }
}
