{ lib, config, options, ... }:

let cfg = config;

in with lib  ; {  # using the with for using the helper functions like mkMerge
  config = mkMerge [
    (mkIf cfg.enable { 
      name = "working with file module";
      createEnable = true;
    })
    {
      warnings = if config.enable == config.createEnable then
        [ "both vals msut evaluate to true" ]
      else
        [ ];
    }
  ];

}
