# ex005:
# Goal: Use foldl', concatMap, and imap0 correctly.

let
  lib = import <nixpkgs/lib>;
  items = [ "a" "bb" "ccc" ];
in
# TODO: Fix the function calls or parameters.

# Assertion 1: Calculate the total length of all strings in the list using foldl'.
# Hint: Start with 0, and add the length of each string (`builtins.stringLength`).
totalLength = builtins.foldl' (acc: elem: acc + builtins.stringLength elem) 0 items;
assert totalLength == 6; # 1 + 2 + 3

# Assertion 2: Create a list containing each item repeated twice using concatMap.
# Hint: Use lib.replicate.
repeatedTwice = lib.concatMap (item: lib.replicate 2 item) items; # <-- Fix the replicate count or function
assert repeatedTwice == [ "a" "a" "bb" "bb" "ccc" "ccc" ];

# Assertion 3: Create a list of strings formatted as "index: item".
indexedItems = lib.imap0 (idx: val: "${toString idx}: ${val}") items;
assert indexedItems == [ "0: a" "1: bb" "2: ccc" ];

# missing bool
