#!/bin/bash

DIR_DATE=$(date +"%Y-%m-%d-%H:%M")

#Making directory with a subfolder based on the date.
mkdir cities
mkdir cities/$DIR_DATE

#For loop that reads txt files from a specific folder and makes html pages for each of the cities with their own unique weather forecast.
for FILE in scraped-weather/*/*.txt
do
	#Variable assignments needed to show the correct information.
	CITY=$(cat "$FILE" | head -n1)
	TEMPERATURE=$(cat "$FILE" | head -n4 | tail -n3)
	PRECIPICATION=$(cat "$FILE" | tail -n3 | head -n1)
	SCRAPED=$(cat "$FILE" | tail -n2 | head -n1)
	HUMIDITY=$(cat "$FILE" | tail -n1)

	FIRST_TEMPERATURE=$(cat "$FILE" | head -n4 | tail -n3 | head -n1)
	SECOND_TEMPERATURE=$(cat "$FILE" | head -n4 | tail -n3 | head -n2 | tail -n1)
	THIRD_TEMPERATURE=$(cat "$FILE" | head -n4 | tail -n3 | tail -n1)

	CURRENT_TIME=$(date +%H:%M)
	PLUS_ONE_HOUR=$(date +%H:%M -d '1 hour')
	PLUS_TWO_HOURS=$(date +%H:%M -d '2 hours')

	#Writing the HTML using several echoes.
	echo "<!DOCTYPE html>" > "$CITY".html
  	echo "<html>" >> "$CITY".html
  	echo "<head>" >> "$CITY".html
	echo "<meta charset="UTF-8">" >> "$CITY".html
  	echo "<title>$CITY</title>" >> "$CITY".html
	echo "<style>span{font-weight: bold; font-style: italic; color: red;} body{max-width: 50%; margin: 0 auto; }</style>" >> "$CITY".html
  	echo "</head>" >> "$CITY".html
  	echo "<body>" >> "$CITY".html
  	echo "<h1>Weather forecast for <span>$CITY<span></h1>" >> "$CITY".html
  	echo "<p>Time and temperatures</p>" >> "$CITY".html
  	echo "<ul>" >> "$CITY".html

	for line in "$TEMPERATURE"; do
		echo "<li><b>"$CURRENT_TIME":</b> </li> <ul><li>"$FIRST_TEMPERATURE" °C</li></ul>" >> "$CITY".html
                echo "<li><b>"$PLUS_ONE_HOUR":</b> </li> <ul><li>"$SECOND_TEMPERATURE" °C</li></ul>" >> "$CITY".html
                echo "<li><b>"$PLUS_TWO_HOURS":</b> </li> <ul><li>"$THIRD_TEMPERATURE" °C</li></ul>" >> "$CITY".html
	done

 	echo "</ul>" >> "$CITY".html
	echo "<p>Forecast: It is <b>"$PRECIPICATION"</b> with <b>"$HUMIDITY"% </b> humidity</p>" >> "$CITY".html
	echo "<p>Fetched on <b>$SCRAPED</b> </p>" >> "$CITY".html
  	echo "<p><a href="../../index.html">Weather forecast for Norwegian cities</p>" >> "$CITY".html
	echo "</body>" >> "$CITY".html
	echo "</html>" >> "$CITY".html
done

mv *.html $HOME/prosjekt/cities/$DIR_DATE
#Changing directory into the one mentioned below, removing unrelevant index.html
cd $HOME/prosjekt/cities/$DIR_DATE
rm index.html

