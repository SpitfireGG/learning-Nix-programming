#set attribute selection, inheritance and merging

let

  defaultConfig = {
    host = "username";
    extraConfig = true;
    DefaultUser = "kenzo";
  };
  userConfig = {
    enabled = true;
    defaultUser = "kenzo";
    ableToMakeChanges = true;

  };
  mainConfig =
    #  the {} : {} works as a function paramter that in the first braces takes the  paramters , here paramters are provided optional values
    {
      enabled ? false,
      addExtraUsers ? [ "eve" ],
      optionalPort ? 4040,
      Setting,
    }:
    {
      settings = mainConfig {
        enabled = true;
        DefaultUser = [ "kenzo" ];
        Setting = defaultConfig // userConfig; # the // symbol will merge the attribute

      };
    };
in
{
  server = {
    inherit (defaultConfig) host;
    port = 8080;
    isSystemRunning = true;
  };
  setting = mainConfig {
    enabled = true;
    addExtraUsers = "some";
    inherit (mainConfig) Setting; # settig cannot be inherited cuz it is not set attribute tpye
  };

}
