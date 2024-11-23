#!/bin/bash

cleanup() {
    tput cnorm
}

trap cleanup EXIT;

echo "Please enter the name of the game (case sensitive)"
read -r Answer

search=$(pgrep "$Answer")
if [ -z ${search} ];
then output=$(pgrep steam.exe);
echo "Found steam.exe Would you like to kill it [y/n]?"
else output=$(pgrep "$Answer")
echo "Found $Answer Would you like to kill it [y/n]?"
fi

tput civis;

stty -echo; echo -n $'\e[6n'; read -d R z; stty echo;
	IFS=";" read -ra pos <<< "${z#??}"
	unset IFS

	options=(
	"yes"
	"no"
		    )
	cur=0
	count=${#options[@]}
	index=0
	esc=$(echo -en "\e")

    while true
    do
        index=0
        for o in "${options[@]}"
        do
            if [ "$index" == "$cur" ]
            then tput cup "${pos[0]}" 1; echo -en " \e[7m$o\e[0m " # mark & highlight the current option
            else tput cup "${pos[0]}" 6; echo -en " $o "
            fi
            index=$(( $index + 1 ))
        done
        read -s -n3 key
        if [[ $key == $esc[D ]] # right arrow
        then cur=$(( $cur - 1 ))
            [ "$cur" -lt 0 ] && cur=$(( $count - 1 ))
        elif [[ $key == $esc[C ]] # left arrow
        then cur=$(( $cur + 1 ))
            [ "$cur" -ge $count ] && cur=0
        elif [[ $key == "" ]] # nothing, i.e the read delimiter - ENTER
        then break
        fi
        echo -en "\e[${count}A" # go up to the beginning to re-render
    done

choice="${options[$cur]}"
echo "Selected choice: ${options[$cur]}"

if [ "$choice" == "yes" ]; then
kill "$output"
fi

if [ "$choice" == "no" ]; then
echo "You said no"
fi

echo "Hope that worked :D"
exit
