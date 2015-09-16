
[![Build Status](https://travis-ci.org/mgburns/example-wp-install.svg?branch=master)](https://travis-ci.org/mgburns/example-wp-install)

This repository is a proof-of-concept WordPress install that demonstrates continous integration and delivery using [Travis CI](https://travis-ci.org/).

The `.travis.yml` configuration:

- Provisions a test environment using [Docker](https://www.docker.com/)
- Runs some simple smoke tests
- Automates deployment via Git if smoke tests pass

Git deployments work as follows:

- Pushes to the `master` branch are deployed to a production remote: https://github.com/mgburns/example-install-prod
- Pushes to the `staging` branch are deployed to a staging remote: https://github.com/mgburns/example-install-staging

A real-world example for this would be pushing to [WP Engine repositories](http://wpengine.com/git/).

## Development Workflow

1. Use master branches of custom plugins / themes being developed for this site in the `staging` branch. Update plugins / themes as they are ready for staging deployment.
2. Once changes are reviewed and approved in the staging environment, merge `staging` to `master` and push to trigger testing and deployment to production environment.

