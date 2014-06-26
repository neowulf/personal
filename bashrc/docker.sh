

export DOCKER_HOST="tcp://localhost:4243"

alias dl="docker ps -l -q"

#Removing Containers
#  http://stackoverflow.com/a/17237701/1216965
# docker ps -a | grep 'weeks ago' | awk '{print $1}' | xargs docker rm

#Removing Images 
# docker rmi -f $(docker images | \grep ^\<none | awk '{print $3}')

## Docker
# https://github.com/warren5236/WordpressWithVagrant/blob/UsingBootstrap.sh/Vagrantfile
# http://stackoverflow.com/questions/15408969/how-do-i-destroy-a-vm-when-i-deleted-the-vagrant-file
