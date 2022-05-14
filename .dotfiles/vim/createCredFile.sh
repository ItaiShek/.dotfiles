#!/bin/bash

# create a credentials file for vimrc abbreviations

vimCredFile="$HOME/.dotfiles/vim/cred.vim"

# get credentials from the user
until [[ $checkInput == 'y' ]] || [[ $checkInput == 'Y' ]]
do
	# initialize the variables
	fullName=""
	githubProfile=""
	email=""

	# get non-empty input
	until [ "$fullName" ]
	do
		echo "Enter your full name:"
		read fullName
	done
	
	until [ "$githubProfile" ]
	do
		echo "Enter your github profile:"
		read githubProfile
	done
	
	until [ "$email" ]
	do
		echo "Enter your email address:"
		read email
	done
	
	# let the user verify the credentials
	echo 
	echo "MY_NAME=$fullName"
	echo "GITHUB_PROFILE=$githubProfile"
	echo "MY_EMAIL=$email"
	echo
	echo "Is this correct? [y/n/q]"
	read checkInput

	# give a change to quit
	if [[ $checkInput == 'q' ]] || [[ $checkInput == 'Q' ]]
	then
		exit
	fi
done

# enter the credentials to a file
echo "Creating the file"
echo "let MY_NAME=\"$fullName\"" > $vimCredFile
echo "let GITHUB_PROFILE=\"$githubProfile\"" >> $vimCredFile
echo "let MY_EMAIL=\"$email\"" >> $vimCredFile
echo "Done"
