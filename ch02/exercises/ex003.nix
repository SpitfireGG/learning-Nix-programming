# Exercise 002: Fix Nested Set Access
# Goal: Correct the access path to retrieve a value from a nested set.

let
  config = {
    server = {
      host = "127.0.0.1";
      port = 8080;
    };
    client = {
      timeout = 30; # in sec
    };
    featureFlags = {
      newUI = true;
      betaFeature = false;
    };
  };

  # TODO: Replace `null` with the correct expression to access the server's port number from the `config` set.
  extractedPort = null; # <-- Fix this line

in
assert extractedPort == 8080;

# result if the assertion passes
true
