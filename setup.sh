#!/bin/bash

# Create config.sh
cat > config.sh << EOL
#!/bin/bash

# Set the base path here
export BASE_PATH='$(pwd)/'
EOL

# Make config.sh executable
chmod +x config.sh

# Modify each script to source db-config.sh
for script in *.sh; do
    if [ "$script" != "config.sh" ] && [ "$script" != "setup.sh" ] && [ "$script" != "db-config.sh" ]; then
        sed -i '1s|^|#!/bin/bash\n\n# Source the database configuration file\nsource $(dirname "$0")/db-config.sh\n\n|' "$script"
    fi
done

# Special modification for db-config.sh
cat > db-config.sh << EOL
#!/bin/bash

# Source the configuration file if BASE_PATH is not set
if [ -z "\$BASE_PATH" ]; then
    source \$(dirname "\$0")/config.sh
fi

# Ensure BASE_PATH ends with a slash
[[ "\${BASE_PATH}" != */ ]] && BASE_PATH="\${BASE_PATH}/"

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
    mysql --defaults-extra-file="\${BASE_PATH}mysql.cnf" -s -N -e "\$1"
}

# Export the function so it's available to other scripts
export -f execute_query
EOL

# Make all scripts executable
chmod +x *.sh

# Create desktop entry
cat > ~/Desktop/exercise-tracker.desktop << EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=Exercise Tracker
Comment=Track your exercise progress
Exec=$(pwd)/exercise.sh
Icon=$(pwd)/exercise-icon.png
Terminal=true
Categories=Utility;
EOL

# Make desktop entry executable
chmod +x ~/Desktop/exercise-tracker.desktop

echo "Setup complete. You should now see an 'Exercise Tracker' icon on your desktop."