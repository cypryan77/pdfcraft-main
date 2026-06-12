@echo off
REM ============================================================
REM  PDFCraft - Local launcher for Windows
REM  Double-click this file to build (first time) and run the
REM  PDF tools locally in your browser.
REM ============================================================
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo.
echo ============================================================
echo    PDFCraft - local launcher
echo ============================================================
echo.

REM --- 1. Check Node.js is installed -------------------------
where node >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Node.js was not found on this computer.
  echo.
  echo PDFCraft is a Next.js web app and needs Node.js to build.
  echo Please install the LTS version from:
  echo     https://nodejs.org/
  echo Then double-click this file again.
  echo.
  pause
  exit /b 1
)

for /f "delims=" %%v in ('node --version') do set NODEV=%%v
echo Using Node.js !NODEV!
echo.

REM --- 2. Install dependencies (first run only) --------------
if not exist "node_modules" (
  echo Installing dependencies for the first time. This can take a few minutes...
  call npm install
  if errorlevel 1 (
    echo [ERROR] npm install failed. See the messages above.
    pause
    exit /b 1
  )
) else (
  echo Dependencies already installed - skipping npm install.
)
echo.

REM --- 3. Build the static site (creates the out\ folder) ----
if not exist "out\index.html" (
  echo Building the site. The first build generates 2000+ pages and
  echo can take several minutes. Please wait...
  call npm run build
  if errorlevel 1 (
    echo [ERROR] Build failed. See the messages above.
    pause
    exit /b 1
  )
) else (
  echo Build already exists in the out\ folder - skipping build.
  echo Delete the out\ folder if you want to rebuild from scratch.
)
echo.

REM --- 4. Serve the out\ folder and open the browser --------
echo Starting a local web server on http://localhost:3000
echo Your browser will open automatically.
echo.
echo    Keep this window OPEN while you use PDFCraft.
echo    Close it (or press Ctrl+C) when you are done.
echo.
start "" "http://localhost:3000/"
call npx --yes serve out -l 3000

pause
