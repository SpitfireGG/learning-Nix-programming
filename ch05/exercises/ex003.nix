#ex003:
/*
  Goal: Show how laziness avoids errors in unused paths and use `tryEval` to catch errors.

  Instructions:
  1. Examine `riskyOperation` (throws if `fail == true`) and `selectData`.
  2. Define `safeCall`: Call `selectData false` so the error path isn't hit.
  3. Define `unsafeCallResult`: Use `builtins.tryEval` to attempt `selectData true`.
     `tryEval` catches errors, returning `{ success = false; ... }` instead of halting.
  4. Run `nix-instantiate --eval ./ex008.nix --show-trace` and check the output structure.

  Expected Result (Stdout):
  {
    safeCall = "Operation succeeded (condition was false)";
    unsafeCallResult = { success = false; value =  `error info` ; };
  }

  Expected Trace Output (Stderr):
  TRACE: --- selectData called with condition: false ---
  TRACE: --- riskyOperation called with fail = false ---
  TRACE: --- selectData called with condition: true ---
  TRACE: --- riskyOperation called with fail = true ---
*/
let
  riskyOperation =
    fail:
    builtins.trace "TRACE: --- riskyOperation called with fail = ${toString fail} ---" (
      if fail then throw "Intentional failure!" else "Operation succeeded (condition was false)"
    );

  selectData =
    condition:
    builtins.trace "TRACE: --- selectData called with condition: ${toString condition} ---" (
      riskyOperation condition # Pass condition to riskyOperation's 'fail'
    );

in
{
  # Task 2: Call selectData safely (condition = false)
  safeCall = # --- Your Code Here: selectData false ---
    "Fix Me";

  # Task 3: Use tryEval to attempt the failing call (condition = true)
  unsafeCallResult = # --- Your Code Here: builtins.tryEval (selectData true) ---
    { };

  /*
    --- Solution Snippet ---
    safeCall = selectData false;
    unsafeCallResult = builtins.tryEval (selectData true);

    // Hint: `selectData false` -> `riskyOperation false` -> `if false` -> returns string (safe).
    // `tryEval (selectData true)` -> `riskyOperation true` -> `if true` -> `throw` -> caught by `tryEval`.
  */
}
