# Nix Debugging Exercises

This directory contains a set of hands-on exercises designed to help you practice the Nix debugging and tracing techniques covered previously. you will be fixing errors, filling in missing parts (`/* ??? */`), and correcting logic within the provided `ex001.nix` file.

The goal is to modify `ex001.nix` so that every exercise within it evaluates successfully to the boolean value `true`. A runner script (`run.sh`) is provided to automatically check your progress.

## Prerequisites

*   A basic understanding of the Nix language (let-in, functions, basic types, attribute sets).
*   Familiarity with the debugging concepts covered:
    *   `builtins.trace`
    *   `lib.debug.traceVal`, `lib.debug.traceValFn`
    *   `assert`, `builtins.abort`
    *   `builtins.tryEval`, `throw`
    *   `builtins.pathExists`, `builtins.typeOf`

## Files Included

1.  **`ex001.nix`**: The main file containing the Nix code snippets for each exercise. **This is the file you will edit.** It contains comments indicating the goal of each exercise and placeholders or bugs that need fixing.
2.  **`run.sh`**: A Bash script that automatically evaluates each exercise in `ex001.nix` and reports whether it passed (evaluated to `true`) or failed.
3.  **`dummy.txt`**: An empty file required by Exercise 7 for testing file existence checks.

## Setup Instructions

1.  **Save the Files:** Ensure all three files (`ex001.nix`, `run.sh`, `dummy.txt`) are saved in the same directory.
2.  **Make Script Executable:** Open your terminal, navigate to the directory where you saved the files, and run the following command to give the runner script permission to execute:
    ```bash
    chmod +x run.sh
    ```

## How to Do the Exercises

1.  **Run the Checker:** Execute the runner script from your terminal:
    ```bash
    ./run.sh
    ```
    Initially, you will likely see several `FAIL` messages.

2.  **Inspect Failures:** Note which exercises failed. The script will indicate if it was a Nix evaluation error (the code crashed) or if the output was wrong (didn't evaluate to `true`).

3.  **Edit `ex001.nix`:** Open `ex001.nix` in your text editor.
    *   Locate the failing exercise (e.g., `exercise1 = ... ;`).
    *   Read the `# Goal:` comment above it.
    *   Identify the placeholder (`/* ??? */`), typo (e.g., `traceval`), or logical error.
    *   Modify the Nix code to fix the issue according to the exercise's goal. **Remember, the final expression for each exercise must evaluate to `true`.**

4.  **Save Your Changes:** Save the `ex001.nix` file after making corrections.

5.  **Re-run the Checker:** Go back to your terminal and run `./run.sh` again.

6.  **Repeat:** Continue this cycle of running the script, identifying failures, editing `ex001.nix`, saving, and re-running until all exercises report `PASS`.

## Understanding the Output

*   `[Test] Running exerciseN... PASS`: Your code for `exerciseN` evaluated successfully and returned `true`. Correct!
*   `[Test] Running exerciseN... FAIL (Wrong Output)`: Your code evaluated without crashing, but the final result was not `true`. Check your logic.
*   `[Test] Running exerciseN... FAIL (Nix evaluation error)`: Your Nix code for `exerciseN` failed to evaluate (e.g., syntax error, uncaught `abort` or `assert` failure). Check the Nix code structure and logic related to assertions or potential errors.

## Tips for Solving

*   **Read the Goals:** Pay close attention to the `# Goal:` comment for each exercise.
*   **Manual Evaluation:** If you're stuck on an exercise `exerciseN`, you can try evaluating it manually with tracing enabled to see more detail:
    ```bash
    nix eval --show-trace --impure .#exerciseN
    ```
    This will show the output from `builtins.trace`, `lib.debug.traceVal`, etc., which can help pinpoint the problem.
*   **Check Typos Carefully:** One exercise specifically involves a typo in a function name.
*   **Understand Return Values:** Ensure the *last* part of each exercise expression evaluates to `true`, even if tracing or other checks happen before it.

Good luck!
