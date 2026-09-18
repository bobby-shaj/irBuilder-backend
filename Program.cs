using IrBuilder.Api.Services;
using IrBuilder.Api.Services.Interfaces;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddScoped<IIrDatabaseService, IrDatabaseService>();
builder.Services.AddScoped<IBlobStorageService, BlobStorageService>();
builder.Services.AddScoped<IDockerDeployService, DockerDeployService>();

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "IR Builder API",
        Version = "v1",
        Description = "Backend API for managing IR Application publishing and presentations."
    });
});

builder.WebHost.ConfigureKestrel(options =>
{
    options.Limits.MaxRequestBodySize = 104_857_600;
});

builder.Services.Configure<FormOptions>(options =>
{
    options.MultipartBodyLengthLimit = 104_857_600;
});

builder.Services.AddCors(options =>
{
    options.AddPolicy("AngularDev", policy =>
        policy.WithOrigins("http://localhost:4200")
            .AllowAnyHeader()
            .AllowAnyMethod());
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "IR Builder API v1");
        c.RoutePrefix = "swagger";
    });
}

//app.UseHttpsRedirection();
app.UseCors("AngularDev");
app.MapControllers();
app.Run();