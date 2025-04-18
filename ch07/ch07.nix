# working with files in nix

let
  lib = import <nixpkgs/lib>;
  pkgs = import <nixpkgs> { };

  filename = ./test.txt; # this is called a relative path because it only relates to the files on the curren directory scope i.e the current directory
  filename2 = /home/kenzo/nt_info.txt; # this is an absolute path i.e it is referenced through a complete address to a file or directory starting from the root of the file system

  # reading file as a string
  content = (builtins.readFile) filename;
  networking_info = builtins.readFile filename2;

  # converting paths to string
  pathToString = toString filename2;

  #concat  paths
  absolutePath = /home/kenzo/Dev/Nix/learning-Nix-programming/ch07;
  concatPaths = absolutePath + "/test.txt";

  # you can make this more generalized and perform error tracing by adding the trace function

  /*
    #this is going to throw an error message
        catchWithTrace = builtins.trace "reading file as a string using the builtin function" (
          builtins.readFile ../.
        );
  */

  # replaced fixed code ❌
  fixedCatchWithTrace = builtins.trace "reading file as a string using the builtin function" (
    builtins.readFile ../ch07/test.txt
  );

  # checking if the file exists or not
  exists = (builtins.pathExists) ./test.txt;

  # example 1
  dir = ./testDir;
  file = "config.txt";
  pathToFile = dir + "/${file}";
  # checking if the file exists , if yes then checking the filetype else return an error message
  checkPathFile =
    if (builtins.pathExists) pathToFile then
      (builtins.typeOf) file
    else
      (builtins.trace) "path might not exist" null;

  #filtering files
  dirContents = (builtins.readDir) ./.;
  regularFiles = lib.filterAttrs (name: type: type == "regular") dirContents;

  # custom file search
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
    #catchWithTrace
    fixedCatchWithTrace
    pathToFile
    ;

}
# _________________________________ this  is worth some reading definitely might help you ahead_______________________________________________
/*
  the output of this code looks something straight of the junk , so for the sake of understanding try parsing the output with --json flag piped  with jq ( the jq program  has to be installed to get the command working)

  command for pretty printing the output
  nix eval --file ch07.nix  --json | jq

  more info : if you run the command you will get an error message that states :
*/

/*
  ❯ nix eval --file ch07.nix --json | jq
  trace: reading file as a string using the builtin function
  error:
         … while evaluating attribute 'catchWithTrace'
           at /home/kenzo/Dev/Nix/learning-Nix-programming/ch07/ch07.nix:43:5:
             42|     findFile
             43|     catchWithTrace
               |     ^
             44|     ;

         … while calling the 'trace' builtin
           at /home/kenzo/Dev/Nix/learning-Nix-programming/ch07/ch07.nix:15:20:
             14|
             15|   catchWithTrace = builtins.trace "reading file as a string using the builtin function" (
               |                    ^
             16|     builtins.readFile ../.

         … while calling the 'readFile' builtin
           at /home/kenzo/Dev/Nix/learning-Nix-programming/ch07/ch07.nix:16:5:
             15|   catchWithTrace = builtins.trace "reading file as a string using the builtin function" (
             16|     builtins.readFile ../.
               |     ^
             17|   );

         error: reading from file '/home/kenzo/Dev/Nix/learning-Nix-programming': Is a directory
*/

/*
        looking at the error message, the ccatchWithTrace attribute in the code attempts to  read a dir ../. ( not a file ) using the builtin readFile function but the readFile function would only accept a file as the input so it throws an error. and due to the error we recieved from the builtin.trace function,the parsing fails

    to solve this issue : you have several options but providing a file instead of a dir will be a good fit

  the fixed code is written on the same line as the original code above.
*/
