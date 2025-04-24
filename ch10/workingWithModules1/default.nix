let
  pkgs = import <nixpkgs> { };
  finalEval = pkgs.lib.evalModules {
    modules = [
      ./options.nix
      ./config.nix
    ];
  };
in
finalEval.config
