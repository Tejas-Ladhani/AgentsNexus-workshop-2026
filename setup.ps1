<#
AgentsNexus 2026 - one-command attendee setup.
Installs uv (if missing), Python 3.13, Visual Studio C++ Build Tools (MSVC, needed to
compile yara-python and a litellm Rust extension on Windows), the mcp-scanner CLI, and
the local FastMCP workshop server.
Run from the repository root:
    .\setup.ps1
#>

$ErrorActionPreference = "Stop"

Write-Host "== AgentsNexus 2026 workshop setup ==" -ForegroundColor Cyan

if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
    Write-Host "Installing uv..." -ForegroundColor Yellow
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
    $env:Path = "$env:USERPROFILE\.local\bin;$env:Path"
}

# mcp-scanner is only validated on Python 3.13. A newer default interpreter (e.g. 3.14)
# causes yara-python to fall back to a source build.
Write-Host "Installing Python 3.13 (pinned; mcp-scanner does not support 3.14+)..." -ForegroundColor Yellow
uv python install 3.13

# yara-python and a litellm Rust extension have no prebuilt Windows wheel and compile
# from source, which requires the MSVC linker (link.exe). Idempotent: winget reports
# "already installed" and exits cleanly if the workload is present.
Write-Host "Ensuring Visual Studio C++ Build Tools (MSVC) are installed..." -ForegroundColor Yellow
try {
    winget install --id Microsoft.VisualStudio.2022.BuildTools --exact `
        --accept-package-agreements --accept-source-agreements `
        --override "--wait --passive --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended"
} catch {
    Write-Warning "Could not run winget automatically. If mcp-scanner fails to build yara-python, install 'Desktop development with C++' from https://visualstudio.microsoft.com/visual-cpp-build-tools/ and rerun this script."
}

Write-Host "Installing mcp-scanner CLI (cisco-ai-mcp-scanner)..." -ForegroundColor Yellow
uv tool install cisco-ai-mcp-scanner --python 3.13

Write-Host "Installing the local FastMCP workshop server dependencies..." -ForegroundColor Yellow
Push-Location "$PSScriptRoot\labs\customer-operations-server"
uv sync --python 3.13
Pop-Location

Write-Host "Verifying mcp-scanner..." -ForegroundColor Yellow
mcp-scanner --help | Select-Object -First 3

Write-Host "`nSetup complete. Start with 00-workshop-roadmap.md." -ForegroundColor Green

