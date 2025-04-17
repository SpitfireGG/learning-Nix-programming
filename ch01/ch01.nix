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
  # working with strings
  print = "basic data types";
  multi_line = ''
    this is a multi_line string
    hello there!
  '';
  message =
    let
      name = "readers"; # here 'name' is the binding
    in
    "Hello there ${name}"; # and the binding can be accessed here in the 'in' block cuz the variables is in the scope

  # working with numbers and floats
  int_operation =
    let
      x = 1;
      y = 2;
    in
    x + y;
  float_operation =
    let
      a = 10.20;
      b = 11.203;
    in
    b - a;
  max_operation =
    let
      d = 9223372036854775807; # Max 64-bit signed int
    in
    d + 1;

}
# you can run the nix program by running in the termainal

# nix eval --file ch01.nix <one of the declarations like print, message etc>
