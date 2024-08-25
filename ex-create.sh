#!/bin/bash

# Source the database configuration file
source $(dirname "$0")/db-config.sh

#!/bin/bash

# Source the configuration file
source $(dirname "$0")/db-config.sh

echo "Create new exercise record:"
read -p "Date (YYYY-MM-DD): " date
read -p "Duration (HH:MM:SS): " duration
echo "Exercise Types:"
echo "6 - Gardening"
echo "3 - Jogging"
echo "4 - Running"
echo "1 - Walking"
echo "2 - Walking/Jogging"
echo "5 - Weight Lifting"
read -p "Exercise Type ID: " exercise_type_id
read -p "Distance (miles): " distance

query="INSERT INTO Exercises (Date, Duration, ExerciseTypeId, Distance) VALUES ('$date', '$duration', $exercise_type_id, $distance);"
execute_query "$query"
echo -e "${GREEN}Record created successfully.${NC}"