# Function (a deep dive)

This set of exercises is designed to help you practice and deepen your understanding of functions in the Nix language. We'll cover everything from basic definitions to more advanced concepts like higher-order functions, recursion, and attribute set manipulation.

## Structure

This directory contains the following files:

*   `readme.md`: This file.
*   `ex001.nix`: Basic function definition, single/multiple arguments (currying).
*   `ex002.nix`: Attribute set parameters (destructuring, defaults, required args, `...`, `@`).
*   `ex003.nix`: Higher-Order Functions (using `map`, implementing simple HOFs).
*   `ex004.nix`: Recursion (list processing).
*   `ex005.nix`: Advanced Patterns (composition, factories, `rec`).
*   `run.sh`: A script to help test your solutions (optional) all at once

## How to Work Through the Exercises

1.  **Select an Exercise:** Start with `ex001.nix`.
2.  **Read Instructions:** Open the `.nix` file (e.g., `ex001.nix`). Inside, you'll find comments detailing the specific task(s), expected output, and placeholders like `/* --- Your Code Here --- */` or `/* ... */`.
3.  **Code:** Edit the `.nix` file directly, filling in the missing parts according to the instructions within the file.
4.  **Test:** You can test your solution for a specific file using `nix-instantiate`. This command evaluates the Nix expression and prints the resulting value. Run this from the current directory (`nixspin/ch04/exercises`):
    ```bash
    # Example for the first exercise
    nix-instantiate --eval ./ex001.nix --show-trace

    # Example for the second exercise
    nix-instantiate --eval ./ex002.nix --show-trace
    ```
    *   `--eval`: Tells Nix to evaluate the file and print the result.
    *   `--show-trace`: Provides more detailed error messages if something goes wrong.
    *   *(Optional: Use `nix repl ./ex<nnn>.nix` for interactive testing)*

5.  **Using `run.sh` (Optional):**
    *   The provided `run.sh` script attempts to run `nix-instantiate` on all `ex*.nix` files.
    *   Make it executable: `chmod +x run.sh`
    *   Run it: `./run.sh`
    *   This helps quickly check if all exercises evaluate without major errors, but you should still manually compare the output for *each* exercise against the expected output described in its comments. Note that exercises designed to test error conditions (like Exercise 2's missing required argument) *should* cause an error message when run individually or via `run.sh` if not handled with cautions.

6.  **Verify:** Compare the output from `nix-instantiate` (or `run.sh`) to the expected output described in the comments of the specific `.nix` file you are working on.
7.  **Consult Solution (If Needed):** The solution logic is typically included within the same `.nix` file, often commented out or provided as a reference point within the instructions. Try your best before relying heavily on it!
8.  **Repeat:** Move on to the next exercise file (`ex002.nix`, `ex003.nix`, etc.).

## Concepts Covered (Mapped to Files)

*   **`ex001.nix`**: Basic function definition, currying.
*   **`ex002.nix`**: Attribute set parameters, defaults, required args, `...`, `@`.
*   **`ex003.nix`**: Higher-Order Functions (`map`, `mapAttrs`).
*   **`ex004.nix`**: Recursion.
*   **`ex005.nix`**: Function composition, function factories, `rec`.

Good Luck!
