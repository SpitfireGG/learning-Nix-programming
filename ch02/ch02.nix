#sets

# NOTE: comment one of the following codes and run for yourself to find the output and tinker the code to see what happens

  let
    person = {
      name = "scoop";
      age = 10;
      address = "kathmandu, Nepal";
    };
  in
  person.address


# run with nix eval --file ch02.nix

# this syntax can be seen in the nix store as well as when you are configuring configration.nix or other nix files


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


# Recursive sets

rec {
  x = 1;
  y = x + 1;
  z = y + 1;
}
