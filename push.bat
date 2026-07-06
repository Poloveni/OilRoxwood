@echo off
rem ============================================
rem  Oil Roxwood - commit + push en un clic
rem  Usage : double-clic, ou "push.bat mon message"
rem ============================================
cd /d "%~dp0"

set MSG=%*
if "%MSG%"=="" set MSG=MAJ Oil Roxwood %date% %time:~0,5%

echo.
echo === Etat du depot ===
git status --short

echo.
echo === Commit : "%MSG%" ===
git add -A
git commit -m "%MSG%"

echo.
echo === Push vers GitHub ===
git push

echo.
echo === Termine ! Le site se met a jour dans ~1 minute ===
echo     https://poloveni.github.io/OilRoxwood/
echo.
pause
