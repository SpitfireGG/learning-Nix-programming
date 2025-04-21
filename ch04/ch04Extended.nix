let

  ## section 1: working  with epllipse, go through the docs throughly to get a good understanding , epllipse comes very ofter when working with nix
  func = { a, b, ... }@bargs: if a == "foo" then b + bargs.c else b + bargs.x + bargs.y;

  ## section 2:
  b = 1;
  fu0 = (x: x); # this will only take a single value for x
  fu1 = (x: y: x + y) 4; # considering we have not provided one of the function parameter value to the function it would implicitly assign the 1st parameter 'x' to be the value that is assigned after the function body which is '4' in this context and the function waits for the value of y onwards, which is passed as b in the 'in' block
  fu2 = (x: y: (2 * x) + y); # this will take two params x and y , multipliesx by 2 and then add it to y

  ##section 3:

  Fn =
    { x, y }:
    z: {
      x = x;
      y = y;
      z = z;
    };
  partial = Fn {
    x = 1;
    y = 2;
    # this function awaits for z which is not provided in this attribute set
  };
in
rec {

  # from section 1:

  /*
      this will Bind a and b directly
    and then
      capture all other arguments in bargs
  */
  foobar = func {
    a = "";
    b = "foo";
    x = "bar";
    y = "";
  };

  # from section 2:
  ex00 = fu0 4; # returns 4
  ex01 = fu1 1; # this won't work as the function expects another parameter that is not explicilty passed to the functio resulting in partial application
  ex02 = (fu2 2) 3; # returns 7
  ex03 = (fu2 3); # returns <LAMBDA>  ( we get to see the <LAMBDA> if the function expects more arguements but only has partial arguements, so it will await  for the other parameters to bound to, to fix this issue we must always provide the required or more arguements to the function )
  ex04 = ex03 1; # return 7
  ex05 = (n: x: (fu2 x n)) 3 2; # returns 7

  # from section 3: < run the first "part' expresssio to find out >
  #  part = partial; # this returns for the value of z but is not provided and throws <LAMBDA> (partial application)
  parti = partial 4; # fixed

}
