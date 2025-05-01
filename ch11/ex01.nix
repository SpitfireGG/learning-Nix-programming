# making a simple and basic derivation ( recipie )

{
  pkgs ? import <nixpkgs> { },
}:
pkgs.stdenv.mkDerivation {

  name = "fizz_buzz_1.0.0";

  # unpacking requires some source, something like .gz ( compressed files ) to unpack, we are going to create one  on the fly
  unpackPhase = ''
    cat > fizzbuzz.c << 'EOF'
    # include <stdio.h>
    int main(void) {
        for (int i = 0; i< 100; i++) {
            if( i % 3 == 0) printf("%s\n", "fizz");
            else if( i % 5 == 0) printf("%s\n", "buzz");
            else printf("%s\n", "bar");
        };
        printf("\n\n");
    return 0;
    }
    EOF
  '';

  # using the buildPhase to build the program
  buildPhase = ''




  '';

}
