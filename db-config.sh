#!/bin/bash

# Source the configuration file if BASE_PATH is not set
if [ -z "$BASE_PATH" ]; then
    source $(dirname "$0")/config.sh
fi

# Ensure BASE_PATH ends with a slash
[[ "${BASE_PATH}" != */ ]] && BASE_PATH="${BASE_PATH}/"

# Color codes
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Function to execute MySQL query
execute_query() {
    mysql --defaults-extra-file="${BASE_PATH}mysql.cnf" -s -N -e "$1"
}

# Export the function so it's available to other scripts
export -f execute_query
