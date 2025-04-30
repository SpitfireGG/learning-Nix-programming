## Exercises 

navigate to the `exercises/` directory for this chapter. Each file (`ex001.nix`, `ex002.nix`, etc.) contains a small Nix problem related to attribute sets.

Your goal is to **fix the code** or **fill in the blanks** (marked with `# TODO:` comments and sometimes `null` placeholders) so that all the `assert` statements in the file evaluate to `true`.

The `assert condition; result` construct checks if the `condition` is true.
- If `true`, evaluation continues, and the `result` is returned.
- If `false`, evaluation stops immediately with an error message.

Run the checker script from within the `ch02/exercises/` directory:
```bash
cd ch02/exercises
chmod +x run.sh 
./run.sh
```
