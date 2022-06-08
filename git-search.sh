#!/bin/bash
echo "\nEnter a valid github owner :"
read owner
echo "\nEnter a valid github repository name in $owner:"
read repo
mkdir log/
mkdir log/$owner
echo "\n\n"
curl https://api.github.com/repos/$owner/$repo/issues > log/$owner/check.json
var=$(grep -i "Not Found" log/$owner/check.json | wc -l)
if(($var == 0));
then
echo "\n"
cat log/$owner/check.json | jq '.[].timeline_url' > log/$owner/repo.json
echo "The open issues/PRs are :\n"
cut -d "/" -f 7,8 log/$owner/repo.json
else
echo "\n\nInvalid user"
fi
rm -rf log/
