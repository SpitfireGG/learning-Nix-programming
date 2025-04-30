### Lists
# =================================

let
  lib = import <nixpkgs/lib>;
  # NOTE: do not worry too much about this statement if you don't know what it is, it's just importing the library functions from the nixppkgs

  ## Section 1: Basic List Creation
  empty_set = [ ];

  nums = [
    1
    2
    3
    4
    5
    1
    3
    5
  ];
  mixed = [
    1
    2
    3
    "string"
    null
    {
      prop = {
        program = "nix";
        version = "2.1.14";
        isInterpreted = true;
      };
    }
  ];

  ## Section 2: Core List Operations

  first = builtins.head nums; # First element

  take3 = lib.take 3 nums; # keeps 3 elements and removes the  remaining

  drop4 = lib.drop 4 nums; # drops 4 elements and keeps one

  remaining = builtins.tail nums; # All except first

  grabFromIdx = builtins.elemAt nums 2; # Element at index 2

  reverseList = lib.reverseList nums;

  grabUnique = lib.unique nums; # returns a list with only uniqe elements

  ## List analysis
  len = builtins.length nums; # get the length

  has_3 = builtins.elem 3 nums; # checks the presence of 3 in the element list

  ## Section 3: List Generation
  mkList = builtins.genList (i: i * 2) 5; # [0 2 4 6 8] generates list from 0 to 8

  toStr = builtins.genList (i: "item-${toString i}") 3; # ["item-0" "item-1" "item-2"] generates list with provided operation

  ## Section 4: List Manipulation
  concat = nums ++ [
    10
    20
    30
    40
  ];
  has_10 = builtins.elem 10 concat;

  ## Functional operations

  numsLessThan4 = builtins.any (x: x < 4) nums;

  numsGreaterThan5 = builtins.any (x: x > 5) nums;

  squared_nums = map (x: x * x) concat;

  # Note: Using lib.mod instead of % operator
  evenSquared = map (x: x * x) (builtins.filter (x: lib.mod x 2 == 1) concat);

  ## Section 5: Advanced Operations
  # Filtering attribute sets from mixed list

  findSet = builtins.filter (x: builtins.isAttrs x) mixed;

  # Fold demonstration

  foldFn = builtins.foldl' (acc: elem: acc + elem) 0 [
    1
    2
    3
    4
  ];
  /*
    breaking down the foldl process
    1. Start with acc = 0
    2. 0 + 1 → acc = 1
    3. 1 + 2 → acc = 3
    4. 3 + 3 → acc = 6
    5. 6 + 4 → final acc = 10
  */

  numsToDuplicate = [
    1
    2
    3
  ];
  # `lib.map` maps and concatenates the result & `lib.replicate` creates n copies
  dupNtimes = lib.concatMap (x: lib.replicate x x) numsToDuplicate;

  # `lib.imap0 function list`: Like `map`, but the function receives `(index: element)` as arguments, starting from indexing 0
  indexedNums = lib.imap0 (index: value: "${toString index}: ${toString value}") nums;

  # `lib.optional`: Returns [ element ] if condition is true, `[ ]` otherwise.
  mayIncludeAdmin = lib.optional true "admin";
  mayIncludeTester = lib.optional false "tester";
  users =
    [
      "user"
      "bob"
    ]
    ++ mayIncludeAdmin
    ++ mayIncludeTester; # ++shallow merges the multiple list elements into a single list

  # `lib.optionals`: Returns the given `list` if condition is true, `[ ]` otherwise.
  betaFeatures = [
    "feature-x"
    "feature-y"
  ];
  enableBeta = false;
  activeFeatures = [ "core-feature" ] ++ lib.optionals enableBeta betaFeatures; # Result: [ "core-feature" ]

  # Sometimes you encounter lists with mixed types. Use `builtins.is*` functions for type checking.

  # Filter out only the attribute sets from our mixed list.
  findAttrsMixed = builtins.filter builtins.isAttrs mixed;

  # Filter out only the strings.
  findStringsInMixed = builtins.filter builtins.isString mixed;

in
{
  inherit

    ## section 1:
    empty_set
    nums
    mixed
    first
    remaining
    has_3
    reverseList

    ## section 2:
    grabUnique
    take3
    drop4
    grabFromIdx
    len

    ## section 3:
    mkList
    toStr

    ## section 4: (shallow merge)
    concat
    has_10

    ## section 5: (Functional ones)
    numsLessThan4
    numsGreaterThan5
    squared_nums
    evenSquared
    findSet
    foldFn
    dupNtimes
    indexedNums

    ## final : Misc library functions
    users
    activeFeatures
    findAttrsMixed
    findStringsInMixed
    ;
}

## Practical exercises : run them one by one
# ===================
/*
  Try these evaluations:

  1. Check mixed list structure:
     nix eval -f lists.nix mixed --json | jq

  2. Access nested property:
     nix eval -f lists.nix '(builtins.elemAt mixed 4).prop.program'

  3. Filter demonstration:
     nix eval -f lists.nix findSet --json | jq

  4. Fold result verification:
     nix eval -f lists.nix foldFn

  5. Conditional check:
     nix eval -f lists.nix \
       'if has_10 then "Exists" else "Missing"'

  6. Handle mixed types:
     nix eval -f lists.nix \
       'builtins.filter (x: builtins.isString x) mixed'
*/
