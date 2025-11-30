# PowerShell script to set up GitHub fork and push
# Instructions:
# 1. Go to https://github.com/mod-playerbots/azerothcore-wotlk
# 2. Click "Fork" button to create your own fork
# 3. Replace YOUR_GITHUB_USERNAME below with your actual GitHub username
# 4. Run this script: .\setup_github_fork.ps1

$githubUsername = "YOUR_GITHUB_USERNAME"  # CHANGE THIS!

Write-Host "Setting up GitHub fork remote..." -ForegroundColor Cyan

# Add your fork as a new remote
git remote add fork "https://github.com/$githubUsername/azerothcore-wotlk.git"

# Verify remotes
Write-Host "`nCurrent remotes:" -ForegroundColor Yellow
git remote -v

Write-Host "`nTo push to your fork, run:" -ForegroundColor Green
Write-Host "  git push fork Playerbot" -ForegroundColor White

Write-Host "`nOr to push all branches:" -ForegroundColor Green
Write-Host "  git push fork --all" -ForegroundColor White

