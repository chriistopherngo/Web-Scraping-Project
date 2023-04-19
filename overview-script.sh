#!/bin/bash

#Variable assignments
DIR_DATE=$(date +"%Y-%m-%d-%H:%M")

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
for LOCATION in "$GJOEVIK" "$OSLO" "$BERGEN" "$TRONDHEIM" "$TROMSOE" "$KRISTIANSAND"
do
	#Variable assignment of the temparature, precipication and humidity. Value of each category is found by using grep.
	PRECIPITATION=$(echo "$LOCATION" | grep -E "symbol" | grep -E -o 'code=".*"' | head -n3 | tail -n1 | grep -E -o '".*"' | sed -E 's/^.//g; s/.$//g')

	FIRST_TEMPERATURE=$(echo "$LOCATION" | grep "$CURRENT_HOUR" -A 3 | grep -E "temperature" | grep -o -E "(-?[0-9]{1,2}\.[0-9])" )
        SECOND_TEMPERATURE=$(echo "$LOCATION" | grep "$CURRENT_HOUR_PLUS_TWO" -A 3 | grep -E "temperature" | grep -o -E "(-?[0-9]{1,2}\.[0-9])" )
        THIRD_TEMPERATURE=$(echo "$LOCATION" | grep "$CURRENT_HOUR_PLUS_THREE" -A 3 | grep -E "temperature" | grep -o -E "(-?[0-9]{1,2}\.[0-9])" )
	if [[ $LOCATION == $GJOEVIK ]]; then
                echo "<!DOCTYPE html>" > index.html
        	echo "<html>" >> index.html
        	echo "<head>" >> index.html
        	echo "<meta charset="UTF-8">" >> index.html
        	echo "<title>Weather forecast</title>" >> index.html
		echo "<style>ul,li{margin-left: 20px;}</style>" >> index.html
		echo "</head>" >> index.html
        	echo "<body>" >> index.html
        	echo "<h1>Weather forecast</h1>" >> index.html
        	echo "<p>Forecast updated at "$DIR_DATE"</p>" >> index.html


	fi

	if [[ $LOCATION == $GJOEVIK ]]; then
	echo "<li> <a href="cities/$DIR_DATE/Gjøvik.html">Gjøvik</a>: ("$PRECIPITATION")  "$FIRST_TEMPERATURE", "$SECOND_TEMPERATURE", "$THIRD_TEMPERATURE" </li>" >> index.html
	fi

        if [[ $LOCATION == $OSLO ]]; then
		echo "<li> <a href="cities/$DIR_DATE/Oslo.html">Oslo</a>: ("$PRECIPITATION") "$FIRST_TEMPERATURE", "$SECOND_TEMPERATURE", "$THIRD_TEMPERATURE"</li>" >> index.html
        fi

	if [[ $LOCATION == $BERGEN ]]; then
               	echo "<li> <a href="cities/$DIR_DATE/Bergen.html">Bergen</a>: ("$PRECIPITATION") "$FIRST_TEMPERATURE", "$SECOND_TEMPERATURE", "$THIRD_TEMPERATURE"</li>" >> index.html
        fi

	if [[ $LOCATION == $TRONDHEIM ]]; then
               	echo "<li> <a href="cities/$DIR_DATE/Trondheim.html">Trondheim</a>: ("$PRECIPITATION") "$FIRST_TEMPERATURE", "$SECOND_TEMPERATURE", "$THIRD_TEMPERATURE"</li>" >> index.html
        fi

	if [[ $LOCATION == $TROMSOE ]]; then
               	echo "<li> <a href="cities/$DIR_DATE/Tromsø.html">Tromsø</a>: ("$PRECIPITATION") "$FIRST_TEMPERATURE", "$SECOND_TEMPERATURE", "$THIRD_TEMPERATURE"</li>" >> index.html
        fi

	#Makes one for Kristiansand if it is an even day
	if [[ $(($(date +%d) % 2)) == 0 ]]; 
	then
		if [[ $LOCATION == $KRISTIANSAND ]]; then
                	echo "<li> <a href="cities/$DIR_DATE/Kristiansand.html">Kristiansand</a>: ("$PRECIPITATION") "$FIRST_TEMPERATURE", "$SECOND_TEMPERATURE", "$THIRD_TEMPERATURE"</li>" >> index.html
        	fi
	else
			echo "Today is an odd day! That means Kristiansand will not be scraped!"
			#echo "Kristiansand will not be scraped, because today is not an even day."
	fi

	echo "</ul>" >> index.html
        echo "</body>" >> index.html
        echo "</html>" >> index.html
done


