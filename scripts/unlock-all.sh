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

echo "Select code-wizard operation: 1) Full Blast 2) Exit"
read -p "> " opt
if [ "$opt" == "1" ]; then
  ./scripts/quickdraw.sh
  ./scripts/yolo.sh
  ./scripts/publicist.sh
  ./scripts/pull-shark.sh 2
fi
