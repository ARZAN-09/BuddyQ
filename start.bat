@echo off
title BuddyQ Voice Assistant

echo ================================================================================
echo BuddyQ Voice Assistant - Starting
echo ================================================================================
echo.

REM ----------------------------------------------------------------------
REM 0) Change to BuddyQ root folder
REM ----------------------------------------------------------------------
cd /d D:\A1_projects\BuddyQ

REM ----------------------------------------------------------------------
REM 1) Use system Python
REM ----------------------------------------------------------------------
set "PYTHON_EXE=python"

REM Quick sanity check
%PYTHON_EXE% -c "import sys; print('Using Python:', sys.executable)" 2>nul
if errorlevel 1 (
    echo ERROR: Python not found.
    pause
    exit /b 1
)

REM ----------------------------------------------------------------------
REM 2) Ensure required packages
REM ----------------------------------------------------------------------
%PYTHON_EXE% -c "import faster_whisper, sounddevice, numpy, mss, PIL" 2>nul
if errorlevel 1 (
    echo Installing missing packages...
    %PYTHON_EXE% -m pip install faster-whisper sounddevice numpy mss pillow
    echo.
)

echo [1/3] Environment checked
echo.

REM ----------------------------------------------------------------------
REM 3) Set environment variables
REM ----------------------------------------------------------------------
set "HF_HOME=D:\A1_projects\BuddyQ\stt\model_cache"
set "HF_HUB_DISABLE_SYMLINKS_WARNING=1"
set "PYTHONPATH=D:\A1_projects\BuddyQ\core"

echo [2/3] Configuration set
echo.

echo [3/3] Starting assistant...
echo.

REM ----------------------------------------------------------------------
REM 4) Run main
REM ----------------------------------------------------------------------
%PYTHON_EXE% core\main.py

if errorlevel 1 (
    echo.
    echo ================================================================================
    echo ERROR: main.py exited with an error
    echo ================================================================================
    pause
    exit /b 1
)

echo.
echo ================================================================================
echo BuddyQ Voice Assistant - Stopped
echo ================================================================================
pause