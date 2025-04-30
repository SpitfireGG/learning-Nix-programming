#ex002:
# Goal: Use lib.take, lib.drop, lib.reverseList, and lib.unique correctly.

let
  lib = import <nixpkgs/lib>;
  data = [
    10
    20
    30
    10
    40
    20
    50
  ];
in
# TODO: Replace `null` with the correct function calls or fix existing ones.

# Assertion 1: Get the first 3 elements.
assert
  (lib.take 3 data) == [
    10
    20
    30
  ];

# Assertion 2: Get all elements *except* the first 4.
assert
  (lib.drop 4 data) == [
    40
    20
    50
  ]; # <-- Fix the function call or expected result

# Assertion 3: Reverse the list.
assert
  (lib.reverseList data) == [
    50
    20
    40
    10
    30
    20
    10
  ];

# Assertion 4: Get only the unique elements, preserving order of first appearance.
assert
  (lib.unique data) == [
    10
    20
    30
    40
    50
  ]; # <-- Replace null

true # Result if all assertions pass
