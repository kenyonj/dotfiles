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

function print_time {
  printf "$1\t\t$(TZ="$2" date '+%H:%M\t%A\t\t%d %B, %Y')"
  printf "\n"
}

print_time "🏙 Amsterdam" "Europe/Amsterdam"
print_time "🌆 Eastern" "America/New_York"
print_time "🍕 Central" "America/Chicago"
print_time "🏄 Western" "America/Los_Angeles"
print_time "🌄 Scotland" "Europe/London"
print_time "🌏 Singapore" "Asia/Singapore"
