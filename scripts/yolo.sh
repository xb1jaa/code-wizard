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

git checkout -b yolo-$TS
echo "yolo" >> yolo.txt
git add yolo.txt && git commit -m "yolo commit"
git push -u origin yolo-$TS
PR_URL=$(gh pr create --title "YOLO PR $TS" --body "YOLO update for code-wizard")
gh pr merge "$PR_URL" --merge --admin
echo "Success! Checked your profile for YOLO: https://github.com/xb1jaa?tab=achievements"
