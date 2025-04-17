# nix only evaluates expression when needed ( i.e why it is called lazily evaluated ) & avoids unnecessary computations
# The unevaluated nix expressions are stored in thunks and need to be forcefully evaluated

let
  expensive_eval = builtins.trace "computing expensive" (100000 * 1000000);
  cheap_eval = builtins.trace "computing cheap" (10 * 10);

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

  # Option 1 : evaluate multiple expressions, we have to use the inherit attribute ( Selectively evaluates the expressions )

  inherit
    cheap_eval
    expensive_eval
    expensive
    ;
  # you can run : ❯ nix eval --file ch05/ch05.nix expensive to evalute only the 'expensive' expression

  # Option 2: eval through deepSeq
  forced = force-all; # strictly evaluates the expression

}
# expensive_eval # this will only compute the  value for expensive_eval & not for cheap_eval
