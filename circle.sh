#!/usr/bin/env bash
#11-12-2014

dir1=$CIRCLE_ARTIFACTS
CONTAINER=brownman/docker_rootless


run1(){
 local str=$1
 shift
 local args=( $@ )
 local cmd="${args[@]}"
 echo cmd: $cmd
 docker run $CONTAINER bash -c "$cmd" 1>$dir1/${str}.out.txt  2>$dir1/${str}.err.txt
 echo -e '----\n err:' >> $dir1/${str}.out.txt
 cat $dir1/${str}.err.txt >> $dir1/${str}.out.txt
 cp $dir1/${str}.out.txt $dir1/${str}.txt
 rm $dir1/${str}.err.txt
 rm  $dir1/${str}.out.txt
}




run1 env env > $dir1/env.txt
#run1 netstat 'mongod --fork -f /etc/mongodb.conf; sleep 1; netstat -ntlp'
run1 npm_packages1 'ls `npm root -g`'
run1 bashrc_root 'cat /root/.bashrc'
run1 ps 'ps aux'
run1 circle_sh 'cat circle.sh'


#run1 grunt 'ls $(which grunt) -l'


#docker run brownman/runner1 'apt-get install locate;updatedb; locate grunt-cli' &> /tmp/grunt2.txt

 #sudo -u gitlab_ci_runner -H 'env' > /tmp/env.txt

