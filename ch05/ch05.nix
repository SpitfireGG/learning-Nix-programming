## Lazy Evalutions
# =============================

### learn more about the nix's lazy evaluation deeply , checkout: https://nixcademy.com/posts/what-you-need-to-know-about-laziness/

/*
  nix only evaluates expression when needed ( i.e why it is called lazily evaluated ) & avoids unnecessary computations
  this means that the value of variables is not computed when they are created — it is computed when they are referenced
  The unevaluated nix expressions are stored in thunks and need to be forcefully evaluated
*/

# Contrast: Eager evaluation computes immediately. Lazy evaluation waits.
# Example: In an eager language, both expensive_eval and cheap_eval would likely
#          compute right here. In Nix, they remain as 'thunks' (promises).

let
  expensive_eval = builtins.trace "STEP 1: computing expensive_eval" (100000 * 1000000);
  cheap_eval = builtins.trace "STEP 2: computing cheap_eval" (10 * 10);

  # we created two variabeles expensive and cheap_eval but their values are not computed when they are created but when they are referenced their values will be computed [  This can be throught of a parameters function that when called evaluates the expression   ]
  # we use the in block to reference the created variables and then compute them

  # Example: Laziness preventing errors
  # This function will throw an error if y is 0
  divide =
    x: y:
    if y == 0 then
      builtins.trace "!!! ERROR BRANCH: Division by zero calculation started !!!" (
        throw "Division by zero!"
      )
    else
      builtins.trace "--- SAFE BRANCH: Performing division ${toString x} / ${toString y} ---" (x / y);

  # Because the 'if' condition is true, the 'else' branch containing 'divide 100 0'
  # is never evaluated. Laziness prevents the error!
  safeComputation = builtins.trace "*** Evaluating safeComputation branch logic ***" (
    if true then
      builtins.trace "--- Taking TRUE branch in safeComputation ---" 10
    else
      builtins.trace "--- Taking FALSE branch in safeComputation (THIS SHOULD NOT PRINT) ---" (
        divide 100 0
      )
  );

  # If this were referenced, it *would* evaluate the 'else' branch and throw.
  # unsafeComputation = if false then 10 else (divide 100 0);

  # you can also use the builtins.seq function to evalute an expression strictly
  # builtins.seq forces evaluation of its *first* argument, then returns the second.
  # Here, it forces the length calculation, prints "Done" via trace, and returns "Done".
  expensive = builtins.trace "STEP 3: Evaluating 'expensive' definition (triggers seq)" (
    builtins.seq (builtins.trace "--- SEQ: Forcing list generation and length calculation ---" (
      builtins.length (builtins.genList (x: x) 1000000)
    )) (builtins.trace "--- SEQ: Returning second argument ---" "Done with expensive list length")
  );

  # builtins.deepSeq forces evaluation of *all* elements in the first argument (list/set) recursively.
  force_all = builtins.trace "STEP 4: Evaluating 'force_all' definition (triggers deepSeq)" (
    builtins.deepSeq
      [
        # These references inside the list will be forced by deepSeq
        (builtins.trace "--- DEEPSEQ: Forcing element 1 (expensive_eval) ---" expensive_eval)
        (builtins.trace "--- DEEPSEQ: Forcing element 2 (expensive) ---" expensive)
        (builtins.trace "--- DEEPSEQ: Forcing element 3 (cheap_eval) ---" cheap_eval)
      ]
      (
        builtins.trace "--- DEEPSEQ: Returning second argument after forcing all ---" "All expressions forced by deepSeq"
      )
  );

in
{
  /*
    Evaluation Trigger Point:
    The 'in' block defines the final attribute set returned by the 'let .. in ...' expression.
    Nix evaluates an expression within the 'let' block *only when* it's needed to construct
    this final output set. Accessing an attribute here forces its evaluation.
  */

  # Option 1 : to evaluate multiple expressions, we have to use the inherit attribute ( which will selectively evaluate the expressions )
  # inherit brings the attributes from the local scope (the 'let' block) into the current scope (the final output attrset).
  # Referencing 'cheap_eval' here forces its computation *now* (if not already forced).
  inherit cheap_eval; # Expect "STEP 2: computing cheap_eval" trace here (if not forced by deepSeq earlier)

  # Referencing 'expensive_eval' forces its computation.
  inherit expensive_eval; # Expect "STEP 1: computing expensive_eval" trace here (if not forced earlier)

  # Referencing 'expensive' forces its computation, which includes the 'seq'.
  inherit expensive; # Expect "STEP 3: Evaluating 'expensive' definition..." and nested seq traces here (if not forced earlier)

  # Referencing 'safeComputation' forces its evaluation. Note the error branch is *not* triggered.
  inherit safeComputation; # Expect "*** Evaluating safeComputation..." and "--- Taking TRUE branch..." traces

  # Uncommenting this would cause an error because it references the unsafe path.
  # inherit unsafeComputation; # Would trace "!!! ERROR BRANCH..." and throw.

  # you can run : ❯ nix eval --file ch05/ch05.nix expensive to evalute only the 'expensive' expression
  # Nix eval '.#expensive' (for flakes) or 'ch05.nix --attr expensive' (non-flakes) allows evaluating only specific attributes.

  # Option 2: eval through deepSeq
  # Referencing 'force_all' forces its computation, triggering 'deepSeq'.
  # 'deepSeq' then forces evaluation of all elements listed within it.
  forced = force_all; # Expect "STEP 4: Evaluating 'force_all'...", the DEEPSEQ traces, AND potentially steps 1, 2, 3 again if not already evaluated by previous inherits. Note that Nix caches results, so a thunk is computed at most once.

}
# the following will only compute the value for expensive_eval & not for cheap_eval
# ^ This comment refers to running `nix eval ... expensive_eval`, correctly pointing out
#   that only the referenced attribute and its dependencies are evaluated in that specific command.
