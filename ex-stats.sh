#!/bin/bash

# Source the database configuration file
source $(dirname "$0")/db-config.sh

#!/bin/bash

# Source the configuration file
source $(dirname "$0")/db-config.sh

# SQL query
SQL_QUERY="SELECT
DATEDIFF(CURRENT_DATE() , MIN(Date)) + 1 AS DaysSinceBeginning,
SEC_TO_TIME(SUM(TIME_TO_SEC(Duration))) AS TotalDuration,
SEC_TO_TIME(AVG(TIME_TO_SEC(Duration))) AS AverageDuration,
COUNT(*) AS TotalExercises,
COUNT(DISTINCT Date) as NumberOfDays,
SUM(Distance) AS TotalDistance,
AVG(Distance / (TIME_TO_SEC(Duration) / 3600)) AS AverageMph
FROM Exercises;"

# Function to format and print results
format_and_print() {
    echo -e "${MAGENTA}Exercise Statistics:${NC}"
    echo -e "${MAGENTA}$(printf '%.0s-' {1..60})${NC}"
    printf "${CYAN}%-25s${NC}${YELLOW}%s${NC}\n" \
        "Days Since Beginning:" "$(echo "$1" | awk '{print $1}')"
    printf "${CYAN}%-25s${NC}${YELLOW}%s${NC}\n" \
        "Total Duration:" "$(echo "$1" | awk '{print $2}')"
    printf "${CYAN}%-25s${NC}${YELLOW}%s${NC}\n" \
        "Average Duration:" "$(echo "$1" | awk '{print $3}')"
    printf "${CYAN}%-25s${NC}${YELLOW}%s${NC}\n" \
        "Total Exercises:" "$(echo "$1" | awk '{print $4}')"
    printf "${CYAN}%-25s${NC}${YELLOW}%s${NC}\n" \
        "Number of Days:" "$(echo "$1" | awk '{print $5}')"
    printf "${CYAN}%-25s${NC}${YELLOW}%.2f miles${NC}\n" \
        "Total Distance:" "$(echo "$1" | awk '{print $6}')"
    printf "${CYAN}%-25s${NC}${YELLOW}%.2f mph${NC}\n" \
        "Average Speed:" "$(echo "$1" | awk '{print $7}')"
}

# Execute the query and store the result
result=$(execute_query "$SQL_QUERY")

# Format and print the result
format_and_print "$result"