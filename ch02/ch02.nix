#sets

# NOTE: comment one of the following codes and run for yourself to find the output and tinker the code to see what happens

# comment or uncomment one of the section and play around until you feel confident and move onto the next section

# section 1
let
  person = {
    name = "scoop";
    age = 10;
    address = "kathmandu, Nepal";
  };
in
person.address
  # run with nix eval --file ch02.nix

  # section 2
  /*
    let
      services = {
        name = "ssh";
        description = "secure shell for securely connecting to remote servers";
        # this is a nested set attribute
        settings = {
          enable = true;
          params = "<some parameters>";
          auto_enable_ssh_daemon = false;
        };
      };
    in
    services.settings.auto_enable_ssh_daemon
  */

  # section 3
  # Recursive sets
  rec {
    x = 1;
    y = x + 1;
    z = y + 1;
  }

#section 4
