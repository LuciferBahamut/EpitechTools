#!/usr/bin/bash
#startproject.sh

cd
cd delivery/tools/
git clone $1
read -p 'It is a C project or C++ project ? ' language
if [ "$language" = "C" ]
then
    cp c/Makefile $2
    cp c/.gitignore $2
    cp -r c/include/ $2
    cp -r c/src/ $2
    cp -r c/tests $2
else
    cp cpp/Makefile $2
    cp cpp/.gitignore $2
    cp -r cpp/include/ $2
    cp -r cpp/src/ $2
    cp -r cpp/tests $2
fi
cp -r .github/ $2
read -p 'Do you want rename your repo ? ' rename
if [ "$rename" = "yes" ] 
then
    read -p 'What is the new name of this repo ? ' name
    mv ./"$2" ./"$name"
fi
read -p 'Do you want move your repo ? ' mov
if [ "$mov" = "yes" ] 
then
    read -p 'Where do you move your repo ? ' ans
    if [ "$rename" = "yes" ]
    then
        mv $name ../tek2/Semestre4/"$ans"
    else
        mv $2 ../tek2/Semestre4/"$ans"
    fi
    cd ../tek2/Semestre4/"$ans"
fi
if [ "$rename" = "yes" ] 
then
    cd ./"$name"
else
    cd $2
fi
echo "# $2" >> README.md
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
git push
git branch dev
git push --set-upstream origin dev