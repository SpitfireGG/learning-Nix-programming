### Sets or attribute sets

Sets or attribute sets are really the core of the Nix language, since ultimately the language is all about creating derivations, which are really just sets of attributes to be passed to build scripts.

Sets are just a list of name/value pairs (called attributes) enclosed in curly brackets, where each value is an arbitrary expression terminated by a semicolon. For example:

{
    x = 123;
    text = "Hello";
    y = f { bla = 456; };
}

This defines a set with attributes named x, text, y. The order of the attributes is irrelevant. An attribute name may only occur once.

- NOTE: comment one of the following codes and run for yourself to find the output and tinker the code to see what happens

- comment or uncomment one of the sections and play around until you feel confident and move onto the exercises section

### `rec`ursive sets 'rec'

Unlike the ordinary set, the recursive set which allows the attributes from within the set without any further let-in constructs
