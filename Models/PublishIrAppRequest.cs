using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace IrBuilder.Api.Models
{
    public class NavItemDto
    {
        [JsonPropertyName("title")]
        public string Title { get; set; } = string.Empty;
        [JsonPropertyName("url")]
        public string Url { get; set; } = string.Empty;
    }

    public class PublishIrAppRequest
    {
        [Required]
        public CompanyDto Company { get; set; } = new();

        [Required]
        public BrandingDto Branding { get; set; } = new();

        public IFormFile? LogoFile { get; set; }
        public List<PresentationDto> Presentations { get; set; } = new();
        public List<NavItemDto> MainMenu { get; set; } = new();
    }

    public class CompanyDto
    {
        [Required]
        public string CompanyName { get; set; } = string.Empty;

        [Required]
        public string TickerSymbol { get; set; } = string.Empty;
    }

    public class BrandingDto
    {
        public string PrimaryColor { get; set; } = "#000000";
        public string SecondaryColor { get; set; } = "#ffffff";
    }

    public class PresentationDto
    {
        [Required]
        public string Title { get; set; } = string.Empty;

        public DateTime PresentationDate { get; set; }

        public bool IsActive { get; set; }

        public IFormFile? File { get; set; }
    }
}
