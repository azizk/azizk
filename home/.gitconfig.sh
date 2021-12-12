#!/bin/bash

cmd=$1
shift

case $cmd in
stash-index)
  if git diff --cached --exit-code --quiet; then
    echo 'Nothing staged to stash as a branch!'
    exit 1
  else
    CURRENT_BRANCH=$(git branch --show-current)
    git checkout -b "stash/$CURRENT_BRANCH--$(date +%Y-%M-%dT%H-%M-%S)" \
    && git commit -m "WIP: $(git log --oneline -n 1 HEAD)" \
    && git checkout "$CURRENT_BRANCH"
  fi
  ;;
rmtag)
  git push origin ":refs/tags/$1"
  git tag -d "$1"
  ;;
esac
