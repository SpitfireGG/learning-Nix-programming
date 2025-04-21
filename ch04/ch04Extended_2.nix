## This chapter covers the use of 'rec' or recursion sets and 'with 'eexpressions in nix
# ========================================

## the with binding

# section 1:

# the with binding is an expression that brings all the attribute  of the imported sessions into the scope

/*
  the with  expression has the following features :

  imports all attributes from an expression into scope
  dynamic scoping (resolved at runtime whereas the let-inn  binding is lazily  evaluated)
*/

/*
  with import <nixpkgs> {};
  now  'stdenv', ''lib', etc. are in scope and can be used in further codes ( meaning all the attributes provided by the  nixpkgs can be  accessed without further repeations)
*/


  let
    pkgs = import <nixpkgs> { };
    libs = pkgs.lib;

  in
  with libs;
  {
    list = filter (x: x > 2) [
      1
      2
      3
      54
      56
      7
    ];
    a = 10;
    b = 20;
  }


# try avoiding deep nesting (can cause shadowing when using with) practical example

## something from the scoping concept i didn't uderstand is how 'foo' in the following code block evaluates to 'barbar' and not 'foobar' cuz i think it should be shadowing the variable from the innermost scope and not from the outer scope, ANYWAYS let' move on!

    with { x = "foo"; };
    with {
      x = "bar";
      foobar = x + "bar";
    };
    foobar
  # prints foobar and not barbar


# ======================================
## recusive sets in nix

# try to experiment out what really happens in the following code when the rec is removed


  rec {

    x = 1;
    y = x + 1;

  }


# rec allows you to reference names within the same attribute set

  let
    a = 1;
  in
  rec {
    a = a;
  # this would throw <infinite recursion> error because the a references itself infinitely
  }


#FIX: this can be fixed using something like the following

let
  args = {
    a = 1;
    b = args.a + 1; # this self references from the same attribute set once
  };
in
args
