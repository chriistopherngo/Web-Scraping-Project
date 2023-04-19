#!/bin/bash
cd $HOME/prosjekt
DIR_DATE=$(date +"%Y-%m-%d-%H:%M")

bash $HOME/prosjekt/scraping-script.sh
#Removes Kristiansand files because it is an odd day
if [[ $(($(date +%d) % 2)) == 1 ]];
then
	rm $HOME/scraped-weather/$DIR_DATE/Kristiansand.txt
	rm $HOME/cities/$DIR_DATE/Kristiansand.html
fi

bash $HOME/prosjekt/pages-script.sh

bash $HOME/prosjekt/overview-script.sh

bash $HOME/prosjekt/notification-script.sh

bash $HOME/prosjekt/repo-update-script.sh
