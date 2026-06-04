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

NAME=${1:-"Co-Author"}
EMAIL=${2:-"coauthor@example.com"}
BRANCH="pair-$TS"
git checkout -b $BRANCH
echo "pair" > pair.txt
git add pair.txt
git commit -m "Pair commit\n\nCo-authored-by: $NAME <$EMAIL>"
git push -u origin $BRANCH
PR_URL=$(gh pr create --title "Pair PR $TS" --body "Pair Extraordinaire via code-wizard")
gh pr merge "$PR_URL" --merge --admin
echo "Success! Checked your profile for Pair Extraordinaire: https://github.com/xb1jaa?tab=achievements"
