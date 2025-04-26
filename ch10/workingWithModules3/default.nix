{ pkgs, ... }:
(pkgs.lib.evalModules { modules = [ ./options.nix ./config.nix ]; }).config

# run with nix eval --file default.nix --apply 'x:x { pkgs = import <nixpkgs> {}; }' --json | jq
