function dcc(){
  docker stop `docker ps -a -q`
  docker rm `docker ps -a -q`
  docker rmi -f `docker images -q`
  docker volume rm $(docker volume ls -f dangling=true -q)
}

function gcam(){
  git commit -m $@ -S
}
