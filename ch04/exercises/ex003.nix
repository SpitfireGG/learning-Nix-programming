#ex003:

let
  numbers = [
    1
    2
    3
    4
    5
  ];
  sampleAttrs = {
    a = 10;
    b = 20;
    c = 30;
  };

  # Task 1a: Use map to double each element in 'numbers'
  doubleFn = x: x * 2;
  doubledList = # --- Your Code Here: map ... numbers ---
    [ ];

  # Task 1b: Use map to convert each element in 'numbers' to a string
  stringifyFn = x: toString x;
  stringifiedList = # --- Your Code Here: map ... numbers ---
    [ ];

  # Task 2: Implement applyToAttrs using builtins.mapAttrs
  # It takes 'f' (a function name: value: ...) and 'attrs'
  applyToAttrs =
    f: attrs: # --- Your Code Here: builtins.mapAttrs ... ---
    { };

  # Task 3: Use applyToAttrs to process sampleAttrs
  # The processing function should take name and value,
  # and return a string "[name]=[value*2]"
  processingFn =
    name: value: # --- Your Code Here: build the string ---
    "";
  processedAttrs = # --- Your Code Here: applyToAttrs ... sampleAttrs ---
    { };

in
{
  # Results (Do not modify this line)
  inherit doubledList stringifiedList processedAttrs;
}
