## Some of the most common library functions in nix
# ==========================================

# you can read the documentation from the official source for peeking under the declaration, and that is what i recommend for beginners, not all the operations on library functions are written in this chapter and it's impossible to cover them all too

let
  lib = import <nixpkgs/lib>;

  ## section 1:
  concatStringWithLib = lib.strings.concatStrings [
    # returns hello world
    "hello"
    " "
    "world"
  ];

  ## section 2:
  attributesName = lib.attrNames {
    # returns the names of the attributes
    a = 2;
    b = 3;
    c = 4;
  };
  ## section 3:
  Mapped = lib.mapAttrs (attr: value: value * 2) {
    # works just like the map functions (applies a function to each attribute’s value and produces a new attribute set)
    a = 10;
    b = 20;
  };
  # section 4:
  valByName = lib.getAttr "x" { x = 10; }; # gets the value by the attribute name ( if missing you can default to use a value )
  misingAttr = lib.getAttr "x" {
    z = 10;
    x = 20;
  };

  # section 4:
  filterAttr = lib.filterAttrs (Attrname: value: value > 0) {
    a = 10;
    b = -2;
  };

  filterRecursively = lib.filterAttrsRecursive (attrName: value: value != null) {
    # recursively filters according to the operation
    e = {
      # nested set structure
      x = 2;
      y = null;
    };
  };

in
{
  inherit
    concatStringWithLib
    attributesName
    Mapped
    valByName
    misingAttr
    filterAttr
    filterRecursively
    ;
}
