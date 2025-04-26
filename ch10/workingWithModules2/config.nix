{ lib, config, options, ... }:

let cfg = config;

in with lib; { # using with for using the helper functions like mkMerge
  config = mkMerge [
    (mkIf cfg.enable {
      name = "enable/disable config";
      createEnable = true;
      extraOptions =
        [ "this message has been set  in the name of the holy father" ];
    })
    # you can implement warnings to get the errors upon unexpected evalation results
    /* {
         warnings = if config.enable == config.createEnable then
           [ "both vals msut evaluate to true" ]
         else
           [ ];
       }
    */
    # you can use assertion for guaranteed behavoiur of the code by specifying where the code block might fail
    {
      assertions = [{

        assertion = config.enable != config.createEnable;
        message = "either of the configuration is not  enabled";

      }];
    }

  ];

}
