#ex004:

let
  pkgs = import <nixpkgs> { }; # Import nixpkgs to access lib
  lib = pkgs.lib; # Get the standard library

  # Task 1: Implement sumListRecursive
  # Takes a list of integers 'xs'. Returns the sum.
  sumListRecursive =
    xs:
    if xs == [ ] then # Base case: empty list
      0
    # Recursive step
    else
      # --- Your Code Here: head + recursive call on tail ---
      0;

  # Task 2: Implement reverseListRecursive
  # Takes a list 'xs'. Returns the reversed list.
  reverseListRecursive =
    xs:
    if xs == [ ] then # Base case: empty list
      [ ]
    # Recursive step
    else
      # --- Your Code Here: recursive call on tail ++ [head] ---
      [ ];

  # Test data
  list1 = [ ];
  list2 = [
    1
    2
    3
    4
    5
  ];
  list3 = [
    10
    (-5)
    10
  ];
  list4 = [
    "a"
    "b"
    "c"
  ];

in
{
  # Test calls (Do not modify)
  sum1 = sumListRecursive list1;
  sum2 = sumListRecursive list2;
  sum3 = sumListRecursive list3;
  reversed1 = reverseListRecursive list1;
  reversed2 = reverseListRecursive list4;
  reversed3 = reverseListRecursive list2;
}
