using IrBuilder.Api.Models;
using IrBuilder.Api.Services.Interfaces;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;

namespace IrBuilder.Api.Services;

public class IrDatabaseService : IIrDatabaseService
{
    private readonly string _masterConnectionString;
    private readonly string _baseConnectionString;
    private readonly IWebHostEnvironment _env;
    private readonly ILogger<IrDatabaseService> _logger;

    public IrDatabaseService(
        IConfiguration configuration,
        IWebHostEnvironment env,
        ILogger<IrDatabaseService> logger)
    {
        _masterConnectionString = configuration.GetConnectionString("MasterConnection")!;
        _baseConnectionString = configuration.GetConnectionString("BaseConnection")!;
        _env = env;
        _logger = logger;
    }

    public async Task<string> ProvisionAndSeedDatabaseAsync(PublishIrAppRequest request)
    {
        string sanitizedCompany = System.Text.RegularExpressions.Regex.Replace(request.Company.CompanyName, @"[^\w]", "");
        string dbName = $"IR_{sanitizedCompany}_{DateTime.UtcNow:yyyyMMddHHmmss}";

        // 1. Create DB in Master
        await CreateDatabaseAsync(dbName);

        // 2. Execute SSMS-generated Schema Script
        string targetConnectionString = $"{_baseConnectionString};Database={dbName};";
        await ExecuteSchemaScriptAsync(targetConnectionString);

        // 3. Insert Data using Stored Procedures
        await SeedDataWithStoredProceduresAsync(targetConnectionString, request);

        return dbName;
    }

    private async Task CreateDatabaseAsync(string dbName)
    {
        using var connection = new SqlConnection(_masterConnectionString);
        await connection.OpenAsync();

        string sql = $"IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'{dbName}') CREATE DATABASE [{dbName}];";
        using var command = new SqlCommand(sql, connection);
        await command.ExecuteNonQueryAsync();
    }

    private async Task ExecuteSchemaScriptAsync(string connectionString)
    {
        string scriptPath = Path.Combine(_env.ContentRootPath, "Scripts", "CreateIrDb.sql");
    
        if (!File.Exists(scriptPath))
        {
            throw new FileNotFoundException($"Schema script not found at {scriptPath}");
        }

        string scriptContent = await File.ReadAllTextAsync(scriptPath);

        // Regex explanation:
        // (?m)          = Multiline mode (^ and $ match start/end of individual lines)
        // ^\s*GO\s*$    = Matches lines containing ONLY "GO" (case-insensitive), ignoring carriage returns, newlines, and surrounding spaces.
        string[] sqlStatements = Regex.Split(
            scriptContent, 
            @"(?m)^\s*GO\s*$", 
            RegexOptions.IgnoreCase
        );

        using var connection = new SqlConnection(connectionString);
        await connection.OpenAsync();

        foreach (var statement in sqlStatements)
        {
            string trimmedStatement = statement.Trim();
            if (string.IsNullOrWhiteSpace(trimmedStatement)) continue;

            using var command = new SqlCommand(trimmedStatement, connection);
            command.CommandTimeout = 120; // Allows time for larger seed batches
            await command.ExecuteNonQueryAsync();
        }
    }
    
    private async Task SeedDataWithStoredProceduresAsync(string connectionString, PublishIrAppRequest request)
    {
        using var connection = new SqlConnection(connectionString);
        await connection.OpenAsync();
        using var transaction = (SqlTransaction)await connection.BeginTransactionAsync();

        try
        {

            // Call Stored Procedure: sp_InsertPresentation for each item
            foreach (var pres in request.Presentations)
            {
                using var presCmd = new SqlCommand("InsertPresentation", connection, transaction);
                presCmd.CommandType = CommandType.StoredProcedure;
                presCmd.Parameters.AddWithValue("@Title", pres.Title);
                presCmd.Parameters.AddWithValue("@PresentationDate", pres.PresentationDate);
                presCmd.Parameters.AddWithValue("@IsActive", pres.IsActive);
                presCmd.Parameters.AddWithValue("@FileName", (object?)pres.File?.FileName ?? DBNull.Value);
                await presCmd.ExecuteNonQueryAsync();
            }

            await transaction.CommitAsync();
        }
        catch (Exception ex)
        {
            await transaction.RollbackAsync();
            _logger.LogError(ex, "Failed to seed database using stored procedures.");
            throw;
        }
    }
}