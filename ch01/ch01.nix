{
  # string
  print = "basic data types";
  multi_line = ''
    this is a multi_line string
    hello there!
  '';
  message =
    let

      name = "devs";
    in
    "Hello there ${name}";

  # numbers
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

# runnning is the same as previous one
# run : nix eval --file ch01.nix <declarations like print, message etc>
