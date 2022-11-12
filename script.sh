#!/bin/bash

YUM_CMD=$(which yum)
APT_CMD=$(which apt)
PACKAGE="git"
FILE_NAME_PACKAGE="package_list.txt"
GIT_REPPO="https://git.savannah.gnu.org/git/grep.git/"
FILE_NAME_TREE="tree.txt"


if [[ ! -z $YUM_CMD ]]; then #check system
    yum update #update system
    yum install $PACKAGE #install package
    yum list installed > $FILE_NAME_PACKAGE #add installed packeges into file
elif [[ ! -z $APT_CMD ]]; then
    apt update
    apt install $PACKAGE
    apt list --installed > $FILE_NAME_PACKAGE
else
    echo "error can't install package $PACKAGE"
    exit 1;
fi


clone_git_repo(){
   url=$GIT_REPPO #get git url
   basename=$(basename $url) #take base name of url
   foldername=${basename%.*} # take name without .git
   take_path=$(cd "$(dirname "$foldername")" && pwd)/$(basename "$foldername") # create path to the git repo
   if [ -d "$take_path" ] #check if repo exist
   then
     echo "You repo exist"
   else
     git clone -l $GIT_REPPO #If not clone repo from github
   fi

}

clone_git_repo # call function

take_path(){
    url=$GIT_REPPO
    basename=$(basename $url)
    foldername=${basename%.*}
    take_path=$(cd "$(dirname "$foldername")" && pwd)/$(basename "$foldername")
    for entry in "$take_path"/* "$take_path"/*/* # run loop with recursion file check
    do
      echo "$entry" >>$FILE_NAME_TREE # add file path into file
    done

}

take_path

echo "ALL DONE"
