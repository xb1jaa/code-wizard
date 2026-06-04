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

ISSUE_URL=$(gh issue create --title "Quickdraw Issue $TS" --body "Testing quickdraw for code-wizard")
gh issue close "$ISSUE_URL"
echo "Success! Checked your profile for Quickdraw: https://github.com/xb1jaa?tab=achievements"
