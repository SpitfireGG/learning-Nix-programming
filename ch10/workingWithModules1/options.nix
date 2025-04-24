{ lib, ... }:
{
  options = {
    name = lib.mkOption { type = lib.types.string; };
    discription = lib.mkOption { description = lib.types.str; };
    createEnable = lib.mkEnableOption { type = lib.types.bool; };
  };
}
