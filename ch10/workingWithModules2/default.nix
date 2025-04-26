{ pkgs, ... }:
(pkgs.lib.evalModules {
  modules = [
    ./options.nix
    ./config.nix
    ./assertions.nix

    { config = { enable = true; }; }
  ];
}).config

/* the evaluation can be done by the command :

    1.  nix eval --file default.nix --apply 'x: x { pkgs = import <nixpkgs> {};}' --json  | jq .

   this  will import nipkgs using a  function

   2.  nix eval --expr  '(import ./default.nix ) { pkgs = import <nixpkgs> {}; }' --json --impure  | jq

   breaking the expression,  we have imported the module default.nix ( which was not necessary and can be removed ) , import the nixpkgs as default.nix needs it  as defined in the attribute set top-level, pass it to json and then --impure flag as nixpkgs looksup in the $NIX_PATH to let it search the relevant path  as pure evaluation does not allow it to happen and then pretty print it with jq
*/
