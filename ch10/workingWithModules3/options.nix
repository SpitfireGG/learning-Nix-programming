{ lib, ... }:
with lib; {
  options = {
    enable = mkOption {
      type = types.bool;
      description = "boolean type";
    };
    strType = mkOption {
      type = types.str; # types.string is deprecated
      description = "string type";
    };
    enumType = mkOption {
      type = types.enum [ "small" "medium" "large" ];
      default = "small";
      description = "enumuration type";
    };
    strList = mkOption {
      type = types.listOf types.str;
      default = [ " foo " " bar " " baz " ];
      description = "list of  strings";
    };
    intAttrs = mkOption {
      type = types.attrsOf types.int;
      default = {
        x = 1;
        y = 2;
      };
      description = "int attribute set";
    };
    subMod = mkOption {
      type = types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            default = "some random process";
          };
          priority = mkOption {
            type = types.int;
            description = "set priority from 1 to 10 ( highest is 10)";
            default = 10;
          };
        };
      };
      default = { };
    };
  };
}
