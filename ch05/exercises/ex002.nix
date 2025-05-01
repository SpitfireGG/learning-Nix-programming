#ex002:
/*
  Goal: Use `seq` and `deepSeq` to control evaluation depth.

  Instructions:
  1. Examine `nestedData` with its trace calls.
  2. Define `resultSeq`: Use `builtins.seq` to force *only* `nestedData.outer`,
     then return "Forced outer with seq".
  3. Define `resultDeepSeq`: Use `builtins.deepSeq` to force the *entire*
     `nestedData` structure, then return "Forced all with deepSeq".
  4. Run `nix-instantiate --eval ./ex007.nix --show-trace` and observe the
     difference in trace output when `forceOuter` vs `forceRecursive` is evaluated.

  Expected Trace Output (When evaluating `forceOuter` via `resultSeq`):
  TRACE: --- Evaluating outer ---

  Expected Trace Output (When evaluating `forceRecursive` via `resultDeepSeq`):
  TRACE: --- Evaluating outer ---
  TRACE: --- Evaluating innerSet: key1 ---
  TRACE: --- Evaluating innerSet: key2 ---
  TRACE: --- Evaluating innerList: elem1 ---
  TRACE: --- Evaluating innerList: elem2 ---

  Expected Result (Stdout):
  { forceOuter = "Forced outer with seq"; forceRecursive = "Forced all with deepSeq"; }
*/
let
  nestedData = {
    outer = builtins.trace "TRACE: --- Evaluating outer ---" "Outer Value";
    innerSet = {
      key1 = builtins.trace "TRACE: --- Evaluating innerSet: key1 ---" 1;
      key2 = builtins.trace "TRACE: --- Evaluating innerSet: key2 ---" 2;
    };
    innerList = [
      (builtins.trace "TRACE: --- Evaluating innerList: elem1 ---" true)
      (builtins.trace "TRACE: --- Evaluating innerList: elem2 ---" false)
    ];
  };

  # Task 2: Use seq to force only nestedData.outer
  resultSeq =
    # --- Your Code Here: builtins.seq nestedData.outer ... ---
    "Placeholder: Fix Me (seq)";

  # Task 3: Use deepSeq to force all of nestedData
  resultDeepSeq =
    # --- Your Code Here: builtins.deepSeq nestedData ... ---
    "Placeholder: Fix Me (deepSeq)";

in
{
  forceOuter = resultSeq; # Triggers seq evaluation
  forceRecursive = resultDeepSeq; # Triggers deepSeq evaluation

  /*
    --- Solution Snippet ---
    resultSeq = builtins.seq nestedData.outer "Forced outer with seq";
    resultDeepSeq = builtins.deepSeq nestedData "Forced all with deepSeq";

    // Hint: `seq` evaluates only its 1st arg. `deepSeq` evaluates its 1st arg recursively.
  */
}
