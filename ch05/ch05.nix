## Lazy Evalutions
# =============================

### learn more about the nix's lazy evaluation deeply , checkout: https://nixcademy.com/posts/what-you-need-to-know-about-laziness/

/*
  nix only evaluates expression when needed ( i.e why it is called lazily evaluated ) & avoids unnecessary computations
  this means that the value of variables is not computed when they are created — it is computed when they are referenced
  The unevaluated nix expressions are stored in thunks and need to be forcefully evaluated
*/

let
  expensive_eval = builtins.trace "computing expensive" (100000 * 1000000);
  cheap_eval = builtins.trace "computing cheap" (10 * 10);

  # we created two variabeles expensive and cheap_eval but their values are not computed when they are created but when they are referenced their values will be computed [  This can be throught of a parameters function that when called evaluates the expression   ]
  # we use the in block to reference the created variables and then compute them

  # you can also use the builtins.seq function to evalute an expression strictly
  expensive = builtins.trace "Running expensive computation" (
    builtins.seq (builtins.length (builtins.genList (x: x) 1000000)) "Done"
  );
  force-all = builtins.deepSeq [
    expensive_eval
    expensive
    cheap_eval
  ] "force all the expressions to compute";

in
{

  # Option 1 : to evaluate multiple expressions, we have to use the inherit attribute ( which will selectively evaluate the expressions )
  # inherit  brings the attributes from  the local scope to the current scope

  inherit
    cheap_eval
    expensive_eval
    expensive
    ;
  # you can run : ❯ nix eval --file ch05/ch05.nix expensive to evalute only the 'expensive' expression

  # Option 2: eval through deepSeq
  forced = force-all; # strictly evaluates the expression

}
# the following will only compute the  value for expensive_eval & not for cheap_eval
# expensive_eval
