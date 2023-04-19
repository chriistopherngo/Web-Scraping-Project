#!/bin/bash

DIR_DATE=$(date +"%Y-%m-%d-%H:%M")

mkdir git-scraped-weather
mkdir git-cities
mv git-scraped-weather $HOME/prosjekt-host2022
mv git-cities $HOME/prosjekt-host2022
cp -r scraped-weather/$DIR_DATE scraped-weather/$DIR_DATE-git
cp -r cities/$DIR_DATE cities/$DIR_DATE-git
mv scraped-weather/$DIR_DATE-git $HOME/prosjekt-host2022/git-scraped-weather
mv cities/$DIR_DATE-git $HOME/prosjekt-host2022/git-cities

cd $HOME/prosjekt-host2022

#git commands to push to centralized repository (https://gitlab.stud.idi.ntnu.no/chrisng/prosjekt-host2022)
git add git-scraped-weather
git add git-cities

git commit -m "Forecast update from $DIR_DATE"
git push

cd $HOME/prosjekt

rm -r git-scraped-weather
rm -r git-cities

