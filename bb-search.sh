#!/bin/bash
echo "\nEnter a valid  bitbucket username :"
read user
mkdir log/
mkdir log/$user
curl https://api.bitbucket.org/2.0/repositories/$user?fields=next,values.slug > log/$user/repo.txt
var=$(grep -i "No workspace with identifier" log/$user/repo.txt | wc -l)
if(($var == 0));
then
echo "\n"
sed -e 's/slug//g' log/$user/repo.txt | tr -d '{}[]":'| tr ',' '\n'| sed -e 's/values/ /g' > log/$user/test.txt
n=$(cat log/$user/test.txt |head| wc -l)
echo "There are$n repositories for $user:"
cat log/$user/test.txt
else
echo "\nInvalid user"
fi
rm -rf log/
