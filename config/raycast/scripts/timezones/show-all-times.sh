#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Show All Configured Timezones
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🏙
# @raycast.packageName timezones

# Documentation:
# @raycast.description Show times in all configured timezones
# @raycast.author Justin Kenyon
# @raycast.authorURL https://github.com/kenyonj

echo "🏙 Amsterdam  $(TZ='Europe/Amsterdam' date '+%H:%M    %A  %d %B, %Y')"
echo "🌆 Eastern    $(TZ='America/New_York' date '+%H:%M    %A  %d %B, %Y')"
echo "🍕 Central    $(TZ='America/Chicago' date '+%H:%M    %A  %d %B, %Y')"
echo "🏄 Western    $(TZ='America/Los_Angeles' date '+%H:%M    %A  %d %B, %Y')"
echo "🌄 Scotland   $(TZ='Europe/London' date '+%H:%M    %A  %d %B, %Y')"
echo "🌏 Singapore  $(TZ='Asia/Singapore' date '+%H:%M    %A  %d %B, %Y')"
