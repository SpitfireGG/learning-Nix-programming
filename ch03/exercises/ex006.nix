# ex006:
# Goal: Use optional/optionals and filter mixed lists correctly for type-checking

let
  lib = import <nixpkgs/lib>;

  config = {
    enableLogging = true;
    enableMetrics = false;
    adminUser = "sysadmin";
    powerUsers = [ "dev1" "dev2" ];
  };

  mixedData = [ 10 "hello" null { type = "data"; } true 20 ];
in
# TODO: Fix the logic using optional/optionals and filters.

# Assertion 1: Build a list of active components. Include "logger" only if enableLogging is true.
components = [ "core" ] ++ (lib.optional config.enableLogging "logger"); # <-- Fix condition or value
assert components == [ "core" "logger" ];

# Assertion 2: Build a list of users. Include powerUsers only if enableMetrics is *false*.
users = [ config.adminUser ] ++ (lib.optionals (!config.enableMetrics) config.powerUsers); # <-- Fix condition or list
assert users == [ "sysadmin" "dev1" "dev2" ];

# Assertion 3: Filter the mixedData list to get only the numbers.
# Hint: Use builtins.isInt
numbersOnly = builtins.filter builtins.isInt mixedData;
assert numbersOnly == [ 10 20 ];

# Assertion 4: Filter the mixedData list to get only the attribute set.
setsOnly = builtins.filter builtins.isAttrs mixedData; # <-- Use the correct is* function
assert setsOnly == [ { type = "data"; } ];

true 
