#!/usr/bin/env bash
# Publish Area Guide to GitHub Pages.
# Run: ./publish.sh
#
# First run: initialises git, adds remote, force-pushes to main.
# Subsequent runs: adds changes, commits, pushes.

set -euo pipefail

REPO_URL="git@github.com:rambuttri/rental-bot-area-guide.git"
# HTTPS fallback (in case SSH keys not set up):
REPO_URL_HTTPS="https://github.com/rambuttri/rental-bot-area-guide.git"

cd "$(dirname "$0")"

if [ ! -d .git ]; then
    echo "▶ First-time init..."
    git init -b main
    git add .
    git commit -m "Initial Area Guide"

    # Try SSH first, fall back to HTTPS.
    if git ls-remote "$REPO_URL" &>/dev/null; then
        git remote add origin "$REPO_URL"
    else
        echo "▶ SSH not configured, using HTTPS. You'll be asked for GitHub credentials."
        git remote add origin "$REPO_URL_HTTPS"
    fi

    git push -u origin main
    echo ""
    echo "✅ Pushed. Now enable Pages:"
    echo "   https://github.com/rambuttri/rental-bot-area-guide/settings/pages"
    echo "   Source = Deploy from a branch, Branch = main / root"
    exit 0
fi

# Subsequent runs
if git diff --quiet && git diff --cached --quiet; then
    echo "Nothing to commit."
    exit 0
fi

git add .
git commit -m "Update area guide ($(date +%Y-%m-%d))"
git push origin main
echo ""
echo "✅ Deployed — live in ~30s at:"
echo "   https://rambuttri.github.io/rental-bot-area-guide/"
