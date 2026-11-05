@echo off
chcp 936 >nul
title FCM 1947 - GitHub 更新
cd /d "%~dp0"

set "GIT=C:\Program Files\Git\cmd\git.exe"
set "PROXY=http://127.0.0.1:7897"

if not exist "%GIT%" (
    echo.
    echo [错误] 没找到 Git，请确认它装在 C:\Program Files\Git
    echo.
    pause
    exit /b 1
)

echo ==========================================
echo    FCM 1947  --  从 GitHub 拉取新版本
echo ==========================================
echo.

echo [1/3] 先保存你本地的改动...
"%GIT%" add .
"%GIT%" commit -m "自动保存"
echo.

echo [2/3] 从 GitHub 拉取新版本...
"%GIT%" -c http.proxy=%PROXY% -c https.proxy=%PROXY% pull
if errorlevel 1 (
    echo.
    echo [提示] 没拉成功。多半是网络或代理的问题：
    echo        1. 确认你的代理软件正在运行（端口 7897）
    echo        2. 如果代理端口不是 7897，右键本文件 -> 编辑，改上面的 PROXY 那一行
    echo.
    pause
    exit /b 1
)

echo.
echo [3/3] 完成！
echo.
echo ------------------------------------------
echo  如果拉完游戏崩溃或出问题，打开 Git Bash 执行：
echo      git reset --hard backup-before-pull
echo ------------------------------------------
echo.
pause
