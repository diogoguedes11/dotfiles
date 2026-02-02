<#
.SYNOPSIS
    Corporate DevOps Setup - Windows Host Bootstrap
.DESCRIPTION
    Installs WSL2, Windows Terminal, VS Code, Nerd Fonts, and essential tools.
    Prepares the host for the Linux (WSL) setup script.
#>

Write-Host "🚀 Starting Corporate Windows Setup..." -ForegroundColor Cyan

# 1. Check Admin Privileges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
  Write-Host "❌ Error: This script must be run as Administrator." -ForegroundColor Red
  Write-Host "👉 Right-click PowerShell and select 'Run as Administrator'."
  exit 1
}

# 2. Enable WSL2
Write-Host "🐧 Checking WSL2 status..." -ForegroundColor Yellow
$wslStatus = wsl --status 2>$null
if ($LASTEXITCODE -ne 0) {
  Write-Host "⚡ Installing WSL2 and Ubuntu... (System restart will be required)" -ForegroundColor Magenta
  wsl --install
}
else {
  Write-Host "✅ WSL is already installed." -ForegroundColor Green
}

# 3. Install Apps via Winget
Write-Host "📦 Installing Applications via Winget..." -ForegroundColor Yellow

$apps = @(
  "Microsoft.WindowsTerminal",  # Modern Terminal
  "Microsoft.VisualStudioCode", # Code Editor
  "Microsoft.PowerToys",        # Window Management (FancyZones)
  "Git.Git",                    # Git for Windows
  "Docker.DockerDesktop",       # Docker
  "Obsidian.Obsidian"           # Notes
)

foreach ($app in $apps) {
  Write-Host "Installing $app..."
  winget install --id $app -e --accept-source-agreements --accept-package-agreements --silent
}

# 4. Install Nerd Fonts (Critical for Astigmatism/Readability)
Write-Host "Installing JetBrains Mono Nerd Font..." -ForegroundColor Yellow
$fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip"
$fontDest = "$env:TEMP\JetBrainsMono.zip"
$fontDir = "$env:TEMP\JetBrainsMono"

# Download and Extract
Invoke-WebRequest -Uri $fontUrl -OutFile $fontDest
Expand-Archive -Path $fontDest -DestinationPath $fontDir -Force

# Install Fonts
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace($fontDir)
$fontFiles = Get-ChildItem -Path $fontDir -Filter "*.ttf"

foreach ($file in $fontFiles) {
  Write-Host "   -> Installing $($file.Name)..."
  Copy-Item $file.FullName -Destination "C:\Windows\Fonts" -Force
  New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" -Name $file.Name -Value $file.Name -Force | Out-Null
}

# 5. Configure VS Code Extensions
Write-Host "Installing VS Code Extensions..." -ForegroundColor Yellow
# Note: This might fail if VS Code was just installed and PATH isn't updated yet.
try {
  $codePath = (Get-Command code -ErrorAction SilentlyContinue).Source
  if ($codePath) {
    code --install-extension ms-vscode-remote.remote-wsl
    code --install-extension ms-azuretools.vscode-docker
    code --install-extension hashicorp.terraform
    code --install-extension eamodio.gitlens
    code --install-extension pkief.material-icon-theme
    code --install-extension arcticicestudio.nord-visual-studio-code # Astigmatism Friendly
  }
  else {
    Write-Host "VS Code installed but not in PATH yet. Restart terminal to install extensions." -ForegroundColor Gray
  }
}
catch {
  Write-Host "Skipping extension installation." -ForegroundColor Gray
}

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "✅ WINDOWS SETUP COMPLETE!" -ForegroundColor Green
Write-Host "🔄 Please RESTART your computer now to finalize WSL."
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "👉 AFTER RESTART:"
Write-Host "1. Open 'Ubuntu' from the Start Menu."
Write-Host "2. Inside Ubuntu, run your universal 'setup.sh' script."
Write-Host "=========================================="