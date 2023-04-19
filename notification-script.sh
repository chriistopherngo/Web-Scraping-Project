#!/bin/bash
#Variable assignments
DIR_DATE=$(date +"%Y-%m-%d-%H:%M")
CITIES=$(cat scraped-weather/$DIR_DATE/*.txt)

#Sends notification to idg1100-chrisng (ntfy app)
curl -H "X-Priority: 5" -H "t: Current weather forecast" -d "$CITIES" ntfy.sh/idg1100-chrisng
