#!/bin/bash

#Assigning variable of each different city to value curl API.
GJOEVIK=$(curl -s "https://api.met.no/weatherapi/locationforecast/2.0/classic?lat=60.474466&lon=10.412958")
OSLO=$(curl -s "https://api.met.no/weatherapi/locationforecast/2.0/classic?lat=59.544583&lon=10.444592")
BERGEN=$(curl -s "https://api.met.no/weatherapi/locationforecast/2.0/classic?lat=60.233476&lon=5.192694")
TRONDHEIM=$(curl -s "https://api.met.no/weatherapi/locationforecast/2.0/classic?lat=63.254976&lon=10.234222")
TROMSOE=$(curl -s "https://api.met.no/weatherapi/locationforecast/2.0/classic?lat=69.385604&lon=18.571829")
KRISTIANSAND=$(curl -s "https://api.met.no/weatherapi/locationforecast/2.0/classic?lat=58.084816&lon=7.594416")
DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M:%S")
CURRENT_HOUR=$(date +"%dT%H:00")
CURRENT_HOUR_PLUS_TWO=$(date +"%dT%H:00" -d '1 hour')
CURRENT_HOUR_PLUS_THREE=$(date +"%dT%H:00" -d '2 hours')
#Creates a new directory for the files with meteorological data.
mkdir scraped-weather
mkdir cities

#Creates a new directory labeled with date and time the script is run, and then moves the generated directory into scraped-weather directory.
DIR_DATE=$(date +"%Y-%m-%d-%H:%M")
mkdir $DIR_DATE
mv $DIR_DATE scraped-weather

#For loop that scrapes meteorological data from mutliple cities.
#Contains if statements that redirects these datas and the date+time of the session script is run into the file of the specified city.
for LOCATION in "$GJOEVIK" "$OSLO" "$BERGEN" "$TRONDHEIM" "$TROMSOE" "$KRISTIANSAND"
do
	#Variable assignment of the temparature, precipication and humidity. Value of each category is found by using grep.
       	#TEMPERATURE=$(echo "$LOCATION" | grep -E "temperature" | grep -o -E "(-[0-9][0-9].[0-9]|-[0-9].[0-9]|[0-9].[0-9]|[0-9][0-9].[0-9])" | head  -n3)
	FIRST_TEMPERATURE=$(echo "$LOCATION" | grep "$CURRENT_HOUR" -A 3 | grep -E "temperature" | grep -o -E "(-?[0-9]{1,2}\.[0-9])" )
	SECOND_TEMPERATURE=$(echo "$LOCATION" | grep "$CURRENT_HOUR_PLUS_TWO" -A 3 | grep -E "temperature" | grep -o -E "(-?[0-9]{1,2}\.[0-9])" )
	THIRD_TEMPERATURE=$(echo "$LOCATION" | grep "$CURRENT_HOUR_PLUS_THREE" -A 3 | grep -E "temperature" | grep -o -E "(-?[0-9]{1,2}\.[0-9])" )
	PRECIPITATION=$(echo "$LOCATION" | grep -E "symbol" | grep -E -o 'code=".*"' | head -n3 | tail -n1 | grep -E -o '".*"' | sed -E 's/^.//g; s/.$//g')

	#OPTIONAL 1STAR: Retrieve humidity for each city, add as a seventh line.
	HUMIDITY=$(echo "$LOCATION" | grep -E "humidity" | grep -o "[0-9][0-9]\.[0-9]\|[0-9]\.[0-9]\|[0-9][0-9]\.[0-9]" | head -n1)

	if [[ $LOCATION == $GJOEVIK ]]; then
		echo Gjøvik > Gjøvik.txt
                echo "$FIRST_TEMPERATURE" >> Gjøvik.txt
		echo "$SECOND_TEMPERATURE" >> Gjøvik.txt
		echo "$THIRD_TEMPERATURE" >> Gjøvik.txt
                echo "$PRECIPITATION" >> Gjøvik.txt
                echo $DATE $TIME >> Gjøvik.txt
                echo "$HUMIDITY" >> Gjøvik.txt
        fi

	if [[ $LOCATION == $OSLO ]]; then
                echo Oslo > Oslo.txt
		echo "$FIRST_TEMPERATURE" >> Oslo.txt
                echo "$SECOND_TEMPERATURE" >> Oslo.txt
                echo "$THIRD_TEMPERATURE" >> Oslo.txt
                echo "$PRECIPITATION" >> Oslo.txt
                echo $DATE $TIME >> Oslo.txt
                echo "$HUMIDITY" >> Oslo.txt
        fi

	if [[ $LOCATION == $BERGEN ]]; then
                echo Bergen > Bergen.txt
		echo "$FIRST_TEMPERATURE" >> Bergen.txt
                echo "$SECOND_TEMPERATURE" >> Bergen.txt
                echo "$THIRD_TEMPERATURE" >> Bergen.txt
                echo "$PRECIPITATION" >> Bergen.txt
                echo $DATE $TIME >> Bergen.txt
                echo "$HUMIDITY" >> Bergen.txt
        fi

	if [[ $LOCATION == $TRONDHEIM ]]; then
                echo Trondheim > Trondheim.txt
		echo "$FIRST_TEMPERATURE" >> Trondheim.txt
                echo "$SECOND_TEMPERATURE" >> Trondheim.txt
                echo "$THIRD_TEMPERATURE" >> Trondheim.txt
                echo "$PRECIPITATION" >> Trondheim.txt
                echo $DATE $TIME >> Trondheim.txt
                echo "$HUMIDITY" >> Trondheim.txt
        fi

	if [[ $LOCATION == $TROMSOE ]]; then
                echo Tromsø > Tromsø.txt
		echo "$FIRST_TEMPERATURE" >> Tromsø.txt
                echo "$SECOND_TEMPERATURE" >> Tromsø.txt
                echo "$THIRD_TEMPERATURE" >> Tromsø.txt
                echo "$PRECIPITATION" >> Tromsø.txt
                echo $DATE $TIME >> Tromsø.txt
                echo "$HUMIDITY" >> Tromsø.txt
        fi

	#OPTIONAL 1 STAR: On even days, also scrape meteorological data for Kristiansand.
	if [[ $(($(date +%d) % 2)) == 0 ]]; then
		if [[ $LOCATION == $KRISTIANSAND ]]; then
                echo Kristiansand > Kristiansand.txt
		echo "$FIRST_TEMPERATURE" >> Kristiansand.txt
                echo "$SECOND_TEMPERATURE" >> Kristiansand.txt
                echo "$THIRD_TEMPERATURE" >> Kristiansand.txt
                echo "$PRECIPITATION" >> Kristiansand.txt
                echo $DATE $TIME >> Kristiansand.txt
                echo "$HUMIDITY" >> Kristiansand.txt
        	fi
	fi

done

#Moves each city file to directory with script session is run.
mv *.txt $HOME/prosjekt/scraped-weather/$DIR_DATE
