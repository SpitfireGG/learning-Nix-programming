##ch09.nix
# Exploring Functions from nixpkgs.lib
# =============================================================

/*
  This chapter demonstrates functions from the Nixpkgs standard library (`lib`),
  separated into two main categories:
  1. Functions specifically for manipulating Attribute Sets (attrsets).
  2. Functions for other common tasks (strings, lists, conditionals, etc.).

  See the README for further explanations.
*/

let
  # Import the standard library
  lib = import <nixpkgs/lib>;

  # Section 1: Attribute Set Manipulation Functions
  # ==================================================
  attrsetFunctions =
    let
      #  Attribute Set Inspection & Access

      # Get the names (keys) of an attribute set as a list of strings.
      attrNamesExample = lib.attrNames {
        enable = true;
        host = "localhost";
        port = 8080;
      };
      # Result: [ "enable" "host" "port" ]

      # Check if an attribute exists. Safer than direct access (e.g. set.key).
      hasAttrExample = lib.hasAttr "port" {
        host = "localhost";
        port = 8080;
      };
      # Result: true
      hasAttrMissingExample = lib.hasAttr "missingKey" { host = "localhost"; };
      # Result: false

      # Retrieve an attribute's value by name. Throws error if missing.
      getAttrExample = lib.getAttr "port" {
        host = "localhost";
        port = 8080;
      };
      # Result: 8080
      # getAttrMissing = lib.getAttr "missingKey" { host = "localhost"; }; # Throws error

      #  Attribute Set Transformation & Filtering

      # Apply a function to each value in an attribute set, returning a new set.
      # Function receives (name, value)
      mapAttrsExample = lib.mapAttrs (name: value: value * 2) {
        a = 10;
        b = 20;
      };
      # Result: { a = 20; b = 40; }

      # Filter attributes based on a predicate function applied to name and value.
      # Function receives (name, value)
      filterAttrsExample = lib.filterAttrs (name: value: value > 0) {
        count = 10;
        offset = -2;
        limit = 5;
      };
      # Result: { count = 10; limit = 5; }

      # Recursively filter attributes. Useful for nested structures.
      # Function receives (pathList, value) where pathList is the list of keys to reach the value
      filterAttrsRecursiveExample = lib.filterAttrsRecursive (path: value: value != null) {
        a = 1;
        b = null; # Removed
        nested = {
          x = true;
          y = null; # Removed
          deep = {
            z = 123;
          };
        };
      };
      # Result: { a = 1; nested = { x = true; deep = { z = 123; }; }; }

      #  Attribute Set Merging & Generation

      # Deeply merge two attribute sets. Later values override earlier ones.
      # Nested sets are merged recursively.
      recursiveUpdateExample =
        lib.recursiveUpdate
          {
            config = {
              user = "old";
              settings = {
                theme = "light";
              };
            };
          }
          {
            config = {
              user = "new";
              settings = {
                fontSize = 12;
              };
            };
            extra = true;
          };
      # Result: { config = { user = "new"; settings = { theme = "light"; fontSize = 12; }; }; extra = true; }

      # Generate an attribute set from a list of names and a function.
      # Function receives the name and returns the corresponding value.
      genAttrsExample = lib.genAttrs [ "id" "name" "status" ] (name: "value_for_${name}");
      # Result: { id = "value_for_id"; name = "value_for_name"; status = "value_for_status"; }

      # Create an attribute set from a list of { name = "key"; value = ...; } structures.
      listToAttrsExample = lib.listToAttrs [
        {
          name = "key1";
          value = 100;
        }
        {
          name = "key2";
          value = true;
        }
      ];
      # Result: { key1 = 100; key2 = true; }

      # Combine two attribute sets using a function applied to matching keys.
      /*
        zipAttrsExample = lib.zipAttrsWith (v1: v2: v1 + v2) [
          {
            a = 1;
            b = 10;
            c = 100;
          } # Set 1
          {
            a = 2;
            b = 20;
            d = 200;
          }
        ]; # Set 2 (Note: 'c' and 'd' are ignored)
        # Result: { a = 3; b = 30; }
      */

    in
    {
      # attrset-specific examples
      inherit
        attrNamesExample
        hasAttrExample
        hasAttrMissingExample
        getAttrExample
        mapAttrsExample
        filterAttrsExample
        filterAttrsRecursiveExample
        recursiveUpdateExample
        genAttrsExample
        listToAttrsExample
        #       zipAttrsExample
        ;

      # attrset examples under consistent names
      original_attrNames = attrNamesExample;
      original_mapAttrs = mapAttrsExample;
      original_getAttr = getAttrExample;
      original_getAttrExample2 = lib.getAttr "x" {
        z = 10;
        x = 20;
      };
      original_filterAttrs = filterAttrsExample;
      original_filterRecursive = filterAttrsRecursiveExample;
      original_recursiveUpdate = recursiveUpdateExample;
      original_genAttrs = genAttrsExample;
    };

  ## section 2: Other Common Library Functions
  # ==================================================
  otherFunctions =
    let
      #  String Manipulation

      concatStringExample = lib.strings.concatStrings [
        "Nix"
        "is "
        "purley"
        "functional"
      ];
      splitStringExample = lib.splitString [ "-" "/" ] "data-key/value-pair";
      hasPrefixExample = lib.strings.hasPrefix "config-" "config-main.nix";
      hasSuffixExample = lib.strings.hasSuffix ".nix" "config-main.nix";
      toLowerExample = lib.strings.toLower "NixOS Module";
      replaceExample = lib.strings.replaceStrings [ "-" ] [ "_" ] "some-dashed-value";
      escapedArg = lib.escapeShellArg "hello world!";
      escapedArgsList = lib.escapeShellArgs [
        "gcc"
        "-o"
        "output file"
        "input.c"
      ];

      #  List Manipulation

      concatListExample = lib.concatLists [
        [
          1
          2
        ]
        [ 3 ]
        [
          4
          5
          6
        ]
      ];
      findFirstExample = lib.findFirst (v: v > 7) null [
        5
        6
        7
        8
        9
      ];
      findFirstDefault = lib.findFirst (v: v > 10) 99 [
        5
        6
        7
        8
        9
      ];
      partitionExample = lib.lists.partition (v: v < 5) [
        5
        6
        2
        8
        3
        1
        6
      ];
      elemExample = lib.elem 3 [
        1
        2
        3
        4
        5
      ];
      elemMissingExample = lib.elem 9 [
        1
        2
        3
        4
        5
      ];
      rangeExample = lib.range 3 7;
      uniqueExample = lib.unique [
        1
        3
        2
        3
        1
        4
        2
      ];
      flattenExample = lib.flatten [
        [ 1 ]
        [
          2
          3
        ]
        [ ]
        [
          4
          5
        ]
      ];
      mapListExample = lib.map (x: x * x) [
        1
        2
        3
        4
      ];
      filterListExample = lib.filter (x: x > 3) [
        1
        5
        2
        4
        3
      ];
      sumExample = lib.foldl' (acc: elem: acc + elem) 0 [
        1
        2
        3
        4
      ];

      #  Conditionals and Optionals

      mkIfExample = lib.mkIf (2 > 1) "Include this";
      mkIfFalseExample = lib.mkIf (1 > 2) "Include this";
      mkIfInSet = {
        optionalFeature = lib.mkIf true {
          enable = true;
          port = 80;
        };
      };
      optionalExample = lib.optional (1 == 1) "--verbose";
      optionalFalseExample = lib.optional (1 == 2) "--debug";
      commandArgs = [ "gcc" ] ++ lib.optional true "-O2" ++ [ "main.c" ];
      optionalStringExample = lib.optionalString (1 == 1) " --enable-feature";
      optionalStringFalseExample = lib.optionalString (1 == 2) " --debug-mode";
      configFileContent = "user=admin\n" + lib.optionalString true "password=secret\n";
      warnExample = lib.warn "This feature is deprecated!" "Returned Value";

      #  Version Handling

      versionCompareEqual = lib.versionAtLeast "2.5" "2.5.0";
      versionCompareLess = lib.versionOlder "1.10.3" "2.0.0";
      versionMajor = lib.versions.major "12.3.4-pre";
      versionMinor = lib.versions.minor "12.3.4-pre";

    in
    {
      # Strings
      inherit
        concatStringExample
        splitStringExample
        hasPrefixExample
        hasSuffixExample
        toLowerExample
        replaceExample
        escapedArg
        escapedArgsList
        ;
      # Lists

      inherit
        concatListExample
        findFirstExample
        findFirstDefault
        partitionExample
        elemExample
        elemMissingExample
        rangeExample
        uniqueExample
        flattenExample
        mapListExample
        filterListExample
        sumExample
        ;

      # Conditionals / Optionals
      inherit
        mkIfExample
        mkIfFalseExample
        mkIfInSet
        optionalExample
        optionalFalseExample
        commandArgs
        optionalStringExample
        optionalStringFalseExample
        configFileContent
        warnExample
        ;

      # Versions
      inherit
        versionCompareEqual
        versionCompareLess
        versionMajor
        versionMinor
        ;

      # non-attrset examples under consistent names
      original_concatStrings = concatStringExample;
      original_concatLists = concatListExample;
      original_splitString = lib.splitString [ "-" ] "foo-bar-baz";
      original_splitString2 = lib.splitString [ "/" ] "/usr/bin/env";
      original_partition = partitionExample;
      original_findFirst = findFirstExample;
    };

in
#  Final structures
{
  #  by category
  attributeSetFunctions = attrsetFunctions;

  otherCommonFunctions = otherFunctions;
}
