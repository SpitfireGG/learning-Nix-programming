## Understanding the nix's function signature
# ==================================================

/* Understanding the function signature, how they are defined and know how they work is the core fundamental that a developer needs to understand tobecome proficient in nix programming. Without understanding what values or expressions a function takes, it becomes hard to play around and read the documentations. */

#  from the previous code, filterAttrs has the  following signature:

/*
filterAttrs :: (String -> Any -> Bool) -> AttrSet -> AttrSet

1. the 'filterAttrs' is the function name and the '::' is a convention for meaning "has the type"
2. inside the (String -> Any ->  Bool), the 1st arguement expects a "string" type , 2nd arguement expects any attribute value ( of any nix type : set, list, string, int etc ), the 3rd arguement is the return type, determines whether to keep the attribute or leave it
3. the preceeding 'AttrSet 'is the attribute to process, in our previous code from ch10, it uses a set3. the preceeding AttrSet is the attribute to process, in our previous code from ch10, it uses a set3. the preceeding AttrSet is the attribute to process, in our previous code from ch10, it uses a set 
4. the final 'AttrSet' is the  output of the program , we get the output in a set format
*/
