with builtins;

let

  # Base sets for exercises
  person = {
    name = "kenzo";
    age = 25;
    skills = [
      "nix"
      "C"
      "vim"
      "bash"
    ];
    address = {
      city = "california";
      country = "USA";
    };
  };

  # using recursive sets
  services = rec {
    ssh = {
      port = 22;
      config = {
        PermitRootLogin = "no";
      };
    };
    http = {
      port = 80;
      depends = [ ssh ];
    };
  };

  # helper value
  key = "age";
in
{
  # replace the value of `X` so that  the expressions evaluate to true

  ### Level 1: The basic one
  ex1 = person.name == "X";
  ex2 = person.address.city == "X";
  ex3 = person."${key}" == X; # Hint: key="age"

  ### Level 2: Nested & Recursive
  ex4 = services.http.port == X;
  ex5 = services.http.depends [ 0 ].port == X; # First item's port
  ex6 =
    (rec {
      a = 1;
      b = a + 1;
    }).b == X;
}

# run the code using the command: nix eval --file ex001.nix ( the outputs must all evaluate to true)
