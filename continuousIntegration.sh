gitURL=$1
watchTime=$2

repoName=$(echo $1|rev|cut -d'/' -f1|rev|cut -d '.' -f1 )

if [ ! -d ${repoName} ]; then
 git clone $gitURL
fi

cd $repoName

watch -n $watchTime 'git pull>/dev/null;mocha'
