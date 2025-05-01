#ex001:
/*
   Goal: Predict and verify the order of trace messages due to lazy evaluation.

   Instructions:
   1. Examine the code below, noting the `trace` calls.
   2. Predict the sequence of "TRACE:" messages when this file is evaluated.
   3. Fill your prediction into `predicted_trace_order`.
   4. Run `nix-instantiate --eval ./ex006.nix --show-trace` and compare the
      actual trace output to your prediction and the expected output below.

  Expected Trace Output (Stderr):
   TRACE: --- Computing conditionalVal logic ---
   TRACE: --- Computing valA ---
   TRACE: --- Computing valC ---

   Expected Result (Stdout):
   { a = "Value A"; c = "Value C"; result = "Got A"; prediction = [  `your prediction`  ]; }
*/
let
  valA = builtins.trace "TRACE: --- Computing valA ---" "Value A";
  valB = builtins.trace "TRACE: --- Computing valB ---" "Value B"; # Should not compute
  valC = builtins.trace "TRACE: --- Computing valC ---" "Value C";

  # Only the 'then' branch (valA) is needed because 'if true'
  conditionalVal = builtins.trace "TRACE: --- Computing conditionalVal logic ---" (
    if true then valA else valB
  );

  # Task 3: Predict the order of trace messages
  predicted_trace_order = [
    "/* --- Fill Your Prediction Here --- */"
  ];

in
{
  # References below trigger evaluation based on dependencies.
  result = conditionalVal; # Needs conditionalVal -> Needs valA
  c = valC; # Needs valC
  a = valA; # Needs valA (result already cached, no re-trace)

  prediction = predicted_trace_order;

  /*
    --- Solution Hint ---
    Evaluation follows dependencies needed for the final output set {}.
    `if true` selects `valA`, ignoring `valB`. `valC` is needed directly.
    Nix caches results, so `a = valA` doesn't re-trigger the trace for `valA`.
    Order: conditionalVal setup -> valA -> valC
  */
}
