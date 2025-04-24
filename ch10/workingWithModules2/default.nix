let
  pkgs = import <nixpkgs> { };
  finalEval = pkgs.lib.evalModules {
    modules = [
      ./options.nix
      ./config.nix
      ./assertions.nix

      { config = { enable = false; }; }
    ];
  };
in finalEval.config
