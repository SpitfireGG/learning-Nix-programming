# ex001:
# Goal: Fix indexing and access functions.

let
  lib = import <nixpkgs/lib>; # We might need lib functions later
  colors = [
    "red"
    "green"
    "blue"
    "yellow"
  ];
in
# TODO: Fix the expressions below so all assertions pass.

# Assertion 1: Get the first color.
assert (builtins.head colors) == "red";

# Assertion 2: Get the list *without* the first color.
assert
  (builtins.tail colors) == [
    "green"
    "blue"
    "yellow"
  ];

# Assertion 3: Get the color at index 2 (the third color). Remember 0-based indexing!
assert (builtins.elemAt colors 2) == "blue"; # <-- Fix the index if needed

# Assertion 4: Check the total number of colors.
assert (builtins.length colors) == 4;

# Assertion 5: Check if "green" is present in the list.
assert (builtins.elem "green" colors) == true;

# Assertion 6: Check if "purple" is present (it's not).
assert (builtins.elem "purple" colors) == false; # <-- Fix the expected boolean

true # Result if all assertions pass
