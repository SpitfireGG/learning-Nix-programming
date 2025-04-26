{ pkgs }:
(pkgs.lib.evalModules {
  modules = [
    ./options.nix
    ./config.nix
    {
      _1st = 10;
      _2nd = 30;
      _3rd = 40;
    }
  ];
}).config.sum
