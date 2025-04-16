# comprehensive guide to functions in nix
# one thing i noticed is that the output is sometimes ranndom like when working with maps or something , i think this is due to the lazy evaluation of the nix programming language

let

  double = x: x * 2; # single parameter function
  add = x: y: x + y; # double parameter function

  # you can also set the default values to the parameters
  SumWithDefaults =
    {
      a ? 0,
      b ? 0,
    }:
    a + b;
  # variadic params
  IgnoreExtras =
    {
      a,
      b,
      ...
    }:
    a + b;
  # Attribute set params ( Attributes are key-value pairs just like map in programming language like GO)
  setAttr = { a, b }: a + b;

  # higher order functions ( takes another function as an arguement )
  HigherOrderfn = f: x: f x;

  # function compostitions
  composefn =
    f: g: x:
    f (g x);

  # advanced operations

  factorial = n: if n == 0 then 1 else n * factorial (n - 1);

  # debugging with trace ( glimps on previos chapter )
  debugMap = f: xs: map (x: builtins.trace "processing ${toString x}" (f x)) xs;

  # an example combining everything covered in this chapter

  mkUser =
    {
      name ? "kenzo",
      age ? 21,
      ...
    }:
    {

      username = name;
      useage = age;
      EligibleToVote = age >= 18;
    };

in
{
  doubles = double 10;
  add_two = add 10 20;
  def = SumWithDefaults { a = 6; }; # b is 0
  ignored = IgnoreExtras {
    a = 10;
    b = 20;
    c = 30;
    d = 40;
  }; # here c and d are ignored ( you might have seen this in flake.nix or other nix files )
  setAttrRes = setAttr {
    a = 1;
    b = 2;
  };
  HigherOrderfnRes = HigherOrderfn double 5;

  composefnRes = composefn double (x: x + 1) 5;

  facto = factorial 5;

  debugMapped = debugMap double [
    1
    2
    3
    4
  ];

  # custom config example
  user = mkUser {
  };

}
