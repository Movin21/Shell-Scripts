#!/bin/bash

check_root()
{
    if [ $UID -ne 0 ]; then
        echo "You must be root to run this script."
        exit 1
    fi
}

create_user()
{
    read -p "Enter username: " username
   if id "$username" &>/dev/null; then
        echo "User $username already exists."
        exit 1
    fi
    read -p "Enter password for $username: " password
    echo
    useradd -m -s /bin/bash "$username"
    echo "$username:$password" | chpasswd
    echo"User $username has been created."

    read -p "Do you want to add $username to a user group? [y/n]: " choice
    if [ "$choice" == "y" ]; then
        read -p "Enter group name: " group
        usermod -aG "$group" "$username"
        if grep -q "$group" /etc/group; then
            echo "Group $group already exists."
        else
        read -p "Group $group does not exist. Do you want to create it? [y/n]: " choice
            if [ "$choice" == "y" ]; then   
                groupadd "$group"
                echo "Group $group has been created."
            fi
        fi

        echo "User $username has been added to group $group."
    fi  

}

delete_user ()
{
    read -p "Enter username to Delete: " username
    if id "$username" &>/dev/null; then
        userdel -r "$username"
        echo "User $username has been deleted."
    else
        echo "User $username does not exist."
    fi
   
}