{ lib, ... }:
with (lib);
{

  options = {
    _1st = mkOption {
      type = types.int;
      default = 1;
      description = "first value";
    };
    _2nd = mkOption {
      type = types.int;
      default = 2;
      description = "second value";
    };
    _3rd = mkOption {
      type = types.int;
      default = lib.mkOverride 0 3;
      description = "third value";
    };
    sum = mkOption {
      type = types.int;
      description = "second value";
    };
  };
}
