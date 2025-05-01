#!/run/current-system/sw/bin/bash


NIX_FILE="ex001.nix"
# List of attribute names in the Nix file to test
EXERCISES=(
  "exercise1"
  "exercise2"
  "exercise3"
  "exercise4"
  "exercise5"
  "exercise6"
  "exercise7"
)

PASSED_COUNT=0
FAILED_COUNT=0
FAILED_LIST=()

echo "Running Nix Debugging Exercises from ${NIX_FILE}..."
echo "=================================================="

for EX_NAME in "${EXERCISES[@]}"; do
    echo -n "[Test] Running ${EX_NAME}... "

    OUTPUT=$(nix eval --impure --raw --file "${NIX_FILE}" ".#${EX_NAME}" 2> /tmp/nix_error_${EX_NAME}.log)
    EXIT_CODE=$?

    if [[ ${EXIT_CODE} -ne 0 ]]; then
        echo "FAIL (evaluation error)"
        FAILED_COUNT=$((FAILED_COUNT + 1))
        FAILED_LIST+=("${EX_NAME} (Eval Error)")

    elif [[ "${OUTPUT}" == "true" ]]; then
        echo "PASS"
        PASSED_COUNT=$((PASSED_COUNT + 1))
    else
        echo "FAIL (Expected 'true', got '${OUTPUT}')"
        FAILED_COUNT=$((FAILED_COUNT + 1))
        FAILED_LIST+=("${EX_NAME} (Wrong Output)")
    fi

    rm -f "/tmp/nix_error_${EX_NAME}.log"
done

echo "=================================================="
echo "Results: ${PASSED_COUNT} passed, ${FAILED_COUNT} failed."

if [[ ${FAILED_COUNT} -gt 0 ]]; then
    echo "Failed exercises:"
    for failed_ex in "${FAILED_LIST[@]}"; do
        echo "  - ${failed_ex}"
    done
    exit 1
else
    echo "All test passed....."
    exit 0 
fi
