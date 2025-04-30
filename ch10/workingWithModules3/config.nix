{ config, lib, ... }: {

  config = {

    # can be either null or a boolean
    # enable = true;
    enable = null;

    # can either be a string or attrset of string
    # strType = "custom string value";
    strType = {
      a = "fizz";
      b = "buzz";
      c = "bar";
    };

    enumType = "large"; # Must be one of ["small" "medium" "large"]

    strList = [ "new" "values" ];

    intAttrs = {
      x = 5;
      y = 10;
      z = 15; # Can add new attributes
    };
    oneOfDecl = "string";

    subMod = {
      name = "important process";
      priority = 5; # Must be between 1-10
    };
  };

}
