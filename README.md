# ports-sysv
ports based lfs sysv

bash-completion with sudo
complete -cf sudo


sensors-detect


Gamemode
	sudo  gpasswd -a <username> gamemode

networkmanager
	sudo usermod -a -G netdev <username>

# Eww Dot files

modify lang into Weather.sh
WEATHLANG=x

and into

case $WEATHLANG in
	fr) WEATHER_FEELS_LIKE_TRAD="Temp .Apparente" ;;
	*)  WEATHER_FEELS_LIKE_TRAD="Feels Like" ;;
esac

add a new for your language   x) WEATHER_FEELS_LIKE_TRAD="Your Text" ;;

for a spanish add:
	es) WEATHER_FEELS_LIKE_TRAD="Temp. Aparente" ;;

# Example:
case $WEATHLANG in
	fr) WEATHER_FEELS_LIKE_TRAD="Temp. Apparente" ;;
	es) WEATHER_FEELS_LIKE_TRAD="Temp. Aparente" ;;
	*)  WEATHER_FEELS_LIKE_TRAD="Feels Like" ;;
esac

