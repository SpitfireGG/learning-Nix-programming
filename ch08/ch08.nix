# debugging in nix

/*
  we have already seen the usage of the nix builtin function : builtins.trace in action
  we will learn about some more advanced techniques in the nix ecosystem for debugging and tracing logs
*/

#1. basic log tracing with trace function ( run with --json | jq for readability )

/*
  let
    integerVal = 10;
    stringVal = "string";
  in
  if (builtins.typeOf integerVal) != (builtins.typeOf stringVal) then
    builtins.trace "Comparision of int to string" { inherit integerVal stringVal; }
  else
    builtins.trace "types matched!" {
      inherit integerVal stringVal;
    }
*/

#use the standard library to include functions for more thorough debuggings

#2. the traceVal attribute to trace the value and return it.

/*
  let
    lib = import <nixpkgs/lib>;
    str = "tracing with debug.traceVal";
    valTrace = lib.debug.traceVal str;
  in
  valTrace
*/

#3. the traceValFn attribute, traceValFn traces the supplied value after applying a function to it, and return the original value.
/*
  let
    lib = import <nixpkgs/lib>;
    x = {
      a = 1;
      b = 2;
      c = 3;
    };
    y = lib.debug.traceValFn (v: "result of expression x : ${builtins.toJSON v}") x;
  in
  y
*/

#basic example:
/*
  let
    debug = true;
    x = 10;
    y = "string";

    valCheck =
      if (builtins.typeOf x) == (builtins.typeOf y) && debug then
        (builtins.trace) "type matched" { inherit x y; }
      else
        (builtins.trace) "incorrect type, converting x to string and concatenating x ->  ${toString x}" (
          toString x
        )
        + y;
  in
  {
    inherit x y;
    check = valCheck;
  }
*/

# example 2
/*
  let
    lib = import <nixpkgs/lib>;
    path = ./test.txt;
    fileContent = lib.debug.traceValFn (
      x:
      "reading ${toString path} : ${if (builtins.pathExists path) then "path exists" else "path missing"}"
    ) (builtins.readFile path);
  in
  fileContent
*/

#traceValSeq attribute forces evaluation of a value (overriding lazy evaluation) and prints it
let
  lib = import <nixpkgs/lib>;
  nestedStructure = {
    a = 10;
    b = 20;
    c = 30;
    v = {
      x = 1;
      y = 2;
      z = 3;

      lazy = "this won't be evaluated";
    };
    moreNesting = [
      {
        data = {
          location = "asia";
          weather = "cloudy";
          time = "12:12:30";
          am = true;
        };
      }
      {
        api = {
          weather = "weather.api.com";
          time = [
            "1 pm"
            "2 pm"
          ];
        };

      }
      { lazyII = "this won't be evaluated too"; }
    ];
  };
  traceI = (builtins.trace) "tracing traceI" lib.debug.traceSeq nestedStructure nestedStructure;
  traceII =
    (builtins.trace) "tracing traceII" lib.debug.traceSeq nestedStructure.moreNesting
      nestedStructure.moreNesting;

in
{
  trace1 = traceI;
  inherit traceII;
}
