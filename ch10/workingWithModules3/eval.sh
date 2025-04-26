#!/run/current-system/sw/bin/bash

#  runs the nix evaluation command with pretty print

nix eval --file ./default.nix --apply 'x : x { pkgs = import <nixpkgs> {}; }' --json | jq 



