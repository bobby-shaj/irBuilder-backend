using ICSharpCode.SharpZipLib.Tar;

namespace IrBuilder.Api.Helpers;

public static class TarHelper
{
    public static Stream CreateTarballFromDirectory(string sourceDir)
    {
        var tarStream = new MemoryStream();

        using (var archive = new TarOutputStream(tarStream, System.Text.Encoding.UTF8) { IsStreamOwner = false })
        {
            AddDirectoryToTar(archive, sourceDir, sourceDir);
            archive.Close();
        }

        tarStream.Position = 0;
        return tarStream;
    }

    private static void AddDirectoryToTar(TarOutputStream archive, string currentDir, string rootDir)
    {
        // 1. Add Files
        string[] files = Directory.GetFiles(currentDir);
        foreach (string file in files)
        {
            // Skip build outputs, temp directories, and git tracking
            string lowerFile = file.ToLowerInvariant();
            if (lowerFile.Contains(@"\bin\") || lowerFile.Contains(@"\obj\") ||
                lowerFile.Contains(@"\node_modules\") || lowerFile.Contains(@"\.git\") ||
                lowerFile.Contains(@"\dist\") || lowerFile.Contains(@"\.vs\"))
            {
                continue;
            }

            string relativePath = Path.GetRelativePath(rootDir, file).Replace('\\', '/');

            // Open file with FileShare.ReadWrite to prevent length lock mismatches
            using var fs = new FileStream(file, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);

            var entry = TarEntry.CreateTarEntry(relativePath);
            entry.Size = fs.Length; // Use actual stream length
            archive.PutNextEntry(entry);

            // Copy exactly fs.Length bytes to archive
            fs.CopyTo(archive);
            archive.CloseEntry();
        }

        // 2. Add Subdirectories recursively
        string[] subDirs = Directory.GetDirectories(currentDir);
        foreach (string subDir in subDirs)
        {
            string folderName = Path.GetFileName(subDir).ToLowerInvariant();
            if (folderName is "bin" or "obj" or "node_modules" or ".git" or "dist" or ".vs" or ".angular")
            {
                continue;
            }

            AddDirectoryToTar(archive, subDir, rootDir);
        }
    }
}