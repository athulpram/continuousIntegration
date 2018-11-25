gitURL=$1
watchTime=$2

repoName=$(echo $1|rev|cut -d'/' -f1|rev|cut -d '.' -f1 )

if [ ! -d ${repoName} ]; then
 git clone $gitURL
fi

cd $repoName
while true; do
  git pull
  clear
  echo "===============Continues integration running on $repoName==============="
  date
  tree
  mocha > ../.lastMochaReport
  mocha --reporter landing
  sleep $watchTime;
done
