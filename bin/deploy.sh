#!/bin/bash

set -ev

# Decrypt production deploy key
openssl aes-256-cbc -K $encrypted_3e45b6eb88b7_key -iv $encrypted_3e45b6eb88b7_iv -in .travis/prod.pem.enc -out .travis/prod.pem -d

# Start SSH agent and add deploy key (must have push access to repos below)
eval "$(ssh-agent -s)"
chmod 600 .travis/prod.pem
ssh-add .travis/prod.pem

# Add remote and deploy
git remote add deploy git@github.com:mgburns/example-install-prod.git
git push deploy master

