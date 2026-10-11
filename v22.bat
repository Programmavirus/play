@echo off
chcp 1251 >nul
title Угадай число
color 0A
setlocal enabledelayedexpansion

:start
cls
set /a secret=%random% %% 100 + 1
set /a tries=0
echo ============================================
echo        ИГРА: УГАДАЙ ЧИСЛО (1..100)
echo ============================================
echo.

:loop
set /p guess=Ваш вариант: 
set /a tries+=1

if not defined guess goto loop

echo %guess%| findstr /r "^[0-9][0-9]*$" >nul
if errorlevel 1 (
    echo Только число, пожалуйста.
    goto loop
)

if %guess% LSS 1 goto bad
if %guess% GTR 100 goto bad

if %guess% EQU %secret% goto win
if %guess% LSS %secret% (
    echo Мало! Попробуй больше.
) else (
    echo Много! Попробуй меньше.
)
goto loop

:bad
echo Диапазон: от 1 до 100.
goto loop

:win
color 0B
echo.
echo *** ПОБЕДА! ***
echo Число: %secret%
echo Попыток: %tries%
echo.
set /p again=Играть снова? (y/n): 
if /i "%again%"=="y" goto start
color 07
endlocal