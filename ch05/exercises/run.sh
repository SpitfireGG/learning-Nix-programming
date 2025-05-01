#!/run/current-system/sw/bin/bash

set -e

echo "======================================================================================";
echo "                                    Check assertions                                  ";
echo ""
echo "       the nix files must all result to provided output for all the assertions to pass";
echo "";
echo "======================================================================================";
echo "                  running all the *.nix files in the exercises directory              ";

for i in {1..6}; do
    ex_f=$(printf "ex%03d.nix" "$i");
    if [ -f "${ex_f}" ]; then
        echo "running ${ex_f}......";
        nix eval --impure --file "./${ex_f}"
        echo "${i}. OK (Assertion passed)";
        echo "";
        else
            echo "skipping.... file ${ex_f} not found!";
    fi
done

echo ""
echo "exercises directory -> assertions passed"

stop





