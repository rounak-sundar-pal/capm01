git add
echo -n "What is the change for?"
read;
git commit -m "${REPLY}"
git push