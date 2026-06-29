@echo off
REM ── Atolla one-click deploy ───────────────────────────────
REM Double-click this file to push the latest changes to GitHub.
REM Vercel then redeploys the live site automatically.

cd /d "%~dp0"

echo.
echo Pushing latest Atolla site changes to GitHub...
echo.

git add -A
git commit -m "Update site"
git push -u origin main

echo.
echo ------------------------------------------------------------
echo Done. If you saw "nothing to commit", there were no changes.
echo Vercel will redeploy automatically within ~1 minute.
echo ------------------------------------------------------------
echo.
pause
