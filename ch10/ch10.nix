## working with Module System Utilities
# =========================================

# definition: module is a nix file cotaining certain nix expression with a specific structure that can be loaded from or to a file to evaluate to make something extensive ( loading chunks of nix files to evaluate to something by parsing all the chunks of options from the file)

### you should not be asking for AI's to explain the something to you before reading the official docs , instead inspect pkgs, libs, builtins etc. from the site :
# https://noogle.dev/f/lib/
### first try to understand the functions u r using by reading it, and it will be very useful

### let;s work with some common library functions:

#1. mkOption // visit https://noogle.dev/f/lib/mkOption for documetations

/*
  The following is the current implementation of this function.

  mkOption =
      {
        default ? null,
        defaultText ? null,
        example ? null,
        description ? null,
        relatedPackages ? null,
        type ? null,
        apply ? null,
        internal ? null,
        visible ? null,
        readOnly ? null,
      }@attrs:
      attrs // { _type = "option"; };
*/

# ex :1 -> If you just want to be able to enable/disable a module you can define an Enable option, define the following:

{ config, lib, ... }: # this is a attribute set function declaration which, takes two params config & lib and ... - the ... (ellipsis) indicates that the function accepts additional, unspecified attributes that is  likely to be accessed by the expressions
with lib;
{
  options.config = {
    enable = mkOption {
      description = "enable config";
      type = types.bool;
      default = false;
    };
  };
}

## 1.
# the simples one is the following one  that takes ay attributes and returns any attribute
# defining any value would have the module system to first know what values it ca take  , and can be done by declaring options to specify which attributes can be set and used elsewhere

###1. declaring options: peek into workingWithModules/ dir for more info ( you will learn how to import modules, set them and work with them)
