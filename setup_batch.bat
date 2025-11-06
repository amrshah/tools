@echo off
setlocal enabledelayedexpansion

:: POC-Tools React Setup Script for Windows 11 (Batch Version)
echo.
echo ======================================================================
echo    POC-Tools React Setup
echo ======================================================================
echo.

@REM :: Check if Node.js is installed
@REM echo [1/12] Checking prerequisites...
@REM where node >nul 2>nul
@REM if %errorlevel% neq 0 (
@REM     echo [ERROR] Node.js is not installed!
@REM     echo Please install Node.js from https://nodejs.org/
@REM     pause
@REM     exit /b 1
@REM )

@REM node --version
@REM echo [OK] Node.js is installed

@REM where npm >nul 2>nul
@REM if %errorlevel% neq 0 (
@REM     echo [ERROR] npm is not installed!
@REM     pause
@REM     exit /b 1
@REM )

@REM npm --version
@REM echo [OK] npm is installed
@REM echo.

@REM :: Backup existing files
@REM echo [2/12] Backing up existing files...
@REM set BACKUP_DIR=backup_%date:~-4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%
@REM set BACKUP_DIR=%BACKUP_DIR: =0%

@REM if not exist "%BACKUP_DIR%" (
@REM     mkdir "%BACKUP_DIR%"
@REM     if exist "index.html" (
@REM         move "index.html" "%BACKUP_DIR%\" >nul
@REM         echo [OK] Backed up existing files
@REM     )
@REM ) else (
@REM     echo [SKIP] Backup directory already exists
@REM )
@REM echo.

:: Initialize Vite React project
echo [3/12] Initializing React project with Vite...
echo This may take a few moments...
call npm create vite@latest . -- --template react
if %errorlevel% neq 0 (
    echo [ERROR] Failed to initialize Vite project
    pause
    exit /b 1
)
echo [OK] Vite project initialized
echo.

:: Install dependencies
echo [4/12] Installing dependencies...
call npm install
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)
echo [OK] Dependencies installed
echo.

:: Install additional dependencies
echo [5/12] Installing react-router-dom...
call npm install react-router-dom
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install react-router-dom
    pause
    exit /b 1
)
echo [OK] react-router-dom installed
echo.

echo [6/12] Installing dev dependencies...
call npm install -D rollup-obfuscator gh-pages
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dev dependencies
    pause
    exit /b 1
)
echo [OK] Dev dependencies installed
echo.

:: Create directory structure
echo [7/12] Creating directory structure...
if not exist "src\tools" mkdir "src\tools"
if not exist "src\components" mkdir "src\components"
if not exist "src\pages" mkdir "src\pages"
if not exist ".github\workflows" mkdir ".github\workflows"
if not exist "public" mkdir "public"
echo [OK] Directory structure created
echo.

:: Create example tool structure
echo [8/12] Creating example Base64 tool...
if not exist "src\tools\Base64Tool" (
    mkdir "src\tools\Base64Tool"
    
    echo // Base64Tool component > "src\tools\Base64Tool\Base64Tool.jsx"
    echo export default function Base64Tool() { >> "src\tools\Base64Tool\Base64Tool.jsx"
    echo   return ^<div^>Base64 Tool^</div^>; >> "src\tools\Base64Tool\Base64Tool.jsx"
    echo } >> "src\tools\Base64Tool\Base64Tool.jsx"
    
    echo /* Base64 Tool Styles */ > "src\tools\Base64Tool\Base64Tool.css"
    echo .base64-tool { padding: 20px; } >> "src\tools\Base64Tool\Base64Tool.css"
    
    echo // Base64 utilities > "src\tools\Base64Tool\Base64Tool.utils.js"
    echo export function encode(text) { return btoa(text); } >> "src\tools\Base64Tool\Base64Tool.utils.js"
    
    echo [OK] Base64Tool structure created
) else (
    echo [SKIP] Base64Tool already exists
)
echo.

:: Git setup
echo [9/12] Configuring Git...
if not exist ".git" (
    git init
    git branch -M main
    echo [OK] Git repository initialized
) else (
    echo [OK] Git repository already exists
)
echo.

:: Create .gitignore
echo [10/12] Creating .gitignore...
if not exist ".gitignore" (
    (
        echo # Dependencies
        echo node_modules
        echo dist
        echo dist-ssr
        echo *.local
        echo.
        echo # Editor
        echo .vscode
        echo .idea
        echo .DS_Store
        echo.
        echo # Environment
        echo .env
        echo .env.local
        echo .env.production
        echo.
        echo # Build
        echo build
        echo coverage
        echo.
        echo # Misc
        echo .cache
        echo .npm
        echo Thumbs.db
        echo .gh-pages
    ) > ".gitignore"
    echo [OK] .gitignore created
) else (
    echo [SKIP] .gitignore already exists
)
echo.

:: Create basic README
echo [11/12] Creating README.md...
if not exist "README.md" (
    (
        echo # POC Tools
        echo.
        echo Modern React-based collection of POC tools.
        echo.
        echo ## Quick Start
        echo.
        echo ```bash
        echo npm run dev
        echo npm run build
        echo npm run deploy
        echo ```
    ) > "README.md"
    echo [OK] README.md created
) else (
    echo [SKIP] README.md already exists
)
echo.

:: Final message
echo [12/12] Setup complete!
echo.
echo ======================================================================
echo    Next Steps
echo ======================================================================
echo.
echo 1. Copy configuration files:
echo    - vite.config.js
echo    - .github\workflows\deploy.yml
echo    - src\App.jsx
echo    - src\App.css
echo.
echo 2. Create your tools in src\tools\
echo.
echo 3. Run development server:
echo    npm run dev
echo.
echo 4. Build for production:
echo    npm run build
echo.
echo 5. Deploy to GitHub Pages:
echo    npm run deploy
echo.
echo 6. Or push to GitHub:
echo    git add .
echo    git commit -m "Initial setup"
echo    git push origin main
echo.
echo ======================================================================
echo    Setup Complete!
echo ======================================================================
echo.
pause