# Nuke every container, image and dangling volume.
# Each step is guarded: `docker rm` with no arguments is an error.
function dcc(){
  local ids
  ids=$(docker ps -aq)                      && [[ -n "$ids" ]] && docker rm -f ${=ids}
  ids=$(docker images -q)                   && [[ -n "$ids" ]] && docker rmi -f ${=ids}
  ids=$(docker volume ls -qf dangling=true) && [[ -n "$ids" ]] && docker volume rm ${=ids}
  return 0
}

function gcam(){
  git commit -m $@ -S
}

function vsc () {
	if (( $# ))
	then
		code $@
	else
		code .
	fi
}
