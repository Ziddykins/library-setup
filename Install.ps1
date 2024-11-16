# SET ME #
$git_user = "SET_ME";
$git_email = "SET@ME";

$default_cwd = "$HOME\Downloads";

class LibraryObj {
    [Boolean]$Archive;
    [String]$Uri;
    [String]$Flags;
    [String]$ExtractFolder;
    [String]$DownloadFolder;
    [String]$Exe;
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
        ExtractFolder = "$default_cwd\ps7";
        Archive = 1;
        Flags = "";
        Exe = "PowerShell-7.5.0-rc.1-win-x64.zip";
        DownloadFolder = $default_cwd;
    },
    
    [LibraryObj]@{
        Archive = 0;
        Uri = "https://vscode.download.prss.microsoft.com/dbazure/download/stable/f1a4fb101478ce6ec82fe9627c43efbf9e98c813/VSCodeUserSetup-x64-1.95.3.exe";
        Flags = "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /NOCANCEL /NORESTART /MERGETASKS=!runcode";
        DownloadFolder = $default_cwd;
        Exe = "VSCodeUserSetup-x64-1.95.3.exe";
    }
);

foreach ($lib_obj in $lib_objs) {
    $full_path = Join-Path $lib_obj.DownloadFolder -ChildPath $lib_obj.Exe;

    if (![System.IO.File]::Exists($full_path)) {
        Write-Host "Downloading $full_path"
        Invoke-WebRequest -Uri $lib_obj.Uri -OutFile $full_path
    } else {
        Write-Host "File $($lib_obj.Exe) already downloaded!"
    }
    
    if ($lib_obj.Archive) {
        if (![System.IO.Directory]::Exists($lib_obj.ExtractFolder)) {
            Write-Host "Archive found, expanding to $($lib_obj.ExtractFolder)";
            Expand-Archive -Path $full_path -DestinationPath $lib_obj.ExtractFolder -Force;
        } else {
            Write-Host "Archive has already been extracted";
        }
    } else {
        $cmd = "$($lib_obj.DownloadFolder)\$($lib_obj.Exe) $($lib_obj.Flags)"
        Write-Host "Executing $($lib_obj.Exe) with $($cmd)";
        Start-Job -Name $lib_obj.Exe -ScriptBlock { start $cmd; }
    }
}

if (!(winget list | findstr Git.Git)) {
    Write-Host "Installing Git through winget...";
    winget install Git.Git --force --accept-source-agreements --accept-package-agreements --scope user --silent;
    git config --global user.name $git_user
    git config --global user.email $git_email
} else {
    Write-Host "Git found to be installed"
}

$extensions | %{
    Write-Host "Installing extension $_...";
    $code_exe = "$($env:LOCALAPPDATA)\Programs\Microsoft VS Code\bin\code"
    Start-Process $code_exe -ArgumentList "--install-extension $_" -WindowStyle Hidden
};