# Exercise 001: Fix Basic Definition and Access
# Goal: Correct the set definition and attribute access.

let
  # TODO: 
  # Fix this set definition. It should have:
  #       - 'name' (string) = "nixsoup"
  #       - 'version' (string) = "2.18"
  #       - 'isFun' (boolean) = true
  packageInfo = {
    name = 69;

    version = null; # replace null to be a version string

    # Incorrect attribute name below! Fix it.
    is_fun = true;
  };

in
# TODO:
# Make both assertions below true by fixing the 'packageInfo' set above.
# The assert keyword checks if a condition is true. If not, evaluation aborts.
# assert <condition>; <result-if-true>

assert packageInfo.version == "2.18";
assert packageInfo.isFun == true;

# If both assertions pass, the result is true.
true
