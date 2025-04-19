## Working with Files in Nix
# =========================

let
  lib = import <nixpkgs/lib>;
  pkgs = import <nixpkgs> { };

  # Path Definitions
  # ----------------
  # Relative path (current directory scope)
  filename = ./test.txt;

  # Absolute path (full filesystem path)
  filename2 = /home/kenzo/nt_info.txt;

  # Basic File Operations
  # ---------------------
  # Reading file contents as strings
  content = builtins.readFile filename;
  networking_info = builtins.readFile filename2;

  # Path Manipulation
  # -----------------
  # Convert path to string representation
  pathToString = toString filename2;

  # Concatenate paths
  absolutePath = /home/kenzo/Dev/Nix/learning-Nix-programming/ch07;
  concatPaths = absolutePath + "/test.txt";

  # Error Handling Example
  # ----------------------
  # This would throw an error if uncommented:
  /*
    catchWithTrace = builtins.trace "Reading file as string" (
      builtins.readFile ../.  # Trying to read directory
    );
  */

  # Fixed version reading actual file
  fixedCatchWithTrace = builtins.trace "Reading file successfully" (
    builtins.readFile ../ch07/test.txt
  );

  # File System Checks
  # ------------------
  exists = builtins.pathExists ./test.txt;

  # Complex Path Handling
  # ---------------------
  dir = ./testDir;
  file = "config.txt";
  pathToFile = dir + "/${file}";

  # The throw keyword aborts evaluation when trying to evaluate a set of derivations
  # Returns success=true if valid, false otherwise
  checkPathFile =
    if builtins.pathExists pathToFile then
      builtins.typeOf file
    else
      builtins.trace "Path might not exist" null;

  # File Filtering
  # --------------
  dirContents = builtins.readDir ./.;
  regularFiles = lib.filterAttrs (name: type: type == "regular") dirContents;

  # Custom File Search
  # ------------------
  searchPath = [
    ./.
    ../ch07
  ];
  findFile =
    let
      find = file: paths: lib.findFirst (dir: builtins.pathExists (dir + "${file}")) null paths;
    in
    find "test.txt" searchPath;

in
{
  inherit
    content
    networking_info
    exists
    dirContents
    findFile
    pathToString
    concatPaths
    checkPathFile
    regularFiles
    fixedCatchWithTrace
    pathToFile
    ;
}

## Execution Notes
# ===============
/*
  To pretty-print the output with error handling:
  nix eval --file ch07.nix --json | jq

  Note: Requires jq installed for JSON formatting

  Common Error Example:
  --------------------
  Trying to read a directory with readFile will throw:
  error: reading from file '/path/to/directory': Is a directory

  The fixed version demonstrates proper file path handling
  by pointing to an actual file instead of directory
*/

## error analysis
# ==============

/*
  original error occurs because:
  - readFile only works with files, not directories
  - the trace shows where evaluation failed
  - error message clearly indicates the problem type

  fix strategies:
  1. usee readDir for directories instead of readFile
  2. verify path types before operations
  3. use pathExists check before file operations
*/
