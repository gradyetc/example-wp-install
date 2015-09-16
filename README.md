
[![Build Status](https://travis-ci.org/mgburns/example-wp-install.svg?branch=staging)](https://travis-ci.org/mgburns/example-wp-install)

This repository is a proof-of-concept WordPress install that demonstrates continous integration and delivery using [Travis CI](https://travis-ci.org/).

The `.travis.yml` configuration:

- Provisions a test environment using [Docker](https://www.docker.com/)
- Runs some simple smoke tests
- Automates deployment via Git if smoke tests pass

Git deployments work as follows:

- Pushes to the `master` branch are deployed to a production remote: https://github.com/mgburns/example-install-prod
- Pushes to the `staging` branch are deployed to a staging remote: https://github.com/mgburns/example-install-staging

A real-world example for this would be pushing to [WP Engine repositories](http://wpengine.com/git/).

