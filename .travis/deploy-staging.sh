#!/bin/bash

set -ev

# Decrypt staging deploy key
openssl aes-256-cbc -K $encrypted_8405297456b8_key -iv $encrypted_8405297456b8_iv -in .travis/staging.pem.enc -out .travis/staging.pem -d

# Start SSH agent and add deploy key (must have push access to repos below)
eval "$(ssh-agent -s)"
chmod 600 .travis/staging.pem
ssh-add .travis/staging.pem

# Add remote and deploy
git remote add deploy git@github.com:mgburns/example-install-staging.git
git push -f deploy $TRAVIS_BRANCH:master

