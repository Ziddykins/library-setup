$default_cwd = "$HOME\Downloads";

class LibraryObj {
    [Boolean]$Archive,
    [String]$Uri,
    [String]$Flags,
    [String]$OutFolder,
    [String]$Exe
    
}

$lib_objs = %(
    [LibraryObj]@{
        Archive = True;
        Uri = "https://github.com/PowerShell/PowerShell/releases/download/v7.5.0-rc.1/PowerShell-7.5.0-rc.1-win-x64.zip";
        Flags = "";
        OutFolder "ps7";
        Exe = "";
    },
    
    [LibraryObj]@{
        Archive = False;
        Uri = "https://github.com/git-for-windows/git/releases/download/v2.47.0.windows.2/PortableGit-2.47.0.2-64-bit.7z.exe";
        Flags = "/VERYSILENT /NORESTART /MERGETASKS=!runcode";
        OutFolder = "";
        Exe = ""
    },
    
    [LibraryObj]@{
        Archive = False;
        Uri = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user";
        Flags = "/VERYSILENT /NORESTART /MERGETASKS=!runcode";
        OutFolder = $default_cwd;
        Exe = ""
    }
);

foreach ($lib_obj in $lib_objs) {
    Invoke-WebRequest -Uri $file -OutFile "$($lib_obj.OutFolder)\$($lib_obj.Exe)";
    
    if (lib_obj.Archive) {
        Expand-Archive -Path $default_cwd
    }