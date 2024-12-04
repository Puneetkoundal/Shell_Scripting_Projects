#!/bin/bash

#Script should be execute with sudo/root access

if [[ "${UID}" -ne 0 ]]
then
    echo 'Please run with sudo or root.'
    exit 1
fi

#User shuld provide atleast one argument as username else guide him

if [[ "${#}" -lt 1 ]]
then
    echo "Usage: ${0} USER_NAME [COMMENT]..."
    echo "Create a user with name USER_NAME and comment field of COMMENT"
    exit 1
fi

#Store 1st argument as user name

USER_NAME="${1}"

#In case of more than one argument, store it as account comments

shift
COMMENT="${@}"

#Create a password

PASSWORD=$(date +%s%N)

#Create the user

useradd -c "${COMMENT}" -m $USER_NAME

#check if user is successfully created or not

if [[ $? -ne 0 ]]
then
    echo "The account could not be created"
    exit 1
fi

#Set the password for the user

echo -e "$PASSWORD\n$PASSWORD" | passwd "$USER_NAME"

#check if password is successfully set or not

if [[ $? -ne 0 ]]
then 
     echo "Password could not be set"
     exit 1
fi

#Force password change on first login

passwd -e $USER_NAME

#DIsplay the username, password and the host name where the user was created

echo
echo "Username: $USER_NAME"
echo
echo "Password: $PASSWORD"
echo
echo "Hostname: $(hostname)"
