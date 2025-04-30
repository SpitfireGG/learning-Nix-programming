{ lib, ... }:
with lib; {
  options = {
    enable = mkOption {
      type = types.nullOr types.bool;
      description = "either null or a boolean type";
    };
    strType = mkOption {
      type = types.either types.str (types.attrsOf types.str);
      description =
        "either a string or a set of string key values can be passed";
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
    oneOfDecl = mkOption {
      type = types.oneOf [ types.bool types.str types.int ];
      description = "one of the values can be provided ";
    };
    subMod = mkOption {
      type = types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            default = "some random sys process";
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
