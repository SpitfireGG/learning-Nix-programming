# Lists
# =================================

let
  lib = import <nixpkgs/lib>;

  # Section 1: Basic List Creation
  # ------------------------------
  empty_set = [ ];

  nums = [
    1
    2
    3
    4
    5
  ];

  mixed = [
    1
    2
    3
    "string"
    {
      prop = {
        program = "nix";
        version = "2.1.14";
        isInterpreted = true;
      };
    }
  ];

  # Section 2: Core List Operations
  # -------------------------------
  # Basic accessors
  first = builtins.head nums; # First element
  remaining = builtins.tail nums; # All except first
  grabFromIdx = builtins.elemAt nums 2; # Element at index 2

  # List analysis
  len = builtins.length nums; # get the length
  has_3 = builtins.elem 3 nums;

  # Section 3: List Generation
  # --------------------------
  mkList = builtins.genList (i: i * 2) 5; # [0 2 4 6 8]
  toStr = builtins.genList (i: "item-${toString i}") 3; # ["item-0" "item-1" "item-2"]

  # Section 4: List Manipulation
  # ----------------------------
  # Concatenation
  concat = nums ++ [
    10
    20
    30
    40
  ];
  has_10 = builtins.elem 10 concat;

  # Functional operations
  squared_nums = map (x: x * x) concat;

  # Note: Using lib.mod instead of % operator
  evenSquared = map (x: x * x) (builtins.filter (x: lib.mod x 2 == 1) concat);

  # Section 5: Advanced Operations
  # -----------------------------
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

in
{
  inherit
    empty_set
    nums
    mixed
    first
    remaining
    grabFromIdx
    len
    has_3
    mkList
    toStr
    concat
    has_10
    squared_nums
    evenSquared
    findSet
    foldFn
    ;
}

# Practical Exercises
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

# Important Notes
# ===============
/*
  Key Observations:
  - Nix lists are homogeneous by convention
  - Mixed-type lists require careful handling
  - Indexing starts at 0
  - All list operations are immutable (create new lists)

  Common Pitfalls:
  - Using % operator: Use lib.mod instead
  - Direct index access without bounds checking
  - Assuming list mutability

  Performance Tips:
  - foldl' is strict version for better performance
  - genList is optimized for large lists
  - ++ operator creates new lists (O(n) operation)
*/
