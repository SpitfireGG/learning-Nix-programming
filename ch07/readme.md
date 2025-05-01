# Files & paths

## Introduction

Nix expressions frequently need to interact with files and directories. This could involve reading configuration, accessing source code, or locating assets necessary for a build. This chapter explains the core concepts behind how Nix handles these interactions. For concrete code examples illustrating each concept, please refer to the accompanying `.nix` file for this chapter.

## Paths

In Nix, a file path (like `./myfile.txt` or `/etc/nixos/configuration.nix`) is treated as a special **path type**, distinct from a plain string. This distinction is important because Nix often needs to know that something represents a location in the filesystem, especially when copying files into the Nix store during builds.

There are two primary kinds of paths:

1.  **Relative Paths:** Defined relative to the location of the Nix file being evaluated (e.g., `./data.json`, `../src/main.go`). These are generally preferred as they make your code more portable and independent of the specific machine's filesystem structure.
2.  **Absolute Paths:** Fully specified from the root directory (e.g., `/home/user/config.yaml`). While usable, hardcoding these can make your Nix code less reproducible and harder for others to use. It's often better to pass such paths as inputs if needed.

## Filesystem Operations

Nix provides built-in functions to perform common filesystem tasks:

*   **Reading File Content:** You can load the entire content of a *file* into a Nix string. This is fundamental for configuration management or accessing data. Remember, this operation is strictly for files; attempting it on a directory will cause an error.
*   **Checking Existence:** Before trying to use a file or directory, it's crucial to verify if it actually exists. Nix provides a function to check this, returning `true` or `false`. This is often used within conditional (`if/then/else`) logic to handle missing files gracefully or perform alternative actions.
*   **Listing Directory Contents:** To discover what's inside a *directory*, Nix can list its contents. This operation typically returns the names of the items within the directory and their types (e.g., whether they are regular files, sub-directories, or symbolic links). This is distinct from reading the content *of* a file.
*   **Manipulating Paths:** You'll often need to construct paths dynamically (e.g., joining a directory path and a filename) or convert a path value into its string representation (perhaps for logging or passing as a command-line argument). Nix supports these manipulations.

## Advanced Techniques with `lib`

The Nix Packages collection (`nixpkgs`) includes a standard library (`lib`) with many helpful functions. When working with files, `lib` functions are often used for:

*   **Filtering Directory Listings:** Selecting specific items from a directory's contents based on their type or name (e.g., finding all `.nix` files).
*   **Searching Paths:** Implementing logic to find a specific file across a predefined list of directories (a "search path").

## Common Issues and Best Practices

*   **Reading Directories:** The most common error is attempting to read a directory as if it were a file. Use the appropriate function for listing directory contents instead.
*   **Portability:** Avoid hardcoding absolute paths. Use relative paths or pass external paths as inputs to your Nix functions or derivations.
*   **Existence Checks:** Always consider checking if a file exists before attempting to read it, especially if its presence isn't guaranteed. This makes your code more robust.

## Exploring the Code

The concepts described here are demonstrated with practical examples in the accompanying `.nix` file. Please review that file to see how `builtins.readFile`, `builtins.pathExists`, `builtins.readDir`, path concatenation, and `lib` functions are used in practice. You can evaluate the code using `nix eval --file your_file_name.nix` (optionally piping to `jq` for pretty JSON output) to see the results of these operations.
