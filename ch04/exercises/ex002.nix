ex002:
let
  # Task: Define the configureService function
  # - Takes a single attribute set argument.
  # - Uses @-pattern to capture the input as 'allArgs'.
  # - Arguments:
  #   - serviceName: string, REQUIRED
  #   - port: int, default 8080
  #   - enabled: bool, default true
  #   - userData: any, default null
  #   - ... : allows extra arguments
  # - Returns an attrset: { id, status, config = { listenPort, customData }, rawInput, hasApiKey }
  configureService = # --- Your Code Here ---

    # ... args ...

    { }@allArgs:
    {
      # You need to fill in the function signature above and the body below.
      id = "Fix Me";
      status = "Fix Me";
      config = {
        listenPort = 0; # Fix Me
        customData = null; # Fix Me
      };
      rawInput = { }; # Fix Me
      hasApiKey = false; # Fix Me
    };

in
{
  # Test calls (Do not modify this part)
  config1 = configureService {
    serviceName = "webserver";
    port = 9000;
  };

  config2 = configureService {
    serviceName = "database";
    enabled = false;
    userData = {
      user = "admin";
    };
    apiKey = "xyz123"; # Extra argument, should be handled
  };

  config3 = configureService { serviceName = "default-service"; };

  # Edge Case: Missing required argument. This *should* cause an evaluation error.
  # If Nix evaluates this without error, the function isn't enforcing required args correctly.
  # We assign a placeholder; the error should prevent this assignment.
  errorCase =
    (builtins.trace) configureService
      {
        port = 1234;
      } # Missing serviceName
      "error"; # Catch the expected error for testing purposes
}
