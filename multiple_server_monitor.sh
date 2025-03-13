#!/bin/bash

# Define servers to monitor (replace with your server IPs or hostnames)
SERVERS="server1 server2 server3"
# SSH username
USERNAME="your_username"
# Output file
OUTPUT_FILE="server_stats_$(date +%Y%m%d_%H%M%S).txt"

# Header for output file
echo "Server Statistics Report - $(date)" > "$OUTPUT_FILE"
echo "===================================" >> "$OUTPUT_FILE"

# Function to collect stats from a server
collect_stats() {
    local server=$1
    
    echo "Collecting stats from $server..."
    echo "Server: $server" >> "$OUTPUT_FILE"
    echo "----------------" >> "$OUTPUT_FILE"
    
    # SSH into server and collect stats
    ssh "$USERNAME@$server" bash << 'EOF'
        # CPU Usage (percentage)
        echo "CPU Usage:" >> "$OUTPUT_FILE"
        top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4 "%"}' >> "$OUTPUT_FILE"
        
        # Memory Usage
        echo "Memory Usage:" >> "$OUTPUT_FILE"
        free -h | grep "Mem:" >> "$OUTPUT_FILE"
        
        # Disk Usage
        echo "Disk Usage:" >> "$OUTPUT_FILE"
        df -h | grep -E "^/dev/" >> "$OUTPUT_FILE"
        
        echo "" >> "$OUTPUT_FILE"
EOF
}

# Loop through each server
for server in $SERVERS; do
    collect_stats "$server"
done

echo "Stats collection complete. Results saved in $OUTPUT_FILE"