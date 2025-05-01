# Chapter 6: Nix Attribute Sets - Selection, Inheritance, and Merging

## Introduction

Attribute sets (attrsets) are fundamental data structures in Nix, akin to maps, dictionaries, or objects in other languages. They are collections of key-value pairs used extensively for configuration, package definitions, function arguments, and more. Mastering how to select data from, combine, and construct attribute sets is crucial for effective Nix programming.

This chapter explores the primary ways to work with attrsets: accessing nested values, reusing attributes through inheritance, and combining multiple sets using different merging strategies.

## Key Concepts

*   **Attribute Selection:**
    *   **Dot Notation (`.`):** The most common way to access the value associated with a key (e.g., `mySet.myKey.nestedKey`). This fails if any part of the path doesn't exist.
    *   **`lib.attrByPath`:** A safer way to access potentially missing nested attributes. It takes a list of path elements (strings) and a default value to return if the path doesn't exist (e.g., `lib.attrByPath [ "key1" "missingKey" ] defaultValue mySet`). Requires importing `nixpkgs/lib`.
    *   **Default Operator (`or`):** Provides a default value directly during access if the attribute is missing or null (e.g., `mySet.maybeMissingKey or defaultValue`).

*   **Attribute Inheritance (`inherit`):** A mechanism to copy attributes (key-value pairs) into the current set, reducing repetition.
    *   **From Scope (`inherit attr1 attr2;`):** Copies variables defined in the current `let` scope (or function arguments) into the set being defined. The key in the new set will be the same as the variable name.
    *   **From Another Set (`inherit (sourceSet) attr1 attr2;`):** Copies specified attributes from an existing `sourceSet` into the set being defined.

*   **Attribute Set Merging:** Combining two or more attrsets into a new one.
    *   **Shallow Merge (`//`):** Combines two sets. If both sets have the same top-level key, the value from the *right-hand* set completely replaces the value from the left-hand set. For nested sets, the entire nested set from the right overwrites the one from the left.
        ```nix
        { a = 1; b = { x = 1; }; } // { b = { y = 2; }; c = 3; }
        # Result: { a = 1; b = { y = 2; }; c = 3; }
        # Note: b.x is gone!
        ```
    *   **Recursive Merge (`lib.recursiveUpdate`):** Combines two sets, merging recursively. If both sets have the same key and *both values are attribute sets*, it merges the *contents* of those nested sets. Otherwise (or for non-set values), the right-hand side still overwrites the left. This is often preferred for combining configurations. Requires `nixpkgs/lib`.
        ```nix
        lib.recursiveUpdate { a = 1; b = { x = 1; }; } { b = { y = 2; }; c = 3; }
        # Result: { a = 1; b = { x = 1; y = 2; }; c = 3; }
        # Note: b.x is preserved!
        ```

## Code Example (`ch06.nix`)

The `ch06.nix` file demonstrates these concepts:

*   Defining sample nested configurations (`defaultConfig`, `userConfig`).
*   Selecting attributes using dot notation and `lib.attrByPath`.
*   Using `inherit` to construct sets.
*   Performing both shallow (`//`) and recursive (`lib.recursiveUpdate`) merges.
*   Using the `or` operator for safe access.
*   Combining these techniques in a practical configuration function (`mkConfig`)
