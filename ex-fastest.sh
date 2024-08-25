#!/bin/bash

# Source the database configuration file
source $(dirname "$0")/db-config.sh

#!/bin/bash

# Source the configuration file
source $(dirname "$0")/db-config.sh

# SQL query
SQL_QUERY="WITH RankedExercises AS (
SELECT
e.ExerciseTypeId,
ROUND(e.Distance / 0.05) * 0.05 AS DistanceGroup,
e.Duration,
e.Date,
e.Distance,
ROW_NUMBER() OVER (
PARTITION BY e.ExerciseTypeId, ROUND(e.Distance / 0.05) * 0.05
ORDER BY e.Duration
) AS RowNum
FROM Exercises e
)
SELECT
et.TypeName AS ExerciseType,
re.DistanceGroup,
re.Duration AS FastestTime,
re.Date AS DateAchieved,
re.Distance AS ActualDistance
FROM RankedExercises re
JOIN ExerciseTypes et ON re.ExerciseTypeId = et.Id
WHERE re.RowNum = 1
ORDER BY et.TypeName, re.DistanceGroup, re.Duration;"

# Function to format and print results
format_and_print() {
    echo -e "${MAGENTA}Fastest Times for Each Exercise Type and Distance Group:${NC}"
    echo -e "${MAGENTA}$(printf '%.0s-' {1..60})${NC}"
    printf "${CYAN}%-15s %-10s %-12s %-10s %-10s${NC}\n" "Exercise" "Distance" "Fastest" "Date" "Actual"
    printf "${CYAN}%-15s %-10s %-12s %-10s %-10s${NC}\n" "Type" "Group" "Time" "Achieved" "Distance"
    echo -e "${MAGENTA}$(printf '%.0s-' {1..60})${NC}"
    echo "$1" | awk '{
        printf "'"${GREEN}%-15.15s ${YELLOW}%-10.10s ${GREEN}%-12.12s ${YELLOW}%-10.10s ${GREEN}%-10.10s${NC}\n"'", 
        $1, $2, $3, $4, $5
    }'
}

# Execute the query and store the result
result=$(execute_query "$SQL_QUERY")

# Format and print the result
format_and_print "$result"