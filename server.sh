#!/bin/bash
sudo apt-get update
sudo apt install 
sudo apt-get install git openjdk-8-jre-headless
sudo java -version
mkdir Server && cd Server
wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
HEIGHT=30
WIDTH=80
CHOICE_HEIGHT=8
BACKTITLE="Type Choice"
TITLE="Gigabites or Megabites"
MENU="Choose one of the following options:"

OPTIONS=(1 "Gigabites"
         2 "Megabites")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
        	clear
        	gb=4
        	$TITLE="How many?(default 4 and 2)"
        	$OPTIONS=(1 "1"
        	2 "2"
        	3 "3"
        	4 "4"
        	5 "5"
        	6 "6"
        	7 "7"
        	8 "8"
        	9 "9"
        	10 "10")	
        	CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in 
	
		let g=$((gb/4))
            java -Xms${g}G -Xmx${gb}G -jar BuildTools.jar
            echo java -Xms${g}G -Xm${gb}G -jar Server/BuildTools.jar nogui >> ../start.sh
            ;;
        2)
        	clear
            read -p "How many Megabites of memory do you want:    " mb
            java -Xms${mb}M -Xmx${mb}M -jar BuildTools.jar
            echo java -Xms${mb}M -Xmx${mb}M -jar Server/BuildTools.jar nogui >> ../start.sh
            ;;
esac

sed 's/# eula=false/eula=true/' eula.txt
echo "#!/bin/bash" >> start.sh

chmod +x start.sh
echo "This took $SECONDS seconds"
