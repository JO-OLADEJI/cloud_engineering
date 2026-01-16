#!/opt/homebrew/opt/bash/bin/bash

# df -h (disk usage in human-readable format)
# awk 'NR==10 { print $5 }' (match the 10th line from the stdin and print the 5th field)
# cut -d'%' -f1 (cut the string at the '%' delimiter and print the first field)
DISK_USAGE=$(df -h | awk 'NR==10 { print $5 }' | cut -d'%' -f1)

if [ $DISK_USAGE -ge 80 ]; then
    echo "Warning: Disk usage is at $DISK_USAGE%"
    exit 2
    # trigger a log analysis
else
    echo "All cool, we're at $DISK_USAGE% capacity :)"
    exit 0
fi
