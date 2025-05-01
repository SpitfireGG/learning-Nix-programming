A **derivation**  is a .drv file that contains all the recipie to build a package and actually building the package is known as **realizing**. You often hear the term **realising a derivation** , it actaully means building something according to the blueprint in the .drv file.

When we realize a derivation, Nix:

1. Creates a temporary, isolated build environment
2. Runs the build commands specified in the derivation
3. Captures the output and stores it in the Nix store
