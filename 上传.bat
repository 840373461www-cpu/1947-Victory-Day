@echo off
chcp 936 >nul
title FCM 1947 - 上传到 GitHub
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
echo    FCM 1947  --  上传到 GitHub
echo ==========================================
echo.

set "MSG="
set /p "MSG=请输入这次改了什么（直接回车 = 自动用时间）： "
if "%MSG%"=="" set "MSG=更新 %date% %time%"

echo.
echo [1/3] 保存本地改动...
"%GIT%" add .
"%GIT%" commit -m "%MSG%"
echo.

echo [2/3] 先拉取远程最新（防止冲突）...
"%GIT%" -c http.proxy=%PROXY% -c https.proxy=%PROXY% pull
if errorlevel 1 (
    echo.
    echo [提示] 拉取失败：可能是网络/代理问题，或出现冲突。
    echo        把上面的报错截图发给开发者即可。
    echo.
    pause
    exit /b 1
)

echo.
echo [3/3] 上传到 GitHub...
"%GIT%" -c http.proxy=%PROXY% -c https.proxy=%PROXY% push
if errorlevel 1 (
    echo.
    echo [提示] 上传失败：
    echo        1. 确认代理软件正在运行（端口 7897）
    echo        2. 可能没有推送权限，或需要重新登录 GitHub
    echo.
    pause
    exit /b 1
)

echo.
echo [完成] 已上传到 GitHub！
echo.
pause
