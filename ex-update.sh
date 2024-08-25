#!/bin/bash

# Source the database configuration file
source $(dirname "$0")/db-config.sh

#!/bin/bash

# Source the configuration file
source $(dirname "$0")/db-config.sh

echo -e "${YELLOW}Update exercise record:${NC}"

# Search for records
/${BASE_PATH}ex-read.sh

read -p "Enter the ID of the record to update: " id
if ! [[ "$id" =~ ^[0-9]+$ ]]; then
    echo -e "${RED}Invalid input. Please enter a valid number.${NC}"
    exit 1
fi

read -p "New Date (YYYY-MM-DD) or press Enter to skip: " date
read -p "New Duration (HH:MM:SS) or press Enter to skip: " duration
echo "Exercise Types:"
echo "6 - Gardening"
echo "3 - Jogging"
echo "4 - Running"
echo "1 - Walking"
echo "2 - Walking/Jogging"
echo "5 - Weight Lifting"
read -p "New Exercise Type ID or press Enter to skip: " exercise_type_id
read -p "New Distance (miles) or press Enter to skip: " distance

query="UPDATE Exercises SET "
if [ ! -z "$date" ]; then
    query+="Date = '$date', "
fi
if [ ! -z "$duration" ]; then
    query+="Duration = '$duration', "
fi
if [ ! -z "$exercise_type_id" ]; then
    query+="ExerciseTypeId = $exercise_type_id, "
fi
if [ ! -z "$distance" ]; then
    query+="Distance = $distance, "
fi
query=${query%, }
query+=" WHERE Id = $id;"

execute_query "$query"
echo -e "${GREEN}Record updated successfully.${NC}"