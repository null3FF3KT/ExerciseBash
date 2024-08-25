#!/bin/bash

# Source the database configuration file
source $(dirname "$0")/db-config.sh

#!/bin/bash

# Source the configuration file
source $(dirname "$0")/config.sh

#!/bin/bash

# Source the configuration file
source $(dirname "$0")/config.sh

# Function to display menu
display_menu() {
    echo -e "${MAGENTA}Mileage Database CRUD CLI${NC}"
    echo -e "${MAGENTA}-------------------------${NC}"
    echo -e "${CYAN}1. Create new exercise record${NC}"
    echo -e "${WHITE}2. Read exercise records${NC}"
    echo -e "${CYAN}3. Update exercise record${NC}"
    echo -e "${WHITE}4. Delete exercise record${NC}"
    echo -e "${CYAN}5. View exercise statistics${NC}"
    echo -e "${WHITE}6. View fastest times${NC}"
    echo -e "${CYAN}7. Exit${NC}"
    echo -n "Enter your choice: "
}

# Main loop
while true; do
    display_menu
    read choice
    case $choice in
        1) /${BASE_PATH}ex-create.sh ;;
        2) /${BASE_PATH}ex-read.sh ;;
        3) /${BASE_PATH}ex-update.sh ;;
        4) /${BASE_PATH}ex-delete.sh ;;
        5) /${BASE_PATH}ex-stats.sh ;;
        6) /${BASE_PATH}ex-fastest.sh ;;
        7) echo -e "${GREEN}Goodbye!${NC}" ; exit 0 ;;
        *) echo -e "${RED}Invalid option. Please try again.${NC}" ;;
    esac
    echo
    read -p "Press Enter to continue..."
    clear
done