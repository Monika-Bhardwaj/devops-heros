#!/bin/bash

# System Information Script
# This script collects and displays system information

# Print current date
echo "=========================================="
echo "        SYSTEM INFORMATION REPORT"
echo "=========================================="
echo ""

echo "Current Date and Time: $(date)"
echo ""

echo "Hostname: $(hostname)"
echo ""

echo "Current User: $(whoami)"
echo ""

# Using variables to store data
CURRENT_DATE=$(date)
HOST_NAME=$(hostname)
USER_NAME=$(whoami)
DISK_USAGE=$(df -h)
RUNNING_PROCESSES=$(ps aux)

echo "--- Variables Stored ---"
echo "Date: $CURRENT_DATE"
echo "Host: $HOST_NAME"
echo "User: $USER_NAME"
echo ""

echo "Disk Usage:"
echo "$DISK_USAGE"
echo ""

echo "Running Processes (first 10 lines):"
echo "$RUNNING_PROCESSES" | head -10
echo ""

echo "=========================================="
read -p "Enter a directory name to create: " DIR_NAME
read -p "Enter a filename to create (with extension): " FILE_NAME
echo ""

mkdir -p "$DIR_NAME"
echo "Directory '$DIR_NAME' created successfully!"

touch "$DIR_NAME/$FILE_NAME"
echo "File '$FILE_NAME' created inside '$DIR_NAME'"

echo "$RUNNING_PROCESSES" > "$DIR_NAME/$FILE_NAME"
echo "Running processes information saved to '$DIR_NAME/$FILE_NAME'"

echo ""
echo "=========================================="
echo "Script execution completed!"
echo "Check '$DIR_NAME/$FILE_NAME' for process data"
echo "=========================================="