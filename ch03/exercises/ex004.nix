#ex004:
# Goal: Use map, filter, and any correctly.

let
  lib = import <nixpkgs/lib>;
  numbers = [ 1 2 3 4 5 6 ];
in
# TODO: Fix the function calls or the functions passed to them.

# Assertion 1: Create a new list where each number is incremented by 1.
incremented = builtins.map (x: x + 1) numbers; # <-- Fix the function if needed
assert incremented == [ 2 3 4 5 6 7 ];

# Assertion 2: Create a list containing only the even numbers. Remember lib.mod!
evens = builtins.filter (x: lib.mod x 2 == 0) numbers;
assert evens == [ 2 4 6 ];

# Assertion 3: Check if *any* number in the list is greater than 5.
anyGreaterThan5 = builtins.any (x: x > 5) numbers; # <-- Fix the condition if needed
assert anyGreaterThan5 == true;

# Assertion 4: Check if *any* number is less than 0.
anyLessThan0 = builtins.any (x: x < 0) numbers;
assert anyLessThan0 == false; # <-- Fix the expected result

true 
