#set attribute selection, inheritance and merging

let

  lib = import <nixpkgs/lib>;

  defaultConfig = {
    serverConfig = {
      host = "localhost";
      port = 8080;
      extraConfig = {
        logging = true;
      };
    };
    users = {
      defaultUser = "kenzo";
    };

  };
  userConfig = {
    serverCfg = {
      enabled = true;
      port = 8080;
      extraConfig = {
        defaultUser = "kenzo";
        userCanMakeChanges = true;
        maxConnections = 100;
      };

    };

  };
  mkConfig =
    #the {} : {} works as a function paramter that in the first braces takes the  paramters , here paramters are provided optional values
    {
      enabled ? false,
      addExtraUsers ? [ ],
      port ? 4040,
      base ? defaultConfig,
      overrides ? { },
    }:
    let
      # merging
      # ______________merging works by making a new instance of a set attribute and will contain the values inside of the new instance___________
      ShallowMerge = (builtins.trace) "Merging base and overrides" (base // overrides); # use the normal // overridings when you want to override nested structures completely

      recursiveMerge = (builtins.trace) "recursive merging base and overrides" (
        lib.recursiveUpdate base overrides
      ); # use this one when you want to completely override all the nested structures
    in
    {
      enabled = enabled;
      port = if enabled then port else base.port;
      settings = recursiveMerge;
      users = ShallowMerge.users // {
        addExtraUsers = addExtraUsers;
      };
    };

in
# section 1 -> DOT operator
# attribute selection using the dot notation
/*
  {
    hostServer = defaultConfig.serverConfig.host;
    safeAccess = lib.attrByPath [ "serverConfig" "extraconfig" "maxConnections" ] 0 defaultConfig;
    Port = defaultConfig.serverConfig.port;
  }
*/

# section 2 -> Inheritance
/*
  {
    # suppose we wanted to have the properties of userConfig into the defaultConfig.extraconfig
    defaultConfig.extraconfig = {
      inherit (userConfig.serverCfg) port enabled;

      # nested inheritance
      inherit (userConfig.serverCfg.extraConfig) maxConnections;
    };
  }
*/

# section 3 -> everything combined from the example code
{

  Merge = defaultConfig // userConfig; # this will produce a new instance of set having both of them merged
  RecMerge = lib.recursiveUpdate defaultConfig userConfig; # same as merge but works with nested structures too but ShallowMerge wont
  prodCfg = mkConfig {
    addExtraUsers = [
      "admin"
      "sysadmin"
      "networking guy"

    ];
    port = 8080;
    overrides = userConfig;
  };
  safetyCheck = userConfig.serverCfg.extraConfig.field or "the maximum number is not set";
  # the or keyword is what you are thinking it does, it is kinda if else statement in itself
}

# try creating your own pseudo configuration just like in the examples
