#!/bin/bash
REMOTE_URL=$(git config --get remote.origin.url)

# Get repo name
if [[ $REMOTE_URL == git@github.com:* ]]; then
  REPO_PATH=$(echo $REMOTE_URL | sed -E 's/git@github.com:(.*)\.git/\1/')
elif [[ $REMOTE_URL == https://github.com/* ]]; then
  REPO_PATH=$(echo $REMOTE_URL | sed -E 's|https://github.com/([^ ]+)\.git|\1|')
else
  echo "Not a GitHub repository"
  exit 1
fi

# Get the current branch name
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

# Construct the PR URL
PR_URL="https://github.com/$REPO_PATH/pull/new/$BRANCH_NAME"

# Open in Chrome (macOS & Linux support)
if command -v google-chrome &> /dev/null; then
  google-chrome "$PR_URL"
elif command -v google-chrome-stable &> /dev/null; then
  google-chrome-stable "$PR_URL"
elif command -v open &> /dev/null; then
  open "$PR_URL"  # macOS
else
  echo "Could not find Chrome. Copy this link to your browser:"
  echo "$PR_URL"
fi
