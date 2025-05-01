# Nix Lazy Evaluation

Welcome! This set of exercises focuses on understanding **lazy evaluation** in the Nix language. Work through these files to observe how and when Nix computes values, and learn how to control evaluation.

## Structure

This directory contains:

*   `readme.md`: This file.
*   `ex001.nix`: Observing evaluation order via `builtins.trace`.
*   `ex002.nix`: Forcing evaluation with `builtins.seq` and `builtins.deepSeq`.
*   `ex003.nix`: Laziness avoiding errors & using `builtins.tryEval`.
*   `run.sh`: A script to help test your solutions (optional).

## How to Work Through the Exercises

1.  **Select an Exercise:** Start with `ex001.nix`.
2.  **Read Instructions:** Open the `.nix` file (e.g., `ex001.nix`). Inside, comments detail the task, expected output (including **trace output** on stderr), and placeholders like `/* --- Your Code Here --- */`.
3.  **Code:** Edit the `.nix` file directly, filling in the missing parts. For some exercises, you'll predict the trace output.
4.  **Test:** Evaluate your solution using `nix-instantiate` from this directory:
    ```bash
    # Example for the first exercise
    nix-instantiate --eval ./ex001.nix --show-trace

    # Example for the second exercise
    nix-instantiate --eval ./ex002.nix --show-trace
    ```
    *   `--eval`: Evaluates the file and prints the final result (stdout).
    *   `--show-trace`: Provides detailed errors *and* is crucial for seeing `builtins.trace` messages (stderr).

5.  **Using `run.sh` (Optional):**
    *   Make it executable: `chmod +x run.sh`
    *   Run it: `./run.sh`
    *   This script runs `nix-instantiate` on all `ex*.nix` files. Carefully examine both the final output (stdout) and the trace messages (stderr) for each exercise.

6.  **Verify:** Compare your resulting value (stdout) and, most importantly, the **order and content of trace messages** (stderr) to the "Expected Result (Stdout)" and "Expected Trace Output (Stderr)" described in the comments of the specific `.nix` file.
7.  **Consult Hints/Solution:** Solution hints or snippets are often included in the comments within the exercise file. Try your best first!
8.  **Repeat:** Move on to the next exercise file (`ex002.nix`, `ex003.nix`).

## Concepts Covered

*   **`ex001.nix`**: Observing evaluation order via `builtins.trace`, effect of `if/then/else`.
*   **`ex002.nix`**: Forcing evaluation with `builtins.seq` and `builtins.deepSeq`.
*   **`ex003.nix`**: Demonstrating how laziness avoids evaluating error conditions; using `builtins.tryEval`.

Good luck
