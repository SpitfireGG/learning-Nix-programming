#ex005:

let
  # Task 1: Implement compose
  # Takes f, g. Returns a function x: f(g(x))
  compose =
    f: g: # --- Your Code Here: return function x: ... ---
    null;

  # Use compose
  double = x: x * 2;
  addOne = x: x + 1;
  # This should be a function that takes x and computes double(addOne(x))
  addOneThenDouble = # --- Your Code Here: compose ... ---
    (x: 0);

  # Task 2: Implement makeGreeter (Function Factory)
  # Takes 'greeting'. Returns a function name: "${greeting}, ${name}!"
  makeGreeter =
    greeting: # --- Your Code Here: return function name: ... ---
    null;

  # Use makeGreeter
  helloGreeter = # --- Your Code Here: makeGreeter ... ---
    (name: "Fix Me");
  welcomeGreeter = # --- Your Code Here: makeGreeter ... ---
    (name: "Fix Me");

  # Task 3: Fix self-reference using 'rec'
  # This definition is broken because 'a' needs 'b' before 'b' is defined.
  brokenRecSet = {
    a = b + 1; # Error: 'b' is not defined in this scope yet
    b = 5;
  }; # This structure won't work as intended in a simple {}

  # Create workingRecSet using 'rec'
  workingRecSet = # --- Your Code Here: use rec { ... } ---
    { };

in
{
  # Test calls (Do not modify this)
  composedResult = addOneThenDouble 5;
  greeting1 = helloGreeter "Alice";
  greeting2 = welcomeGreeter "Bob";
  inherit workingRecSet; # Should contain { a = 6; b = 5; }
}
