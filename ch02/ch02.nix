## sets
#############################

# There is so much more to learn about sets and we'll cover them in later chapters when we  discuss avout `builtins and  lib`                     comment out one of the sections and run the desired section, then run the other one by commenting the current one and vice versa.

## section 1
/*
  let
    # the attribute name 'name' in this case doesnot have to be inside the quotes but the value needs to be, Also when assigned an attribute with a value it must end with ';'
    package = {
      name = "git";
      version = "1.12.1";
      release = 2002;
      sha256 = "35vj35j5vb5jvb4j54545b42jh5b"; # this is typed randomly btw
    };
    # also the end of the list must also have ';' in the end
    description = ''
      testing!!!! this is not true btw
      the package ${package.name} was introduced in the late ${toString package.release}
    '';
  in
  # the values can be captured using the dot notation
  description
*/

# run with nix eval --file ch02.nix

## section 2
# Recursive sets

/*
  rec {
    x = 1;
    y = x + 1;
    z = y + 1;
  }
*/

## section 3
let
  services = {
    name = "random service";
    port = 8080;
    description = "secure shell for securely connecting to remote servers";
    # this is a nested set attribute

    settings = rec {
      # using the rec keyword lets us use the attributes from within the same attribute, more about it on later chapters
      enable = true;
      enable_by_default = false;
      params = "--help";

      description =
        let
          e = enable;
          serviceName = services.name;
          serviceport = services.port;
        in
        "the url of the service is ${
          if e then "https://${serviceName}:${toString serviceport}" else "service is not running"
        }";

    };
  };
in
services.settings.description
