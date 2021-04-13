#!/usr/bin/bash
#startproject.sh

path="../tek2/Semestre4/" # change this if you want use move project

black='\e[0;30m'
gray='\e[1;30m'
red='\e[0;31m'
pink='\e[1;31m'
blackgreen='\e[0;32m'
green='\e[1;32m'
orange='\e[0;33m'
yellow='\e[1;33m'
blackblue='\e[0;34m'
blue='\e[1;34m'
blackpurple='\e[0;35m'
purple='\e[1;35m'
blackcyan='\e[0;36m'
cyan='\e[1;36m'
blackgray='\e[0;37m'
white='\e[1;37m'
neutral='\e[0;m'

function error_handling()
{
    if [ "$#" -eq 1 ] 
    then
        if [ "$1" == "--help" ] 
        then
            echo "USAGE:"
            echo "    ./start_project link name"
            echo ""
            echo "DESCRIPTION:"
            echo "    [link]     ssh link clone your github repository"
            echo "    [name]     the name of the repository"
            echo -e "\nExample:\n    ./start_project git@git.com:example/test.git test"
            exit
        fi
        echo "This script takes 2 arguments, retry with --help"
        exit
    fi
    if [ "$#" -ne 2 ] 
    then
        echo "This script takes 2 arguments, retry with --help"
        exit
    fi
    cd
    if [ -d "delivery/tools" ]
    then
        echo -e "${green}Tools folder found.${neutral}"
        cd delivery/tools
    else
        echo -e "${red}Tools folder not found.${neutral}"
        exit
    fi
}

function gpush_all()
{
    echo -e "${blue}Preparing all commit${neutral}"
    echo "# $1" >> README.md
    git add Makefile
    git commit -m "[ADD] Makefile"
    git add .gitignore
    git commit -m "[ADD] .gitignore"
    git add README.md
    git commit -m "[ADD] readme.md"
    git add src/*
    git commit -m "[ADD] first main"
    git add include/*
    git commit -m "[ADD] first include"
    git add .github/workflows/test.yaml
    git commit -m "[ADD] github action"
    echo -e "${green}All commit done${neutral}"
    echo -e "${blue}Start push${neutral}"
    git push
    git branch dev
    git push --set-upstream origin dev
    echo -e "${green}Push commit and dev branch done${neutral}"
}

function copy_c()
{
    echo -e "${blue}COPY IN PROGRESS ...${neutral}"
    cp c/Makefile $1
    cp -r c/include/ $1
    cp -r c/src/ $1
    #cp -r c/tests $1
    cp .gitignore $1
    cp -r .github/ $1
    echo -e "${green}END OF COPY${neutral}"
}

function copy_cpp()
{
    echo -e "${blue}COPY IN PROGRESS ...${neutral}"
    cp cpp/Makefile $1
    cp -r cpp/include/ $1
    cp -r cpp/src/ $1
    #cp -r cpp/tests $1
    cp .gitignore $1
    cp -r .github/ $1
    echo -e "${green}END OF COPY${neutral}"
}

function start_clone()
{
    echo -e "${blue}CLONE IN PROGRESS ...${neutral}"
    git clone $1
    echo -e "${green}END OF CLONE${neutral}"
    read -p 'It is a C project or C++ project ? ' language
    if [ "$language" = "C" ]
        then
        copy_c $2
    else
        copy_cpp $2
    fi
    read -p 'What is the binary name ? ' bin
    echo -e "${blue}Start to write the binany${neutral}"
    sed -i 38i"BIN			=   $bin" $2/Makefile
    sed -i 12i"$bin" $2/.gitignore
    echo -e "${green}Write binany done${neutral}"
}

error_handling $1 $2
start_clone $1 $2
read -p 'Do you want rename your repo ? (yes / no) ' rename
if [ "$rename" = "yes" ] 
then
    read -p 'What is the new name of this repo ? ' name
    mv ./"$2" ./"$name"
fi
read -p 'Do you want move your repo ? (yes / no) ' mov
if [ "$mov" = "yes" ] 
then
    read -p 'Where do you move your repo ? ' ans
    if [ "$rename" = "yes" ]
    then
        $path += $ans
        mv $name "$path"
    else
        mv $2 "$path"
    fi
    cd "$path"
fi
if [ "$rename" = "yes" ] 
then
    cd ./"$name"
else
    cd $2
fi
gpush_all $2