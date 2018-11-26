if [ $# -eq 0 ]; then
  echo "Usage:"
  echo "./continuousIntegration.sh <git URL> [Test interval]\n"
  exit
fi

gitURL=$1
watchTime=$2
touch ./.lastMochaReport

repoName=$(echo $1|rev|cut -d'/' -f1|rev|cut -d '.' -f1 )

if [ ! -d ${repoName} ]; then
 git clone $gitURL
fi

if [ -z ${watchTime} ]; then
  watchTime=600
fi

cd $repoName
while true; do
  git pull
  clear
  echo "===============Continues integration running on $repoName==============="
  date
  tree
  $(mocha|sed 's/(*.ms)//g' > ../.currentMochaReport)
  a=$(diff ../.lastMochaReport ../.currentMochaReport)
  if [ "$a" != "" ]; then
    echo $(date)"\n========================" >> ../.CILOGS
    cat ../.currentMochaReport >> ../.CILOGS
  fi
  cat ../.currentMochaReport > ../.lastMochaReport
  mocha --reporter landing
  sleep $watchTime;
done
