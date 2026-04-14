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
fi

# Ensure a remote exists.
if ! git remote | grep -q '^origin$'; then
    if git ls-remote "$REPO_URL" &>/dev/null; then
        git remote add origin "$REPO_URL"
    else
        echo "▶ SSH not configured, using HTTPS. You'll be asked for GitHub credentials."
        git remote add origin "$REPO_URL_HTTPS"
    fi
fi

# Stage + commit any new changes (no-op if nothing changed).
git add .
if ! git diff --cached --quiet; then
    git commit -m "Update area guide ($(date +%Y-%m-%d))"
fi

# Push. If remote repo doesn't exist yet, give a helpful message.
if ! git push -u origin main 2>&1 | tee /tmp/publish-push.log; then
    if grep -q "Repository not found" /tmp/publish-push.log; then
        echo ""
        echo "❌ GitHub repo not found yet."
        echo "   1. Create it empty at: https://github.com/new"
        echo "      Name: rental-bot-area-guide — Public — no README/license."
        echo "   2. Re-run:  ./publish.sh"
        exit 1
    fi
    exit 1
fi

echo ""
echo "✅ Deployed — live in ~30s at:"
echo "   https://rambuttri.github.io/rental-bot-area-guide/"
echo ""
echo "   First time? Enable Pages:"
echo "   https://github.com/rambuttri/rental-bot-area-guide/settings/pages"
echo "   Source = Deploy from a branch, Branch = main / root"
echo ""
echo "✅ Deployed — live in ~30s at:"
echo "   https://rambuttri.github.io/rental-bot-area-guide/"
