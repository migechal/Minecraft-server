#!/bin/bash
sudo apt-get update
sudo apt install 
sudo apt-get install git openjdk-8-jre-headless
sudo java -version
mkdir Server && cd Server
wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

read -p "How many Gigabits of memory do you want:   " gb
let "g = $((gb/4))"
echo $g
java -Xms${g}G -Xmx"${gb}"G -jar ../BuildTools.jar
sed 's/# eula=false/eula=true/' eula.txt
sed 's/# enable-rcon=false/enable-rcon=true' server.properties
echo "#!/bin/bash" > start.sh
echo java -Xms${g}G -Xm${gb}G -jar Server/BuildTools.jar nogui >> start.sh
chmod +x start.sh
echo "This took $SECONDS seconds"
