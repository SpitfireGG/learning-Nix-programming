#ex001:

let
  # Task 1: Define the createGreeting function
  # It should take 'name' (string) and 'age' (integer)
  # and return "Hello, [name]! You are [age] years old."

  createGreeting = name: age: "Fix Me!"; # <------- modify the string

  # Task 2: Define the calculateArea function
  # It should take 'length' and 'width' (integers)
  # and return length * width.

  calculateArea = # <----- your code here
    length: width: 0; # <------- change `0` to something else to make it evaluate to the desired output
in
{
  # Test calls (do not modify this part)
  greeting = createGreeting "Nix User" 30;
  area = calculateArea 10 6;
}

#  The result of the evaluation must equate to:
# { area = 60; greeting = "Hello, Nix User! You are 30 years old."; }
