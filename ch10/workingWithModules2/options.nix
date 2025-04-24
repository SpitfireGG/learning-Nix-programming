{ lib, ... }:
{
  options = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "whether to enable or disable";
    };
    name = lib.mkOption {
      type = lib.types.str;
      default = true;
      description = "name of the module";
    };
    createEnable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "enable creation";
    };
  };
}



