$default_cwd = "$HOME\Downloads";

class LibraryObj {
    [Boolean]$Archive,
    [String]$Uri,
    [String]$Flags,
    [String]$OutFolder,
    [String]$OutFile,
}

$extensions = @(
    "ms-vscode.cpptools",
    "formulahendry.code-runner",
    "GitHub.vscode-pull-request-github",
    "christian-kohler.path-intellisense",
    "ms-vscode.PowerShell",
    "bmewburn.vscode-intelephense-client",
    "yzhang.markdown-all-in-one",
    "TabNine.tabnine-vscode",
    "naumovs.color-highlight",
    "alefragnani.project-manager",
    "GitHub.vscode-github-actions",
    "BracketPairColorDLW.bracket-pair-color-dlw",
    "ms-vscode-remote.remote-containers"
);

$lib_objs = @(
    [LibraryObj]@{
        Uri = "https://github.com/PowerShell/PowerShell/releases/download/v7.5.0-rc.1/PowerShell-7.5.0-rc.1-win-x64.zip";
        OutFolder = "ps7";
        Archive = True;
        Flags = "";
        Exe = "";
    },
    
    [LibraryObj]@{
        Uri = "https://github.com/git-for-windows/git/releases/download/v2.47.0.windows.2/PortableGit-2.47.0.2-64-bit.7z.exe";
        Flags = "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /NOCANCEL /NORESTART";
        Archive = False;        
        OutFolder = "";
        Exe = ""
    },
    
    [LibraryObj]@{
        Archive = False;
        Uri = "https://vscode.download.prss.microsoft.com/dbazure/download/stable/f1a4fb101478ce6ec82fe9627c43efbf9e98c813/VSCodeUserSetup-x64-1.95.3.exe";
        Flags = "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /NOCANCEL /NORESTART /MERGETASKS=!runcode";
        OutFolder = $default_cwd;
        Exe = "VSCodeUserSetup-x64-1.95.3.exe"
    }
);

foreach ($lib_obj in $lib_objs) {
    Invoke-WebRequest -Uri $lib_obj.Uri
    
    if (lib_obj.Archive) {
        Expand-Archive -Path $default_cwd
    }

"$default_cwd\AppData\Local\Programs\Microsoft VS Code\bin\code.exe" --install-extension


