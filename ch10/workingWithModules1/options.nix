# # 1.
# the simples one is the following one  that takes ay attributes and returns any attribute
# defining any value would have the module system to first know what values it ca take  , and can be done by declaring options to specify which attributes can be set and used elsewhere

{ lib, ... }: {
  options = {
    name = lib.mkOption { type = lib.types.string; };
    discription = lib.mkOption { description = lib.types.str; };
    createEnable = lib.mkEnableOption { type = lib.types.bool; };
  };
}

###1. declaring options: peek into workingWithModules/ dir for more info ( you will learn how to import modules, set them and work with them)
