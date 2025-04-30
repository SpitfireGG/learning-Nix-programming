# Lists exercises

Chapter 3! Here you'll get hands-on practice working with **Nix lists**, applying the concepts and functions covered in the main chapter file (`../ch03.nix`).

These exercises will help solidify your understanding of how to create, access, manipulate, and process lists using both built-in Nix functions and helpers from the Nixpkgs standard library (`lib`).

## Fix the Code! :

Each `ex*.nix` file contains:

1.  Some pre-written Nix code involving lists.
2.  `# TODO:` comments hinting at what needs fixing or completing.
3.  Sometimes, `null` placeholders that you need to replace with correct Nix expressions.
4.  A series of `assert` statements at the end.

**Your goal is to modify the Nix code in each file so that *all* the `assert` statements within that file evaluate to `true`.**

Remember how `assert` works:
`assert <condition>; <result>`

*   If `<condition>` evaluates to `true`, Nix continues and returns `<result>`.
*   If `<condition>` evaluates to `false`, Nix stops evaluation immediately and throws an error.

## How to Run the Exercises

1.  Make sure you are in this directory (`ch03/exercises/`) in your terminal.
2.  Make the runner script executable (you only need to do this once):
    ```bash
    chmod +x run.sh
    ```
3.  Execute the runner script:
    ```bash
    ./run.sh
    ```

The script will attempt to evaluate each `ex*.nix` file using `nix eval`.

*   **If an exercise file contains an error or a failing assertion:** The script will stop and display the error message from `nix eval`. Open that specific `ex*.nix` file, fix the problem according to the `TODO` comments and assertion checks, and save your changes.
*   **If an exercise file evaluates successfully:** The script will print `OK (Assertions Passed)` and move to the next one.

**Keep editing the files and re-running `./run.sh` until the script runs through all exercises without stopping and prints "Chapter 03 Exercises Passed!" at the end.**

## The Exercise covers

*   **`ex001.nix`**: Focuses on the core `builtins` for accessing list elements (`head`, `tail`, `elemAt`) and getting information (`length`, `elem`). Pay attention to indexing!
*   **`ex002.nix`**: Practices using common list manipulation functions from `lib`: `take`, `drop`, `reverseList`, and `unique`.
*   **`ex003.nix`**: Covers dynamic list creation with `builtins.genList` and combining lists using the `++` operator.
*   **`ex004.nix`**: Tests your understanding of fundamental functional patterns: `map`, `filter`, and `any`. Don't forget `lib.mod` for checking even/odd!
*   **`ex005.nix`**: Dives into more advanced list processing with `foldl'`, `concatMap`, and `imap0` (map with index).
*   **`ex006.nix`**: Challenges you to conditionally include elements or lists using `lib.optional` / `lib.optionals` and to correctly filter lists containing mixed data types using `builtins.is*` functions.

## Attention!!

*   If you're stuck, refer back to the main chapter file (`../ch03.nix`) for examples of how these functions are used.
*   Remember that list indexing in Nix starts at **0**.
*   Nix doesn't have a built-in `%` operator for modulo; use `lib.mod a b`.
*   Don't hesitate to look up function documentation if needed (e.g., search the Nixpkgs manual online for `lib.lists` functions, or use `nix repl` to experiment).

