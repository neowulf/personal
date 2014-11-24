function bd {
    $(/usr/local/bin/boot2docker shellinit)
}

alias dl="docker ps -l -q"

#Removing Containers
#  http://stackoverflow.com/a/17237701/1216965
# docker ps -a | grep 'weeks ago' | awk '{print $1}' | xargs docker rm

#Removing Images 
# docker rmi -f $(docker images | \grep ^\<none | awk '{print $3}')

#VBoxManage
#VBoxManage list runningvms
#VBoxManage controlvm

## Docker
# https://github.com/warren5236/WordpressWithVagrant/blob/UsingBootstrap.sh/Vagrantfile
# http://stackoverflow.com/questions/15408969/how-do-i-destroy-a-vm-when-i-deleted-the-vagrant-file

function init_dockerui {
    docker run --name="dockerui" -d -p 9000:9000 -v /var/run/docker.sock:/docker.sock crosbymichael/dockerui -e /docker.sock
}

function init_portaldb {
    # docker run --name="prod_portaldb" -t -i -p 3306:3306 -e user="zzz" -e password="yyy" -e right="WRITE" -e url="file:///Users/siva/Documents/hp/server/pipeline/database/prod_portaldb_10-20-14_table.sql" mysqldb

    #docker run --rm  -p 3306:3306 -e MYSQL_USER=portaldbuser -e MYSQL_PASSWORD=portaldbpw -e MYSQL_DATABASE=portaldb -e MYSQL_ROOT_PASSWORD=pwd mysql
    
    docker run --name="prod_portaldb" -d -p 3306:3306 -e MYSQL_USER=zzz -e MYSQL_PASSWORD=yyy -e MYSQL_DATABASE=xxx -e MYSQL_ROOT_PASSWORD=pwd mysql
    # 35 seconds
    gunzip < /Users/siva/Documents/hp/server/pipeline/database/prod_portaldb_10-20-14_table.sql_orig.gz | mysql -h 192.168.59.103 -u zzz -p yyy
}
