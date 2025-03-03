#!/bin/bash
set -e
set -x

REQUIRED_ENV_VARS=(
    "OINGO"
    "BOINGO"
    "FLIMBO"
    "FLOMBO"
)

if [[ -f .env ]]; then
    echo "Loading environment variables from .env file..."
    export $(grep -v '^#' .env | xargs)
else
    echo "Image not provided with an .env file! Exiting..."
    exit 1
fi

MISSING_VARS=()
for VAR in "${REQUIRED_ENV_VARS[@]}"
do
    if [[ -z "${!VAR}" ]]; then
        MISSING_VARS+=("$VAR")
    fi
done

if [[ ${#MISSING_VARS[@]} -ne 0 ]]; then
    echo "ERROR: The following required environment variables are missing or empty:"
    for VAR in "${MISSING_VARS[@]}"
    do
        echo "  - $VAR"
    done
    exit 1
fi

EXTRA_VARS=()
while IFS='=' read -r VAR _; do
    if [[ ! " ${REQUIRED_ENV_VARS[@]} " =~ " ${VAR} " ]]; then
        EXTRA_VARS+=("$VAR")
    fi
done < <(grep -v '^#' .env)

if [[ ${#EXTRA_VARS[@]} -ne 0 ]]; then
    echo "WARNING: The following environment variables are present in .env but are not required:"
    for VAR in "${EXTRA_VARS[@]}"
    do
        echo "  - $VAR"
    done
fi

echo "All required environment variables are set."
echo 'Hello World'
echo "Current user: $(whoami)"

# Debugging: Print received arguments
echo "Received args: $@"