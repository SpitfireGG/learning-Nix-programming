{ config, lib, ... }: {

  config = {
    enable = true;

    strType = "custom string value";

    enumType = "large"; # Must be one of ["small" "medium" "large"]

    strList = [ "new" "values" ];

    intAttrs = {
      x = 5;
      y = 10;
      z = 15; # Can add new attributes
    };

    subMod = {
      name = "important process";
      priority = 5; # Must be between 1-10
    };
  };

}
