#!/bin/bash

LOG_FMT='[%s] %s: %s'
LOGFILE="/var/log/monitoring.log"
PROCESS_NAME="test"
PID_FILE="./test.pid"
LAST_PID=""

log() {
    local level="$1"
    local msg="$2"
    local time=$(date '+%Y-%m-%d %H:%M:%S')
    printf "$LOG_FMT\n" "$time" "$level" "$msg" >> "$LOGFILE"
}

CURRENT_PID=$(pgrep -x "$PROCESS_NAME")

if [ -z "$CURRENT_PID" ]; then
    exit 0
fi

if [ -f "$PID_FILE" ]; then
    LAST_PID=$(cat "$PID_FILE")
fi

if [ "$CURRENT_PID" != "$LAST_PID" ]; then
    log "INFO" "Process $PROCESS_NAME restarted"
    echo "$CURRENT_PID" > "$PID_FILE"
fi

URL="https://test.com/monitoring/test/api"
RESPONSE=$(curl -s --fail "$URL")
if [ $? -ne 0 ]; then
    log "ERROR" "$URL not responded"
fi