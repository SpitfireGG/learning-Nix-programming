# Functions a deep dive

* **checkout: ch04Extended.nix  & ch04Extended_2.nix  for futher understanding**

## Introduction

Since Nix is a purely functional language, understanding how functions work is fundamental to effectively writing Nix expressions, managing configurations, or packaging software. They are first-class citizens, meaning they can be passed as arguments, returned from other functions, and assigned to variables just like any other value (like strings, numbers, or lists).

One key characteristic of Nix is its **lazy evaluation**. This means expressions (including function calls) are not evaluated until their results are actually needed. While this offers significant benefits (like efficiency and avoiding unnecessary computations), it can sometimes lead to behaviors that might seem non-intuitive, especially regarding order.

*   **A Note on "Random" Order:** While lazy evaluation is a core feature, the apparent randomness in output, especially when dealing with *attribute sets* (like the final output of many Nix expressions), often stems from the fact that **attribute sets in Nix are fundamentally unordered collections of key-value pairs**. When Nix tools (like `nix-repl` or `nix-instantiate`) display an attribute set, the order in which keys are printed isn't guaranteed and might depend on internal hashing or representation details. This is distinct from *list* element order, which *is* preserved. Lazy evaluation affects *when* things are computed, not necessarily the inherent order of ordered data structures like lists once they *are* computed. For lists, `[1 2 3]` will always represent that sequence.

---

## 1. Basic Function Definition

A Nix function takes one argument and returns a value.

```nix
# Single Parameter Function
# Defines a function 'double' that takes one argument 'x' and returns 'x * 2'.

# Syntax: argName: bodyExpression
double = x: x * 2;

# Calling the function:
# result = double 10; # result will be 20
```

### Currying (Multiple Parameters)

Nix handles functions with multiple parameters through a concept called **currying**. Instead of a function taking multiple arguments at once, a function takes the *first* argument and returns *a new function* that takes the *second* argument, and so on, until all arguments are provided and the final result is computed.

Here is an example that demonstrates currying in javascript
```javascript
function curry(f) {
    return function(a){
        return function(b){
            return f(a+b);
        }
    }
}
```


```nix
# "Double" Parameter Function (Curried)
# Defines 'add' which takes 'x', returns a NEW function that takes 'y',
# which then returns 'x + y'.
# Syntax: arg1: arg2: ... : bodyExpression
add = x: y: x + y;

# Calling the function:
# Step 1: Apply the first argument
# add10 = add 10;
# At this point, 'add10' is a function equivalent to: y: 10 + y

# Step 2: Apply the second argument to the returned function
# result = add10 20; # result will be 30

# Direct call (syntactic sugar for the above):
# result_direct = add 10 20; # result_direct will also be 30
```

---

## 2. Attribute Set Parameters (Destructuring)

Passing multiple related values (like configuration options) is often done using an **attribute set** (attrset). Nix functions can directly "destructure" an input attrset, binding its keys to local variables. This is extremely common in NixOS modules and Flakes.

```nix
# Function accepting an attribute set
# This function expects an attrset with keys 'a' and 'b'.
# It binds the values of these keys to local variables 'a' and 'b'.
# Syntax: { arg1, arg2, ... }: bodyExpression
setAttr = { a, b }: a + b;

# Calling the function:
# result = setAttr { a = 1; b = 2; }; # result will be 3
```

### Required Arguments

If you list arguments within the curly braces `{}` without providing defaults (see next section) and without using `...` (see ellipsis section), they become **required**. Calling the function without providing these required attributes will result in an evaluation error.

```nix
# Function requiring specific arguments
someFunction = { a, b, c }: a + b;

# Calling example:
# This call will FAIL because 'c' is required but not provided.
# testCall = someFunction { a = 10; b = 20; };
# Error message would be similar to: "function 'someFunction' called without required argument 'c'"
```

### Default Parameter Values

You can provide default values for arguments within an attrset using the `?` syntax. If the caller provides a value for that key, it's used; otherwise, the default is used.

```nix
# Function with default values
# If 'a' or 'b' are not provided in the input attrset,
# they default to 0.
# Syntax: { arg ? defaultValue, ... }: bodyExpression
SumWithDefaults = { a ? 0, b ? 0 }: a + b;

# Calling examples:
# result1 = SumWithDefaults { a = 6; };       # b defaults to 0, result is 6
# result2 = SumWithDefaults { b = 5; };       # a defaults to 0, result is 5
# result3 = SumWithDefaults { a = 2; b = 3; }; # Both provided, result is 5
# result4 = SumWithDefaults { };              # Both default, result is 0
```

### Ellipsis (`...`) - Handling Extra/Variadic Arguments

The ellipsis (`...`) serves two main purposes when used with attrset parameters:

1.  **Ignoring Extra Arguments:** It allows the caller to pass *more* attributes than explicitly listed in the function definition without causing an error. These extra arguments are simply ignored unless captured by the `@`-pattern (see below).

    ```nix
    # Function ignoring extra arguments
    # Expects 'a' and 'b', but allows any other attributes to be passed.
    # 'c' and 'd' in the example call are ignored.
    # Syntax: { arg1, arg2, ... }: bodyExpression
    IgnoreExtras = { a, b, ... }: a + b;

    # Calling example:
    # result = IgnoreExtras { a = 10; b = 20; c = 30; d = 40; }; # result is 30
    # This is very common in module systems where functions might receive
    # a large configuration set but only care about a few specific options.
    ```

2.  **Used with the `@`-Pattern (Capture the Whole Set):** The `@`-pattern allows you to capture the *entire* input attribute set into a single variable, *while also* destructuring specific arguments.

    ```nix
    # Function using the @-pattern
    # 'args' binds the entire input set: { a = "a", b = "b", c = "c", d = "d" }
    # 'a', 'b', 'c' are also destructured for direct access.
    # The function body can access specific args (a, b, c) AND
    # access args via the captured set (args.d).
    # Syntax: varName@{ arg1, arg2, ..., ellipsisMaybe }: bodyExpression
    someFn = args@{ a, b, c, ... }: a + b + c + args.d; # Note: String concatenation here

    # Calling example:
    # result = someFn { a = "a"; b = "b"; c = "c"; d = "d"; }; # result is "abcd"

    # Combining @-pattern, defaults, and ellipsis:
    useDefault = { a ? "default", ... }@args: a + args.b; # String concatenation

    # Calling example:
    # result1 = useDefault { b = "bar"; };        # a defaults to "default", result is "defaultbar"
    # result2 = useDefault { a = "foo"; b = "bar"; }; # a is "foo", result is "foobar"
    ```
    The `@`-pattern is incredibly useful when you need a few specific, possibly defaulted, arguments but also need access to the rest of the passed-in configuration flexibly.

---

## 3. Higher-Order Functions

Functions that take other functions as arguments, or return functions as results, are called Higher-Order Functions (HOFs). This is a natural consequence of functions being first-class citizens.

```nix
# Higher-Order Function Example
# 'HigherOrderfn' takes a function 'f' and a value 'x', and applies 'f' to 'x'.
HigherOrderfn = f: x: f x;

# Using it:
# We pass the 'double' function defined earlier.
# result = HigherOrderfn double 5;
# This evaluates as: double 5 => 5 * 2 => 10
```

Nix's standard library (`pkgs.lib`) is full of HOFs like `map`, `filter`, `foldl'`, `mapAttrs`, etc., which operate on lists and attribute sets.

---

## 4. Function Composition

Combining functions such that the output of one becomes the input of the next is known as function composition.

```nix
# Function Composition Example
# 'composefn' takes two functions, 'f' and 'g', and a value 'x'.
# It first applies 'g' to 'x', then applies 'f' to the result of g(x).
# Result is f(g(x)).
composefn = f: g: x: f (g x);

# Using it:
# We want to first add 1, then double the result.
# g = (x: x + 1)  -- Function to add 1
# f = double       -- Function to double
# x = 5
# result = composefn double (x: x + 1) 5;
# Evaluation:
# 1. g(x) => (x: x + 1) 5 => 5 + 1 => 6
# 2. f(g(x)) => double 6 => 6 * 2 => 12
```

---

## 5. Recursion

Functions can call themselves, which is known as recursion. This is essential for operations that involve repetition or breaking down a problem into smaller, self-similar subproblems. A recursive function needs a **base case** (a condition to stop recursion) and a **recursive step** (calling itself with modified arguments).

```nix
# Recursive Factorial Function
# Calculates n! (n * (n-1) * ... * 1)
# Base case: If n is 0, return 1.
# Recursive step: Otherwise, return n * factorial(n-1).
factorial = n: if n == 0 then 1 else n * factorial (n - 1);

# Using it:
# result = factorial 5;
# Evaluation:
# factorial 5 => 5 * factorial 4
#            => 5 * (4 * factorial 3)
#            => 5 * (4 * (3 * factorial 2))
#            => 5 * (4 * (3 * (2 * factorial 1)))
#            => 5 * (4 * (3 * (2 * (1 * factorial 0))))
#            => 5 * (4 * (3 * (2 * (1 * 1))))  -- Base case hit
#            => 5 * (4 * (3 * (2 * 1)))
#            => 5 * (4 * (3 * 2))
#            => 5 * (4 * 6)
#            => 5 * 24
#            => 120
```

*   **Note on `rec`:** For more complex scenarios, especially involving mutually recursive definitions within attribute sets, Nix provides the `rec` keyword (e.g., `rec { x = y; y = x; }`). While simple recursive functions like `factorial` don't strictly need it, it's crucial for defining sets where attributes refer to each other. This might be what the `ch04Extended_2.nix` file delves into.

---

## 6. Debugging with `builtins.trace`

Nix is purely functional and lazily evaluated, which can sometimes make debugging tricky. `builtins.trace` is a helpful (but impure) function for inspecting values during evaluation. It prints its first argument (which should be a string) to stderr and then returns its second argument.

```nix
# Debugging Example using trace with map (a HOF)
# 'debugMap' applies function 'f' to each element 'x' in list 'xs'.
# Before applying 'f', it traces a message showing the element being processed.
# Note: 'toString' is needed because trace expects a string for the message.
debugMap = f: xs: map (x: builtins.trace "processing ${toString x}" (f x)) xs;

# Using it:
# Applies 'double' to each element of the list [1 2 3 4], tracing each step.
# result = debugMap double [ 1 2 3 4 ];

# Expected output to stderr during evaluation (order might vary due to laziness!):
# trace: processing 1
# trace: processing 2
# trace: processing 3
# trace: processing 4

# The final value of 'result' will be: [ 2 4 6 8 ]
```

**Important:** `trace` only executes if the value it returns is actually needed somewhere in the computation. Due to laziness, if part of your code isn't evaluated, the `trace` calls within it won't fire. Use it strategically to understand evaluation flow and intermediate values.

---

## 7. Practical Example: Configuration Function

This example combines several concepts (attrset parameters, defaults, ellipsis) to create a function that generates a user profile attribute set.

```nix
# Function to create a user configuration attribute set
mkUser =
  { # Destructure input attribute set
    name ? "kenzo", # Default value for 'name'
    age ? 21,       # Default value for 'age'
    ...             # Ignore any other parameters passed in
  }:
  # Return a new attribute set representing the user profile
  {
    username = name; # Use the (potentially defaulted) name
    useage = age;    # Use the (potentially defaulted) age
    EligibleToVote = age >= 18; # Compute a derived property
  };

# Using it:

# Example 1: Use all defaults
# user1 = mkUser { };
# user1 value: { username = "kenzo"; useage = 21; EligibleToVote = true; }

# Example 2: Override name, provide extra ignored arg
# user2 = mkUser { name = "alice"; extra = "ignored"; };
# user2 value: { username = "alice"; useage = 21; EligibleToVote = true; }

# Example 3: Override age
# user3 = mkUser { age = 17; };
# user3 value: { username = "kenzo"; useage = 17; EligibleToVote = false; }
```

This pattern is extremely common for creating configurable components in Nix.

---

## NOTE:
s
*   **Core Syntax:** `arg: body` for single args, `arg1: arg2: body` for multiple (curried).
*   **Attrset Parameters:** `{ arg1, arg2 }: body` for destructuring. Use `?` for defaults (`arg ? val`).
*   **Ellipsis (`...`):** Ignores extra arguments in attrset parameters.
*   **@-Pattern:** `var@{ arg1, ... }: body` captures the whole input attrset into `var` while also destructuring.
*   **First-Class & HOFs:** Functions can be passed around like any value, enabling powerful patterns like `map`, `filter`, and composition.
*   **Recursion:** Essential for iterative processes, requires a base case and recursive step. `rec` is used for mutually recursive definitions in sets.
*   **Laziness:** Evaluation happens only when needed. Use `builtins.trace` for debugging value flow.
