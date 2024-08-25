#!/bin/bash

# Source the database configuration file
source $(dirname "$0")/db-config.sh

#!/bin/bash

# Source the configuration file
source $(dirname "$0")/db-config.sh

echo -e "${YELLOW}Delete exercise record:${NC}"

# Search for records
${BASE_PATH}ex-read.sh

read -p "Enter the ID of the record to delete: " id
if ! [[ "$id" =~ ^[0-9]+$ ]]; then
    echo -e "${RED}Invalid input. Please enter a valid number.${NC}"
    exit 1
fi

query="DELETE FROM Exercises WHERE Id = $id;"
execute_query "$query"
echo -e "${GREEN}Record deleted successfully.${NC}"