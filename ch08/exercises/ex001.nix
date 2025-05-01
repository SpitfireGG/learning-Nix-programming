# ex001:
# read the instructions carefully, comment out all the code and work on one exercise then uncomment the preeciding ones

let
  lib = import <nixpkgs/lib>;

  # Helper value for some exercises
  sampleSet = { name = "Nix"; version = "2.18"; cool = true; };

in
{
  # Exercise 1: Basic Trace - Fill in the trace message
  # Goal: Trace should execute, expression should return true.
  exercise1 =
    let
      message = /* ??? */; # Provide a non-empty string message here, what ever preferred
    in
      builtins.trace message true;

  # Exercise 2: Fix traceVal usage
  # Goal: traceVal should execute and the comparison should yield true.
  exercise2 =
    let
      tracedValue = lib.debug.traceval "Tracing the number 5:" 5; # <- Typo here!
    in
      tracedValue == 5; # Check if the original value is returned

  # Exercise 3: Complete traceValFn
  # Goal: Format the sampleSet using toJSON within traceValFn, compare returned value.
  exercise3 =
    let
      formatFn = v: /* ??? */; # Use builtins.toJSON here to format 'v' in the trace message
      tracedSet = lib.debug.traceValFn formatFn sampleSet;
    in
      tracedSet == sampleSet; # Check if the original set is returned

  # Exercise 4: Fix the Assertion Condition
  # Goal: The assertion should pass for the given value.
  exercise4 =
    let
      value = 15;
    in
      assert (value > /* ??? */) || abort "Assertion failed: value is not greater than expected";
      true; # If assert passes, return true

  # Exercise 5: Correct tryEval Check
  # Goal: Successfully catch the 'throw' and check for failure.
  exercise5 =
    let
      potentiallyFailing = throw "This error should be caught";
      result = builtins.tryEval potentiallyFailing;
    in
      result.success == /* ??? */; # Should check if success is *false*

  # Exercise 6: Fix Type Check Assertion
  # Goal: Assert that the variable 'numAsString' is indeed a string.
  exercise6 =
    let
      numAsString = "11";
    in
      assert (builtins.typeOf numAsString == /* ??? */) || abort "Type assertion failed";
      true;

  # Exercise 7: Debugging with File Check (Requires dummy.txt)
  # Goal: Use traceValFn to trace existence check, ensure check returns true.
  exercise7 =
    let
      path = ./dummy.txt;
      fileExists = builtins.pathExists path;
      # Trace the boolean result of the existence check
      tracedResult = lib.debug.traceValFn (existsBool: "Checking dummy.txt existence: ${toString existsBool}") /* ??? */; # What value should be traced here?
    in
      tracedResult == true; # Final check: Does the file exist and did trace return the correct boolean?

}
