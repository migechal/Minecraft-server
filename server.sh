#!/bin/bash
sudo apt-get update -qq
progressfilt ()
{
    local flag=false c count cr=$'\r' nl=$'\n'
    while IFS='' read -d '' -rn 1 c
    do
        if $flag
        then
            printf '%s' "$c"
        else
            if [[ $c != $cr && $c != $nl ]]
            then
                count=0
            else
                ((count++))
                if ((count > 1))
                then
                    flag=true
                fi
            fi
        fi
    done
}
GREEN='\033[0;32m'
NOTHING='\033[0m'
sudo apt install -qq
sudo apt-get install git openjdk-8-jre-headless -qq
mkdir Server
echo -e "${GREEN} +Entering Server Directory"
cd Server
sleep 2s
echo -e "+Downloading Server 'BuildTools.jar' ${NOTHING}"
sleep 2s
wget --progress=bar:force https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar 2>&1 | progressfilt
sleep 2s
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
            read -p "How many Gigabites of memory do you want:    " gb
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
