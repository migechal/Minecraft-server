#!/bin/bash
sudo apt-get update
sudo apt install 
sudo apt-get install git openjdk-8-jre-headless
sudo java -version
mkdir Spigot_Server && cd Spigot_Server
wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
git config --global --unset core.autocrlf
java -jar BuildTools.jar --rev 1.15.2
echo java -Xms1G -Xm4G -jar spigot.jar > start.sh
chmod +x start.sh
sudo ./start.sh
