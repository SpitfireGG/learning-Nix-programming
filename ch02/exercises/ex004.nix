# Exercise 003: Fix Recursive Set Definition
# Goal: Make a set recursive (`rec`) so its attributes can refer to each other.

let
  # TODO:
  #This set definition is broken because 'fullName' tries to use 'firstName'
  #       and 'lastName' from the same set, but it's not declared as recursive.
  #       Fix the definition by adding the 'rec' keyword in the correct place.

  userDetails = {
    firstName = "Ada";
    lastName = "Lovelace";

    # This line will cause an error "undefined variable 'firstName'" without 'rec'.
    fullName = firstName + " " + lastName;
  };

in

# fix the issue so that the following expression evaluates to true
assert userDetails.fullName == "Ada Lovelace";

# Result if assertion passes
true
