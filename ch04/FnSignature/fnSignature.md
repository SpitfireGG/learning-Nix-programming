# Understanding Nix's Function Signature

## ==================================================
/*
Understanding the function signature, how they are defined and know how they work
is the core fundamental that a developer needs to understand to become proficient
in nix programming. Without understanding what values or expressions a function takes,
it becomes hard to play around and read the documentations.
*/


## `filterAttrs` Function Signature
filterAttrs :: (String -> Any -> Bool) -> AttrSet -> AttrSet


### Signature Breakdown

1. The `filterAttrs` is the function name and the `::` is a convention for meaning "has the type"

2. Inside the `(String -> Any -> Bool)`:
   - 1st argument expects a "string" type
   - 2nd argument expects any attribute value (of any nix type: set, list, string, int etc)
   - 3rd argument is the return type, determines whether to keep the attribute or leave it

3. The preceding `AttrSet` is the attribute to process (in our previous code from ch10, it uses a set)

4. The final `AttrSet` is the output of the program (we get the output in a set format)
