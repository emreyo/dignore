#!/bin/bash

if [ ! -d "$HOME/bin" ]; then
	mkdir -p "$HOME/bin"
fi

if [ ! -f "$HOME/.gitignore.list" ]; then
	cp ./list "$HOME/.gitignore.list"
fi

if [ ! -f "$HOME/bin/dignore" ]; then
	cp ./dignore.sh "$HOME/bin/dignore"
	echo -e "please use this command to make me global:\nchmod +x $HOME/bin/dignore"
fi

list()
{
	echo -e "*******************\nSupported Languages\n*******************"
	# cat ./list | xargs echo
	printf "%-20s %-20s %-20s\n" $(cat $HOME/.gitignore.list) # ?!?!
	echo "*******************"
	echo "****end of list****"
	echo "*******************"
}

if [ $# == 0 ]; then
	list
	exit 1
fi

# if [ -z $(grep "$1" "$HOME/.gitignore.list") ]; then
# 	echo "e"
# else
# 	echo "n"
# fi

if [ -z $(grep -x "$1" "$HOME/.gitignore.list") ]; then
	echo -e "* \"$1\" not found\n* execute\n - \"$0\" or\n - \"$0 list\"\n for list of supported languages\n"
	exit 1
fi

if [ -f .gitignore ]; then
	echo "* There's a .gitignore file here" 
	read -p "* Do you want me to create a backup of it? (y/n): "

	if [ $REPLY == "y" ]; then
		cp .gitignore .gitignore.bak
		echo "* Old .gitignore file backed up as .gitignore.bak"
	fi
else
	echo dasdsa
fi

curl -s "https://raw.githubusercontent.com/github/gitignore/master/$1.gitignore" > ".gitignore"
echo "* .gitignore file for $1 is downloaded successfully"
exit 0