#!/bin/bash
if ! gh auth status &>/dev/null; then
  echo "You are not authenticated with GitHub CLI."
  echo "Fix: Run 'gh auth login' first."
  exit 1
fi
REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null)
if [ -z "$REPO" ]; then
  echo "Could not detect GitHub repository. Make sure you have pushed this to a remote."
  exit 1
fi
echo "Working on repository: $REPO"
TS=$(date +%s)

git tag v1.0.$TS
git push origin v1.0.$TS
gh release create v1.0.$TS --title "code-wizard Release v1.0.$TS" --notes "First public release"
echo "Success! Checked your profile for Publicist: https://github.com/xb1jaa?tab=achievements"
