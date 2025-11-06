# POC-Tools React Setup Script for Windows 11
# This script will set up your React-based structure with obfuscation and GitHub Pages deployment

Write-Host "🚀 Setting up POC-Tools with React..." -ForegroundColor Cyan

# Step 1: Check if Node.js is installed
Write-Host "`n📋 Checking prerequisites..." -ForegroundColor Blue
try {
    $nodeVersion = node --version
    Write-Host "✓ Node.js $nodeVersion is installed" -ForegroundColor Green
} catch {
    Write-Host "✗ Node.js is not installed. Please install Node.js from https://nodejs.org/" -ForegroundColor Red
    exit 1
}

try {
    $npmVersion = npm --version
    Write-Host "✓ npm $npmVersion is installed" -ForegroundColor Green
} catch {
    Write-Host "✗ npm is not installed" -ForegroundColor Red
    exit 1
}

# Step 2: Backup existing files if they exist
Write-Host "`n📦 Backing up existing files..." -ForegroundColor Blue
$backupDir = "backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
if (Test-Path $backupDir) {
    Write-Host "Backup directory already exists, skipping..." -ForegroundColor Yellow
} else {
    New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
    if (Test-Path "index.html") {
        Move-Item "index.html" $backupDir -Force
        Write-Host "✓ Backed up index.html" -ForegroundColor Green
    }
    if (Test-Path "*.html") {
        Get-ChildItem -Path "*.html" | Move-Item -Destination $backupDir -Force
    }
}

# Step 3: Initialize Vite React project
Write-Host "`n📦 Initializing React project with Vite..." -ForegroundColor Blue
Write-Host "This may take a few moments..." -ForegroundColor Yellow

# Using npm create with proper Windows syntax
$env:npm_config_yes = "true"
npm create vite@latest . -- --template react

if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Failed to initialize Vite project" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Vite project initialized" -ForegroundColor Green

# Step 4: Install dependencies
Write-Host "`n📦 Installing dependencies..." -ForegroundColor Blue
npm install

if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Failed to install dependencies" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Dependencies installed" -ForegroundColor Green

# Step 5: Install additional dependencies
Write-Host "`n📦 Installing additional packages..." -ForegroundColor Blue
npm install react-router-dom

if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Failed to install react-router-dom" -ForegroundColor Red
    exit 1
}

npm install -D rollup-obfuscator gh-pages

if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Failed to install dev dependencies" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Additional packages installed" -ForegroundColor Green

# Step 6: Create directory structure
Write-Host "`n📁 Creating directory structure..." -ForegroundColor Blue
$directories = @(
    "src\tools",
    "src\components",
    "src\pages",
    ".github\workflows",
    "public"
)

foreach ($dir in $directories) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "✓ Created $dir" -ForegroundColor Green
    }
}

# Step 7: Create example tool structure
Write-Host "`n🔧 Creating example Base64 tool structure..." -ForegroundColor Blue
$toolDir = "src\tools\Base64Tool"
if (-not (Test-Path $toolDir)) {
    New-Item -ItemType Directory -Path $toolDir -Force | Out-Null
    
    # Create placeholder files
    @"
// Base64Tool component
// Replace this with your actual implementation
export default function Base64Tool() {
  return <div>Base64 Tool - Coming Soon</div>;
}
"@ | Out-File -FilePath "$toolDir\Base64Tool.jsx" -Encoding UTF8
    
    @"
/* Base64 Tool Styles */
.base64-tool {
  padding: 20px;
}
"@ | Out-File -FilePath "$toolDir\Base64Tool.css" -Encoding UTF8
    
    @"
// Base64 Tool Utilities
export function encode(text) {
  return btoa(text);
}

export function decode(text) {
  return atob(text);
}
"@ | Out-File -FilePath "$toolDir\Base64Tool.utils.js" -Encoding UTF8
    
    Write-Host "✓ Created Base64Tool example structure" -ForegroundColor Green
}

# Step 8: Update package.json with deploy scripts
Write-Host "`n📝 Updating package.json..." -ForegroundColor Blue
$packageJsonPath = "package.json"
if (Test-Path $packageJsonPath) {
    $packageJson = Get-Content $packageJsonPath -Raw | ConvertFrom-Json
    
    # Add homepage
    $packageJson | Add-Member -NotePropertyName "homepage" -NotePropertyValue "https://amrshah.github.io/POC-Tools" -Force
    
    # Add deploy scripts
    if (-not $packageJson.scripts) {
        $packageJson | Add-Member -NotePropertyName "scripts" -NotePropertyValue @{} -Force
    }
    $packageJson.scripts | Add-Member -NotePropertyName "predeploy" -NotePropertyValue "npm run build" -Force
    $packageJson.scripts | Add-Member -NotePropertyName "deploy" -NotePropertyValue "gh-pages -d dist" -Force
    
    $packageJson | ConvertTo-Json -Depth 10 | Set-Content $packageJsonPath
    Write-Host "✓ Updated package.json" -ForegroundColor Green
}

# Step 9: Git setup
Write-Host "`n🔧 Configuring Git..." -ForegroundColor Blue
if (-not (Test-Path ".git")) {
    git init
    git branch -M main
    Write-Host "✓ Git repository initialized" -ForegroundColor Green
} else {
    Write-Host "✓ Git repository already exists" -ForegroundColor Yellow
}

# Step 10: Create .gitignore if it doesn't exist
if (-not (Test-Path ".gitignore")) {
    Write-Host "`n📝 Creating .gitignore..." -ForegroundColor Blue
    @"
# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*

# Dependencies
node_modules
dist
dist-ssr
*.local

# Editor directories and files
.vscode/*
!.vscode/extensions.json
.idea
.DS_Store
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?

# Build output
build
dist

# Environment variables
.env
.env.local
.env.production
.env.development

# Testing
coverage

# Misc
.cache
.parcel-cache
.npm
.eslintcache

# OS
Thumbs.db

# gh-pages
.gh-pages
"@ | Out-File -FilePath ".gitignore" -Encoding UTF8
    Write-Host "✓ Created .gitignore" -ForegroundColor Green
}

# Step 11: Create a README if it doesn't exist
if (-not (Test-Path "README.md")) {
    Write-Host "`n📝 Creating README.md..." -ForegroundColor Blue
    @"
# POC Tools

Modern React-based collection of POC tools with GitHub Pages deployment.

## Quick Start

``````bash
# Development
npm run dev

# Build
npm run build

# Deploy
npm run deploy
``````

See the setup documentation for more details.
"@ | Out-File -FilePath "README.md" -Encoding UTF8
    Write-Host "✓ Created README.md" -ForegroundColor Green
}

# Step 12: Final instructions
Write-Host "`n" + ("="*60) -ForegroundColor Cyan
Write-Host "✅ Setup complete!" -ForegroundColor Green
Write-Host ("="*60) -ForegroundColor Cyan

Write-Host "`n📋 Next steps:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Copy the configuration files from the artifacts provided:" -ForegroundColor White
Write-Host "   • vite.config.js" -ForegroundColor Gray
Write-Host "   • .github\workflows\deploy.yml" -ForegroundColor Gray
Write-Host "   • src\App.jsx" -ForegroundColor Gray
Write-Host "   • src\App.css" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Create your tools in src\tools\ directory" -ForegroundColor White
Write-Host "   Each tool should have:" -ForegroundColor White
Write-Host "   • ToolName.jsx (React component)" -ForegroundColor Gray
Write-Host "   • ToolName.css (Styles)" -ForegroundColor Gray
Write-Host "   • ToolName.utils.js (Utility functions)" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Run development server:" -ForegroundColor White
Write-Host "   npm run dev" -ForegroundColor Cyan
Write-Host ""
Write-Host "4. Build for production:" -ForegroundColor White
Write-Host "   npm run build" -ForegroundColor Cyan
Write-Host ""
Write-Host "5. Preview production build:" -ForegroundColor White
Write-Host "   npm run preview" -ForegroundColor Cyan
Write-Host ""
Write-Host "6. Deploy to GitHub Pages:" -ForegroundColor White
Write-Host "   npm run deploy" -ForegroundColor Cyan
Write-Host ""
Write-Host "7. Or push to GitHub for automatic deployment:" -ForegroundColor White
Write-Host "   git add ." -ForegroundColor Cyan
Write-Host "   git commit -m 'Initial React setup'" -ForegroundColor Cyan
Write-Host "   git push origin main" -ForegroundColor Cyan
Write-Host ""
Write-Host ("="*60) -ForegroundColor Cyan
Write-Host "🎉 Your POC-Tools project is ready!" -ForegroundColor Green
Write-Host ("="*60) -ForegroundColor Cyan
Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")