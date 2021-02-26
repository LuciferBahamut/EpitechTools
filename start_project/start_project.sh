#!/usr/bin/bash
#startproject.sh

cd
cd delivery/tools/
git clone $1
cp Makefile $2
cp .gitignore $2
cp -r include/ $2
cp -r src/ $2
cp -r .github/ $2
cp -r tests $2
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
git add Makefile
git commit -m "[ADD] Makefile"
git add .gitignore
git commit -m "[ADD] .gitignore"
git push
git branch dev
git push --set-upstream origin dev