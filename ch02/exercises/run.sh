#!/run/current-system/sw/bin/bash

set -e

echo "                        testing!!!!!!"
echo "      If an assertion fails, nix eval will exit with an error."
echo ""

echo -n "Running ex001..."
nix eval --file ./ex001.nix 
echo " OK (Assertions Passed)"

echo -n "Running ex002..."
nix eval --file ./ex002.nix 
echo " OK (Assertions Passed)"

echo -n "Running ex003..."
nix eval --file ./ex003.nix 
echo " OK (Assertions Passed)"

echo -n "Running ex004..."
nix eval --file ./ex004.nix 
echo " OK (Assertions Passed)"

echo ""
echo "Chapter 02 Exercises Passed!"

exit 0
