## set attribute selection, inheritance and merging
# ================================================

let
  # Import Nixpkgs library functions (needed for recursiveUpdate, attrByPath)
  # Assumes <nixpkgs> points to a Nixpkgs checkout.
  # If using flakes, you'd typically get lib from an input like `nixpkgs.lib`.
  lib = (import <nixpkgs> { }).lib; # Common non-flake way

  # --- Data ---
  defaultConfig = {
    server = {
      host = "localhost";
      port = 8080;
      timeouts = {
        read = 30;
        write = 30;
      };
      logging = true;
    };
    users = {
      default = "guest";
      admin = "root";
    };
    featureFlags = {
      newUI = false;
      betaFeature = false;
    };
  };

  userConfig = {
    server = {
      # Note: 'host' is missing here, will be inherited from default in recursive merge
      port = 9000; # Override default port
      timeouts = {
        # Note: 'read' is missing, will be inherited
        write = 60; # Override default write timeout
      };
      # 'logging' is missing, will be inherited
    };
    # 'users' section is missing, will be inherited entirely
    featureFlags = {
      newUI = true; # Override default flag
      # 'betaFeature' is missing, will be inherited
      extraUserFlag = true; # Add a new flag
    };
    # Add a completely new top-level section
    client = {
      retries = 3;
    };
  };

  # --- Example Function Using Merging ---
  mkConfig =
    # Function accepts an attrset of options
    {
      # Options with default values
      enabled ? false,
      additionalUsers ? [ ], # Note: Renamed from addExtraUsers for clarity
      portOverride ? null, # Allow specific port override, null means don't override via this arg
      base ? defaultConfig, # Base configuration to start from
      overrides ? { }, # User-provided overrides, merged recursively
    }:
    let
      # Perform the recursive merge first - usually the core operation
      mergedConfig = (
        builtins.trace "TRACE: Recursively merging base and overrides" (lib.recursiveUpdate base overrides)
      );

      # --- Illustrative Shallow Merge (Often less useful for deep config) ---
      # Note: This isn't directly used in the final returned structure below,
      #       but shown here for comparison during evaluation trace.
      _shallowMergedForDebug = (
        builtins.trace "TRACE: Shallow merging base and overrides" (base // overrides)
      );
      # If overrides contained { server = { port = 9000; }; }, the // merge
      # would result in a `server` attribute containing *only* { port = 9000; },
      # losing `host` and `timeouts` from the base. `recursiveUpdate` avoids this.

    in
    {
      # Final computed configuration structure
      effectiveConfig =
        # Start with the recursively merged config
        mergedConfig
        # Apply specific function arguments *after* the main merge
        // {
          # Override port if portOverride argument is provided (not null)
          server = mergedConfig.server // (if portOverride != null then { port = portOverride; } else { });
          # Add additional users provided via function argument
          users = mergedConfig.users // {
            inherit additionalUsers;
          };
          # Explicitly set the 'enabled' status from the function argument
          inherit enabled;
        };

      # Include the intermediate merged result for inspection
      debugInfo = {
        intermediateRecursiveMerge = mergedConfig;
        # _shallowMerge = _shallowMergedForDebug; # Could include this too
      };
    };

in
# =====================
# Demonstration Section
# =====================
{
  # === Section 1: Attribute Selection ===
  selectionExamples = {
    # Direct access using dot notation
    hostServer = defaultConfig.server.host; # "localhost"
    defaultUser = defaultConfig.users.default; # "guest"
    readTimeout = defaultConfig.server.timeouts.read; # 30

    # Safe access using `or` for potentially missing keys
    betaFlagOrDefault = defaultConfig.featureFlags.betaFeature or false; # false (exists)
    missingFlagOrDefault = defaultConfig.featureFlags.veryBetaFeature or "not_enabled"; # "not_enabled" (doesn't exist)
    missingUserOrDefault = userConfig.users.admin or "no_admin_override"; # "no_admin_override" (users section missing in userConfig)

    # Safe access using lib.attrByPath for potentially missing paths
    # Path exists:
    safeWriteTimeout = lib.attrByPath [ "server" "timeouts" "write" ] null defaultConfig; # 30
    # Path partially exists, but final element missing:
    safeMissingTimeout = lib.attrByPath [ "server" "timeouts" "connect" ] 99 defaultConfig; # 99 (default)
    # Top-level path element missing:
    safeMissingSection = lib.attrByPath [ "database" "port" ] 5432 defaultConfig; # 5432 (default)
  };

  # === Section 2: Inheritance ===
  inheritanceExamples =
    let
      localPort = 8888;
      localHost = "127.0.0.1";
      sourceSet = {
        enableSSL = true;
        logLevel = "debug";
      };
    in
    {
      # Inherit variables defined in the current `let` scope
      inherit localPort localHost; # Becomes { localPort = 8888; localHost = "127.0.0.1"; }

      # Inherit specific attributes *from another set*
      inherit (sourceSet) enableSSL logLevel; # Becomes { enableSSL = true; logLevel = "debug"; }

      # Combine them
      combined = {
        inherit localPort;
        inherit (sourceSet) logLevel;
      }; # Becomes { localPort = 8888; logLevel = "debug"; }
    };

  # === Section 3: Merging ===
  mergingExamples = {
    # Shallow merge: Right side overwrites entire matching top-level keys.
    # Here, userConfig.server completely replaces defaultConfig.server.
    # userConfig.featureFlags replaces defaultConfig.featureFlags.
    # `client` section is added. `users` section from defaultConfig remains.
    shallowMerged = defaultConfig // userConfig;
    /*
      Expected shallowMerged.server: { port = 9000; timeouts = { write = 60; }; }
      (lost host, timeouts.read, logging from defaultConfig.server)
    */

    # Recursive merge: Values are merged recursively *if both are attrsets*.
    # server.port is overridden. server.timeouts are merged (write overridden, read kept).
    # server.host and server.logging are kept from default.
    # featureFlags are merged. `client` section added. `users` section kept.
    recursiveMerged = lib.recursiveUpdate defaultConfig userConfig;
    /*
      Expected recursiveMerged.server:
      { host = "localhost"; port = 9000; timeouts = { read = 30; write = 60; }; logging = true; }
    */
  };

  # === Section 4: Using the Configuration Function ===
  generatedConfigExample = mkConfig {
    # Pass arguments to our function
    enabled = true;
    additionalUsers = [
      "admin-extra"
      "sysop"
    ];
    portOverride = 9999; # Explicitly override the port via function arg
    overrides = userConfig; # Provide the userConfig as general overrides
  };
  /*
    Explore the structure of generatedConfigExample:
    - generatedConfigExample.effectiveConfig.enabled should be true.
    - generatedConfigExample.effectiveConfig.server.port should be 9999 (due to portOverride).
    - generatedConfigExample.effectiveConfig.server.host should be "localhost" (from defaultConfig via recursive merge).
    - generatedConfigExample.effectiveConfig.users.additionalUsers should be [ "admin-extra" "sysop" ].
    - generatedConfigExample.debugInfo.intermediateRecursiveMerge shows the result before function args were applied.
  */

  # === Section 5: Quick Check Example using 'or' ===
  finalCheck = {
    # Check a value that exists after recursive merge, use 'or' just in case
    finalPort = (lib.recursiveUpdate defaultConfig userConfig).server.port or 0; # Should be 9000
    # Check a value that only exists in userConfig
    clientRetries = (lib.recursiveUpdate defaultConfig userConfig).client.retries or 0; # Should be 3
    # Check a value expected to be missing
    missingValue = (lib.recursiveUpdate defaultConfig userConfig).database.type or "unknown"; # Should be "unknown"
  };

  # === Section 6: Merge if condition is true ===
  service1 =
    let

      baseConfig_1 = {
        enable = true;
        configName = "service1 internals";
        description = "configurations of service1";

      };
    in
    baseConfig_1
    // lib.optionalAttrs (baseConfig_1.enable) {
      additionalConfig = {
        enable = true;
        description = "additional configuration for service2";
      };
    };
}
