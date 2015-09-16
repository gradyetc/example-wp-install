#!/bin/bash
#
# Custom deploy script for Travis CI: http://docs.travis-ci.com/user/deployment/script/
#
# This script will force push updates to this repository to one or more remote deployment repos (e.g. WP Engine).
#
# 1. Map branches in the source repository to one or more remote repositories
# 2. Add (encrypted!) deploy keys with write access for each target repository to the `.travis` directory. (See http://docs.travis-ci.com/user/encrypting-files/).
# 3. Set the deployment variables according to your needs.
#

set -ev

# Setup deployment variables based on branch that triggered this build
if [ "$TRAVIS_BRANCH" == "master" ]; then
  DEPLOY_ENV=prod
  DEPLOY_KEYFILE_IN=.travis/$DEPLOY_ENV.pem.enc
  DEPLOY_KEYFILE_OUT=.travis/$DEPLOY_ENV.pem
  DEPLOY_KEYFILE_DECRPYT_KEY=$encrypted_3e45b6eb88b7_key
  DEPLOY_KEYFILE_DECRPYT_IV=$encrypted_3e45b6eb88b7_iv
  DEPLOY_GIT_URL=git@github.com:mgburns/example-install-$DEPLOY_ENV.git
  DEPLOY_GIT_SRC_BRANCH=$TRAVIS_BRANCH
  DEPLOY_GIT_DEST_BRANCH=master
else
  DEPLOY_ENV=staging
  DEPLOY_KEYFILE_IN=.travis/$DEPLOY_ENV.pem.enc
  DEPLOY_KEYFILE_OUT=.travis/$DEPLOY_ENV.pem
  DEPLOY_KEYFILE_DECRPYT_KEY=$encrypted_8405297456b8_key
  DEPLOY_KEYFILE_DECRPYT_IV=$encrypted_8405297456b8_iv
  DEPLOY_GIT_URL=git@github.com:mgburns/example-install-$DEPLOY_ENV.git
  DEPLOY_GIT_SRC_BRANCH=$TRAVIS_BRANCH
  DEPLOY_GIT_DEST_BRANCH=master
fi

echo "Starting deployment to environment: $DEPLOY_ENV"

# Decrypt production deploy key
openssl aes-256-cbc -K $DEPLOY_KEYFILE_DECRYPT_KEY -iv $DEPLOY_KEYFILE_DECRYPT_IV -in $DEPLOY_KEYFILE_IN -out $DEPLOY_KEYFILE_OUT -d

# Start SSH agent and add deploy key (must have push access to repos below)
eval "$(ssh-agent -s)"
chmod 600 $DEPLOY_KEYFILE_OUT
ssh-add $DEPLOY_KEYFILE_OUT

# Add remote and deploy
git remote add deploy $DEPLOY_GIT_URL
git push -f deploy $DEPLOY_GIT_SRC_BRANCH:$DEPLOY_GIT_DEST_BRANCH

