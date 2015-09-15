#!/bin/bash

# Declare a global to track failed assertions
FAILURES=0

SITE_URL=${WORDPRESS_SITE_URL-http://example-install.local}

echo "Running smoke tests against '$SITE_URL'..."

#
# Assert that a string is contained within another
#
function assertContains {
  local expected="$1"
  local actual="$2"

  if [[ "$actual" != *"$expected"* ]]; then
    echo -n "F"
    let FAILURES+=1
  else
    echo -n "."
  fi
}

home="$(curl -v $SITE_URL 2>&1)"
post_json="$(curl -v $SITE_URL/wp-json/wp/v2/posts/1 2>&1)"
private_post_json="$(curl -v -u admin:password $SITE_URL/wp-json/wp/v2/posts/4 2>&1)"

assertContains "HTTP/1.1 200 OK" "$home"
assertContains "HTTP/1.1 200 OK" "$post_json"

assertContains "<meta name=\"generator\" content=\"WordPress 4.3.1\" />" "$home"
assertContains "\"title\":{\"rendered\":\"Hello world!\"}" "$post_json"
assertContains "\"title\":{\"rendered\":\"Private: Hello secret world!\"}" "$private_post_json"

echo

# Return code = # of test failures
exit $FAILURES

