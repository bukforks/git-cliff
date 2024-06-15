#!/usr/bin/env bash
set -e

# Create new git repository in temporary directory
DIR=$(mktemp -d)
cp cliff.toml $DIR
cp expected.md $DIR

cd $DIR
git init .

GIT_COMMITTER_DATE="2021-01-23 01:23:45" git commit --allow-empty -m "feat: add first beta feature"
git tag v1.0.0-beta.1

GIT_COMMITTER_DATE="2021-01-23 01:23:46" git commit --allow-empty -m "feat: add second beta feature"
git tag v1.0.0-beta.2

# WARNING: If we won't create this commit, 1.0.0 won't be created!
#GIT_COMMITTER_DATE="2021-01-23 01:23:47" git commit --allow-empty -m "chore: why do i need a commit here?"
git tag v1.0.0

GIT_COMMITTER_DATE="2021-01-23 01:23:49" git commit --allow-empty -m "fix: simple fix"
git tag v1.0.1

diff --side-by-side --color \
  <(git-cliff) \
  expected.md
