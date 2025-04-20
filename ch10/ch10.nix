## working with Module System Utilities
# =========================================

let

  lib = import <nixpkgs/lib>;

  createEnable = lib.mkEnableOption "Enable my feature"; # Creates enable = true/false option

in
createEnable
