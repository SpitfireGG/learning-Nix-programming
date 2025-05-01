## Working with files & derivations

let
  # --- Imports ---
  lib = import <nixpkgs/lib>;
  pkgs = import <nixpkgs> { };

  # --- Path Definitions ---
  # Paths can be relative (to the file's location) or absolute.
  relativeTestFile = ./test.txt; # Assumes test.txt exists in the same directory
  absoluteInfoFile = /home/kenzo/nt_info.txt; # NOTE: Hardcoded absolute path, often discouraged in Nix
  baseExampleDir = /home/kenzo/Dev/Nix/learning-Nix-programming/ch07; # Another hardcoded path example

  # --- Basic File Reading ---
  # Read the entire content of a file into a string.
  relativeFileContent = builtins.readFile relativeTestFile;
  absoluteFileContent = builtins.readFile absoluteInfoFile;

  # --- Path Manipulation ---
  # Convert a path value to its string representation.
  absolutePathAsString = toString absoluteInfoFile;

  # Concatenate path strings (or a path and a string).
  # Note: Using string interpolation is often clearer than `+` for paths.
  concatenatedPath = "${baseExampleDir}/test.txt";
  # Example using the '+' operator (works similarly but interpolation is often preferred)
  concatenatedPathAlt = baseExampleDir + "/test.txt";

  # --- Error Handling Example (readFile on Directory) ---
  # The following demonstrates a common error: trying to read a directory as a file.
  # This code block is commented out because it would cause evaluation to fail.
  /*
    readFileOnDirError = builtins.trace "Attempting to read a directory, this will fail" (
      builtins.readFile ./../ # Assuming '../' is a directory relative to this file
    );
    # Error message would be similar to:
    # error: reading from file '/path/to/some/directory': Is a directory
  */

  # Corrected example: reading an actual file within a relative path.
  readFileCorrected = builtins.trace "Reading file successfully using relative path" (
    # Assumes ../ch07/test.txt exists relative to this Nix file's location
    builtins.readFile ../ch07/test.txt
  );

  # --- File System Checks ---
  # Check if a path exists in the filesystem. Returns true or false.
  testFileExists = builtins.pathExists relativeTestFile;
  nonExistentFileCheck = builtins.pathExists ./does_not_exist.txt; # Should return false

  # --- Complex Path Handling & Conditional Logic ---
  # Example combining path construction, existence check, and conditional evaluation.
  configDir = ./testDir; # Assumes ./testDir exists relative to this file
  configFile = "config.txt";
  fullConfigPath = configDir + "/${configFile}"; # Construct path: ./testDir/config.txt

  # Check if the config file exists. If yes, return its type (string); otherwise, trace and return null.
  # Note: Returning `builtins.typeOf configFile` ("string") if it exists might not be
  # the most practically useful result, but demonstrates conditional logic.
  # A more common pattern might be to return the path itself or its contents.
  checkConfigFile =
    if builtins.pathExists fullConfigPath then
      # File exists, return the type of the 'configFile' variable (which is "string")
      builtins.typeOf configFile
    else
      # File doesn't exist, print a trace message and return null
      builtins.trace "Configuration file path does not exist: ${toString fullConfigPath}" null;

  # --- Directory Operations: Listing and Filtering ---
  # Read the contents of a directory. Returns an attrset mapping names to types ("regular", "directory", "symlink", etc.).
  currentDirContents = builtins.readDir ./.; # List contents of the current directory

  # Filter the directory contents to include only regular files.
  regularFilesInCurrentDir = lib.filterAttrs (name: type: type == "regular") currentDirContents;

  # --- Custom File Search Function ---
  # Example of searching for a file within a list of directories (a search path).
  searchPathExample = [
    ./. # Current directory
    ../ch07 # Parent's ch07 directory
    ./nonExistentDir # A directory that might not exist
  ];

  # Function to find the first directory in `paths` where `file` exists.
  # Returns the directory path if found, otherwise returns null.
  findFileInSearchPath =
    let
      # Inner helper function for clarity
      findFirstPathWithFile =
        fileName: pathsList:
        lib.findFirst
          # Predicate: checks if the file exists within the current directory being tested
          (dir: builtins.pathExists (dir + "/${fileName}"))
          # Default value if not found in any path
          null
          # The list of paths to search through
          pathsList;
    in
    findFirstPathWithFile "test.txt" searchPathExample; # Search for "test.txt" in the defined paths

in
{
  # File Contents
  content = relativeFileContent; # Renamed from 'content' for clarity
  networking_info = absoluteFileContent; # Kept original name

  # Path Strings & Derived Paths
  pathToString = absolutePathAsString;
  concatPathExample = concatenatedPath;
  pathToConfigFile = fullConfigPath; # Renamed from pathToFile

  # Checks & Conditionals
  fileExists = testFileExists; # Renamed from 'exists'
  configFileCheckResult = checkConfigFile; # Renamed from checkPathFile

  # Directory Info
  directoryContents = currentDirContents; # Renamed from dirContents
  regularFiles = regularFilesInCurrentDir; # Renamed from regularFiles

  # Search Result
  foundFileLocation = findFileInSearchPath; # Renamed from findFile

  # Example demonstrating corrected readFile usage
  fixedTraceExample = readFileCorrected; # Renamed from fixedCatchWithTrace

  # Exposing intermediate paths/configs if useful for debugging/inspection
  # sourceRelativePath = relativeTestFile;
  # sourceAbsolutePath = absoluteInfoFile;
}

# --- Notes ---
/*
  To evaluate this Nix expression and pretty-print the resulting attribute set as JSON:
    nix eval --file your_file_name.nix --json | jq

  Requires 'jq' to be installed for pretty-printing.
*/

