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

COUNT=${1:-2}
for i in $(seq 1 $COUNT); do
  BRANCH="pull-shark-$TS-$i"
  git checkout -b $BRANCH
  echo "$i" > "pull-shark-$TS-$i.txt"
  git add .
  git commit -m "Pull Shark $i"
  git push -u origin $BRANCH
  PR_URL=$(gh pr create --title "Pull Shark $TS-$i" --body "Pull Shark automation for code-wizard")
  gh pr merge "$PR_URL" --merge --admin
  git checkout main
done
echo "Success! Checked your profile for Pull Shark: https://github.com/xb1jaa?tab=achievements"
