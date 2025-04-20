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

  # section 5:
  concatList = lib.concatLists [
    # concats a list
    [
      1
      2
      3
    ]
    [
      4
      5
      6
    ]
  ];

  # section 6:
  splitStr = lib.splitString "-" "foo-bar-baz"; # splits a string given the delimeter field
  splitStr1 = lib.splitString "/" "/usr/bin/env";

  # section 7:
  mergeTwoSetsRecv =
    lib.attrsets.recursiveUpdate # if this seems confusing at first but when you play around with it more ,  you will get it
      {
        a = {
          x = 10;
        };
      }
      {
        a = {
          y = 20;
          z = 30;
        };
      };

  /*
    lib.attrsets.recursiveUpdate
    {
      boot.loader.grub.enable = true;
      boot.loader.grub.device = "/dev/hda";
    }
    {
      boot.loader.grub.device = "";
    };
  */

  # section 8:
  generateAttrs = lib.genAttrs [ "a" "b" ] (name: "x" + name); # generates an attribute set from a list of names and a function

  # section 9:
  partit = lib.lists.partition (v: v < 5) [
    # Splits the elements of a list in two lists, right and wrong, depending on the evaluation of a predicate
    # usage : to separate valid/invalid inputs
    5
    6
    7
    8
    2
    3
    1
    6
    10
    11
  ];

  fF = lib.findFirst (v: v > 7) 7 [
    # Finds the first element in the list matching the specified predicate or return default if no such element exists. here , 7 is the default value

    5
    6
    7
    8
    9
  ];

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
    concatList
    splitStr
    splitStr1
    mergeTwoSetsRecv
    generateAttrs
    partit
    fF
    ;
}
