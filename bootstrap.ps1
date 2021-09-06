# Prep folders
New-Item -Path $env:USERPROFILE -Name ".ssh" -ItemType Directory
New-Item -Name AJF8729 -Path C:\ -ItemType Directory
New-Item -Name Git -Path C:\AJF8729\ -ItemType Directory
Set-Location -Path C:\AJF8729\

# Download latest release of DesktopAppInstaller
$tag = (Invoke-WebRequest -UseBasicParsing "https://api.github.com/repos/microsoft/winget-cli/releases" | ConvertFrom-Json)[0].tag_name
$download = "https://github.com/microsoft/winget-cli/releases/download/$tag/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
Invoke-WebRequest -UseBasicParsing $download -OutFile "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

# Install DesktopAppInstaller
Add-AppxPackage -Path .\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

# Install Git
winget install git -h

# Install VS Code
winget install "Microsoft Visual Studio Code" -h

#Set GIT_SSH
[System.Environment]::SetEnvironmentVariable('GIT_SSH', 'C:\Windows\System32\OpenSSH\ssh.exe', [System.EnvironmentVariableTarget]::Machine)

# Download PowerShell profile
Invoke-RestMethod -Uri "https://raw.githubusercontent.com/ajf8729/dotfiles/main/Microsoft.PowerShell_profile.ps1" | Out-File -LiteralPath $PROFILE -Force

# Download private key
scp ajf@anthonyfontanez.com:.ssh\id_rsa "$env:USERPROFILE\.ssh\id_rsa"
