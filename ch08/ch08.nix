# Debugging in Nix: From Basic Tracing to Advanced Techniques
# -----------------------------------------------------------

## 1. Basic Tracing with builtins.trace
/*
  shows simple message logging while returning values
  run the following codes with (--json | jq) for best logs tracing
*/

let
  integerVal = 10;
  stringVal = "string";
in
if (builtins.typeOf integerVal) != (builtins.typeOf stringVal) then
  builtins.trace "Comparing int to string (type mismatch)" {
    inherit integerVal stringVal;
  }
else
  builtins.trace "Types matched!" {
    inherit integerVal stringVal;
  }


## 2. Value Tracing with traceVal
/*
  Logs values without modifying them - great for quick inspections
*/

let
  lib = import <nixpkgs/lib>;
  str = "tracing-with-debug.traceVal";
  valTrace = lib.debug.traceVal str;
in
valTrace


## 3. Custom Tracing with traceValFn
/*
  Applies custom formatting before logging - perfect for complex data
*/

let
  lib = import <nixpkgs/lib>;
  x = { a = 1; b = 2; c = 3; };
  y = lib.debug.traceValFn (v: 
    "Processed value: ${builtins.toJSON v}"
  ) x;
in
y


## 4. Type Checking Example
/*
  Demonstrates runtime type validation with debug tracing
*/

let
  debug = true;
  x = 10;
  y = "string";

  valCheck = 
    if (builtins.typeOf x) == (builtins.typeOf y) && debug then
      builtins.trace "Type matched" { inherit x y; }
    else
      builtins.trace 
        "Type mismatch! Converting x (${toString x}) to string" 
        (toString x + y);
in
{
  inherit x y;
  check = valCheck;
}


## 5. File Operations Debugging
/*
  Shows file handling with error tracing and safety checks
*/

let
  lib = import <nixpkgs/lib>;
  path = ./test.txt;
  fileContent = lib.debug.traceValFn (x:
    "File ${toString path}: ${if builtins.pathExists path 
      then "Exists (${toString (builtins.stringLength x)} chars)" 
      else "Missing!"
    }"
  ) (builtins.readFile path);
in
fileContent


## 6. Safe File Reading with Error Handling
/*
  Implements try/catch pattern for robust file operations
*/

let
  filePath = ./non-existing-file.txt;
  readFileSafe = path:
    if builtins.pathExists path then
      builtins.readFile path
    else
      throw "File ${toString path} not found!";

  fileContent = let
    result = builtins.tryEval (readFileSafe filePath);
  in
    if result.success then
      result.value
    else
      builtins.trace "Error caught: ${result.value}" null;
in
fileContent


## 7. Custom Debug Utilities
/*
  Creates reusable debug functions for complex workflows
*/

let
  lib = import <nixpkgs/lib>;

  Debug = operation: path: value:
    lib.debug.traceValFn (x:
      "${operation} on ${toString path}: ${
        if builtins.pathExists path then "Exists" else "Missing"
      }\nRaw value: ${builtins.toJSON x}"
    ) value;

  filePath = ./test.txt;
  dir = ./.;
in
{
  readFileContent = Debug "File read" filePath (builtins.readFile filePath);
  readDir = Debug "Directory scan" dir (builtins.readDir dir);
}


## 8. Deep Structure Tracing
/*
  demonstrates nested data inspection with lazy evaluation control
*/

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
      lazy = "Unevaluated section";
    };
    moreNesting = [
      { data = { location = "Asia"; weather = "Cloudy"; time = "12:12:30"; }; }
      { api = { weather = "weather.api.com"; time = ["1 pm" "2 pm"]; }; }
      { lazyII = "Another unevaluated section"; }
    ];
  };
in
{
  trace1 = lib.debug.traceSeq nestedStructure nestedStructure;
  trace2 = lib.debug.traceSeq nestedStructure.moreNesting nestedStructure.moreNesting;
}
