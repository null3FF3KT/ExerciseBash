#!/bin/bash

# Source the database configuration file
source $(dirname "$0")/db-config.sh

#!/bin/bash

# Source the configuration file
source $(dirname "$0")/db-config.sh

# Initialize variables
page=1
records_per_page=10
total_records=$(execute_query "SELECT COUNT(*) FROM Exercises;")

# Function to display records
display_records() {
    local offset=$(( (page - 1) * records_per_page ))
    echo -e "${CYAN}Exercise Records (Page $page):${NC}"
    query="SELECT e.Id, DATE_FORMAT(e.Date, '%Y-%m-%d') as Date, e.Duration, et.TypeName, e.Distance 
           FROM Exercises e 
           JOIN ExerciseTypes et ON e.ExerciseTypeId = et.Id 
           ORDER BY e.Date DESC 
           LIMIT $records_per_page OFFSET $offset;"
    result=$(execute_query "$query")
    
    # Print data rows with alternating colors
    echo "$result" | awk '{
        if (NR % 2 == 0)
            printf "'"${GREEN}%s${NC}\n"'", $0;
        else
            printf "'"${CYAN}%s${NC}\n"'", $0;
    }' | column -t

    # Calculate total pages
    total_pages=$(( (total_records + records_per_page - 1) / records_per_page ))
    echo -e "${YELLOW}Page $page of $total_pages${NC}"
}

# Main loop for paging
while true; do
    display_records

    echo -e "${GREEN}n${NC} - Next page, ${GREEN}p${NC} - Previous page, ${GREEN}q${NC} - Quit"
    read -p "Enter your choice: " choice

    case $choice in
        n|N)
            if (( page * records_per_page < total_records )); then
                ((page++))
            else
                echo -e "${RED}Already at the last page.${NC}"
            fi
            ;;
        p|P)
            if (( page > 1 )); then
                ((page--))
            else
                echo -e "${RED}Already at the first page.${NC}"
            fi
            ;;
        q|Q)
            break
            ;;
        *)
            echo -e "${RED}Invalid option. Please try again.${NC}"
            ;;
    esac
done