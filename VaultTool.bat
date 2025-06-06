@echo off
title Sky's Juice WRLD Vault Tool (v1.0)

:menu
cls
echo =================================
echo Sky's Juice WRLD Vault Tool (v1.0)
echo =================================
echo Please select a task:
echo.
echo 1. Show Recent Updates
echo 2. Download Recent Files From The Vault
echo 3. Open The Vault In Your Browser
echo 4. Exit
echo =================================

set /p choice="Enter your choice (1-4): "
if "%choice%"=="1" goto task1
if "%choice%"=="2" goto task2
if "%choice%"=="3" goto task3
if "%choice%"=="4" exit /b
echo Invalid choice. Press any key to return to the menu.
pause > nul
goto menu

:task1
cls
echo ###############################################################
echo ## 1. Recent Updates
echo ###############################################################
echo.

:: 1. Check for the dependency (curl) BEFORE we try to use it.
where curl >nul 2>&1
if errorlevel 1 (
    echo --------------------------------------------------------------------
    echo ERROR: cURL is not installed or accessible on your system.
    echo This feature cannot continue.
    echo --------------------------------------------------------------------
    echo.
    pause
    goto menu
)

echo Attempting to download the latest updates from GitHub Gist...
echo Please wait...
echo.

:: 2. Prepare the link and attempt the download.
set "baseLink=https://gist.githubusercontent.com/TakeablesOnGit/5c630ffb503f47c8421e6bed2264dcc4/raw/updates.txt"
set "gistLink=%baseLink%?v=%RANDOM%"

if exist "updates.txt" del "updates.txt" > nul 2>&1
curl -s -o "updates.txt" "%gistLink%"

:: 3. Check if the download was successful by seeing if the file now exists.
if exist "updates.txt" (
    :: SUCCESS! The file was downloaded. Now we can show it and ask the user.
    echo --- LATEST UPDATES ---
    type "updates.txt"
    echo --------------------
    echo.
    set "keepFile="
    set /p keepFile="Would you like to keep the updates file for future reference? (Y/N): "

    if /i "%keepFile%"=="N" (
        del "updates.txt" > nul 2>&1
        echo The updates file has been deleted.
    ) else (
        echo The updates file has been saved as "updates.txt" in the current directory.
    )

) else (
    :: FAILURE! The file was not downloaded.
    echo --------------------------------------------------------------------
    echo  ERROR: Could not retrieve updates from the GitHub Gist link.
    echo  The link may be incorrect, or there may be a network issue.
    echo  Please verify the link in the script and ensure your internet connection is active.
    echo --------------------------------------------------------------------
)

echo.
pause
goto menu

:task2
cls
echo Attempting to open the recent updates in your browser...
set "openInBrowserRecent="
set /p openInBrowserRecent="Would you like to open the recent updates in the vault in your browser? (Y/N): "
if /i "%openInBrowserRecent%"=="N" (
    echo You can manually visit the vault at:
    echo https://mega.nz/folder/mvYykSTZ#0CctBR1_qeqP-hw1LhzCag 
    pause
    goto menu

    ) else (
        start https://mega.nz/folder/mvYykSTZ#0CctBR1_qeqP-hw1LhzCag
        goto menu
    )
echo.
pause
goto menu

:task3
cls
echo Attempting to open the vault in your browser...
set "openInBrowser="
set /p openInBrowser="Would you like to open the vault in your browser? (Y/N): "
if /i "%openInBrowser%"=="N" (
    echo You can manually visit the vault at:
    echo https://mega.nz/folder/OvAwEaTD#sje02LTHFimEK4aH2RW7QA 
    pause
    goto menu

    ) else (
        start https://mega.nz/folder/OvAwEaTD#sje02LTHFimEK4aH2RW7QA
        goto menu
    )
echo.
pause
goto menu