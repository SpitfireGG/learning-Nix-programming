# Lists

This document explains the Nix code found in `ch03/ch03.nix`, which serves as an introduction to **Lists** in the Nix language. Lists are fundamental ordered collections of values.

The code is structured within a `let ... in` block, defining various examples and then exporting them using `inherit` for easy evaluation. It also uses `lib = import <nixpkgs/lib>;` to bring in helpful functions from the Nixpkgs standard library, supplementing the core language `builtins`.

## Overview of Concepts Covered

### 1. Basic List Creation (`## Section 1`)

*   **Syntax:** Lists are defined using square brackets `[ ]`, with elements separated by spaces.
*   **Empty List:** An empty list is simply `[ ]` (demonstrated by `empty_set`).
*   **Numeric List:** Shows a list containing numbers (`nums`). Note that lists can contain duplicate values (`1`, `3`, `5` appear multiple times).
*   **Mixed-Type List:** Demonstrates that lists *can* technically hold elements of different types (`mixed`), including numbers, strings, `null`, and even attribute sets. While possible, lists containing only one type are often easier to work with.

### 2. Core List Operations (`## Section 2`)

This section covers essential functions for accessing and analyzing lists, using both `builtins` (core language features) and `lib` (library functions).

*   **Accessing Elements:**
    *   `builtins.head list`: Gets the very first element (e.g., `first`). *Caution: Causes an error if the list is empty.*
    *   `builtins.tail list`: Gets a new list containing all elements *except* the first (e.g., `remaining`). Returns `[]` if the list has 0 or 1 element.
    *   `builtins.elemAt list index`: Gets the element at a specific zero-based index (e.g., `grabFromIdx` gets the element at index 2, which is the 3rd element). *Caution: Error if index is out of bounds.*
*   **Sub-Lists & Reordering:**
    *   `lib.take n list`: Creates a new list containing only the first `n` elements (e.g., `take3`).
    *   `lib.drop n list`: Creates a new list containing all elements *except* the first `n` (e.g., `drop4`).
    *   `lib.reverseList list`: Creates a new list with the elements in reverse order (e.g., `reverseList`).
*   **List Analysis & Info:**
    *   `builtins.length list`: Returns the number of elements in the list (e.g., `len`).
    *   `builtins.elem element list`: Checks if `element` exists within the `list`, returning `true` or `false`.
    *   `lib.unique list`: Creates a new list containing only the unique elements from the original, preserving the order of first appearance (e.g., `grabUnique`).

### 3. List Generation (`## Section 3`)

*   **`builtins.genList function count`:** Creates a list by calling `function` `count` times. The function receives the current index (0 to `count - 1`) and should return the value for that list position.
    *   Example (`mkList`): `(i: i * 2) 5` generates `[0 2 4 6 8]`.
    *   Example (`toStr`): `(i: "item-${toString i}") 3` generates `["item-0" "item-1" "item-2"]`.

### 4. List Manipulation & Functional Operations (`## Section 4`)

*   **Concatenation (`++`):** The `++` operator combines two lists into a new, single list (e.g., `concat`). This is a "shallow merge" as it will create a new copy of the list and won't work for deeply nested lists.
*   **Functional Programming:** Applying functions over lists is very common in Nix.
    *   `builtins.any predicate list`: Returns `true` if the `predicate` function returns `true` for *at least one* element in the list (e.g., `numsLessThan4`).
    *   `builtins.map function list`: Creates a *new* list by applying `function` to *every* element of the input list (e.g., `squared_nums`).
    *   `builtins.filter predicate list`: Creates a *new* list containing only the elements from the input list for which the `predicate` function returns `true`.
    *   **Modulo (`lib.mod`):** The example `evenSquared` demonstrates filtering for odd numbers using `lib.mod x 2 == 1` (since Nix lacks a `%` operator) and then mapping a squaring function over the result.

### 5. Advanced Operations (`## Section 5`)

This section dives into more complex list processing techniques.

*   **Type Filtering:** Uses `builtins.filter` combined with type-checking functions (`builtins.isAttrs`, `builtins.isString`) to extract elements of a specific type from a mixed list (`findSet`, `findAttrsMixed`, `findStringsInMixed`).
*   **Folding (`builtins.foldl'`):** Reduces a list down to a single value. `foldl'` applies an *operator* function `(accumulator: element) -> newAccumulator` iteratively. The `'` denotes a *strict* fold (generally preferred for performance in simple cases). The example `foldFn` demonstrates summing a list.
*   **Map & Concatenate (`lib.concatMap`):** Applies a function to each element where the function itself returns a list, then concatenates all those resulting lists into one flat list. The example `dupNtimes` uses it with `lib.replicate` to duplicate elements.
*   **Map with Index (`lib.imap0`):** Similar to `map`, but the function receives both the index (starting from 0) and the value of each element (e.g., `indexedNums`).
*   **Conditional Inclusion:**
    *   `lib.optional condition element`: Returns `[ element ]` if `condition` is true, otherwise `[ ]`. Useful for adding a single optional item (e.g., `mayIncludeAdmin`, `mayIncludeTester` used in `users`).
    *   `lib.optionals condition list`: Returns the entire `list` if `condition` is true, otherwise `[ ]`. Useful for adding a group of optional items (e.g., `betaFeatures` used in `activeFeatures`).

## Exporting Results (`in { inherit ...; }`)

The final `in` block uses `inherit` to make all the defined variables (like `nums`, `first`, `len`, `mkList`, `foldFn`, etc.) available as attributes of the set returned when this Nix file is evaluated. The comments within the `inherit` block attempt to group the exported variables by the section they were primarily defined or demonstrated in.

## Practical Exercises (`Practical exercises`)

This section provides example `nix eval -f lists.nix ...` commands. These allow you to run the Nix code from your terminal and directly observe the results of specific variable definitions or expressions, helping to solidify understanding of how these list operations work. Using `--json | jq` is suggested for complex outputs like sets or nested lists to view them clearly.

---
