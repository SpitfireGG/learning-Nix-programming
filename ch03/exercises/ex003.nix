#ex003:
# Goal: Fix list generation and combine lists correctly ( also the assertions are all mangled up and needs to be put somewhere else and a boolean for assertions passed is missing )

let
  lib = import <nixpkgs/lib>;

  # Assertion 1: Generate a list of the first 4 square numbers (0*0, 1*1, 2*2, 3*3).
  generatedSquares = builtins.genList (i: i * i) 4; # <-- Fix the count or the function

  assert generatedSquares == [ 0 1 4 9 ];

  # Assertion 2: Concatenate two lists.
  listA = [ "a" "b" ];
  listB = [ "c" "d" ];
  combinedList = listA ++ listB; # <-- Ensure this is the correct operator or not

  assert combinedList == [ "a" "b" "c" "d" ];

in

# bool missing
