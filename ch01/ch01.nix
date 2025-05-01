# purpose : to gain insight on working with basic data types in nix ( if you feel confused because you don't have experience with any functional programming language, don't feel demotivated, please don't you will get over it as we keep on progressing ) there is still much to come

# about : the let-in statement

/*
  the let-in in nix is the fundamental binding constructor that creates a local scope Where the bindings are visible, also
  the variables are immutable in nix ( meaning  they cannot be changed once defined )

  construct:
    let
      <binding>
    in
    <expression>
*/

{
  # strings & multi_line string
  msg = "basic data types";

  multi_line = ''
    this is a multi_line string
    hello there!
  '';

  message =
    let
      name = "readers"; # here 'name' is the binding
    in
    "Hello there ${name}"; # and the binding can be accessed here in the 'in' block cuz the variables is in the scope

  # integer operations
  int_operation =
    let
      x = 1;
      y = 2;
    in
    x + y;

  # float operations
  float_operation =
    let
      a = 10.20;
      b = 11.203;
    in
    b - a;

  #  this will cause an integer overflow, the computations does not round to 0 like in some programming  languages
  max_operation =
    let
      d = 9223372036854775807; # Max 64-bit signed int
    in
    d + 1;

  # the famous binary xor swap
  swap =
    let
      # you will  understand functions in later chapters, just hang  on!  &  keep going.
      xorSwap = x: y: builtins.bitXor x y;
      x = 2;
      y = 3;

      x_swap = xorSwap (xorSwap x y) x;
      y_swap = xorSwap (xorSwap x y) y;
    in
    {
      swapped = {
        x = x_swap;
        y = y_swap;
      };
    };

}
# you can run the nix program by running the following command in the termainal

# nix eval --file ch01.nix <one of the declarations like msg, message etc>
