#!/bin/bash

CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
CPU_INFO=$(ps -eo pcpu,command | grep -v "CPU" | grep -v "ps" | grep -v "grep" | grep -v "logger" | awk '{sum+=$1} END {print sum}')
CPU_USAGE=$(echo "scale=2; $CPU_INFO/$CORE_COUNT" | bc)

sketchybar --set $NAME icon="" label="${CPU_USAGE}%" 