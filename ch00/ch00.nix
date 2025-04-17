# I expect you have known some or at least one of the programming language from before : HANG TIGHT

# Fix : attempting to make this a well documented guide and fixing all the  comments for readability

#Note :
/*
      there are some of the lines that due to the lazy evalutation cannot be ran all at once ( it can be & i have covered it in ch05 - lazy evalutation so the code blocks that you want to run should be uncommented based on the section for eg:

    section1 - section1 { section 1 will be parred with section 1 }

  the fulfilled code for section one will be in the same line below where another section1 is written

      and rest of the code should be commented out )
*/

# a prorgam to print hello world in nix
{
  message = "hello world!";
}

# you can run this through the following command :
# nix eval --file ch00.nix message   { here message is the name of the expression that we are going to evalutate }
