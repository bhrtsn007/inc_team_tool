#!/bin/bash
SERVER_IP="172.19.40.46"
butlerinfo () {
    bot_ip=`sudo /opt/butler_server/bin/butler_server rpcterms butlerinfo get_by_id $1. | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
    echo "Butler Ip: $bot_ip"
    if [ ! -n "$bot_ip" ]
    then
        echo "Wrong Butler ID"
    else
        ping -c1 -W 1 $bot_ip   >/dev/null
        if [ $? -eq 0 ]; then
           sudo /opt/butler_server/bin/butler_server rpcterms butler_functions butler_pause_manual $1.
           sleep 1
	   bb_update $1
	   sleep 1
           ods_update_face_0 $1
	   sleep 1
           ods_update_face_1 $1
	   sleep 1
           ss_update $1
           sleep 5
           sshpass -p 'apj0702' ssh -o StrictHostKeyChecking=no -t gor@$bot_ip "echo 'apj0702'| sudo -S reboot"
	   sudo /opt/butler_server/bin/butler_server rpcterms butler_functions butler_unpause_manual $1.
           echo "OK Done...."
        else
           echo "Butler is not ON.....turn on Butler FIRST"
        fi  
    fi
}

bb_update () {
	echo "##########################################"
	echo "PROGRAMMING START FOR NAV"
	echo "##########################################"
	bot_ip=`sudo /opt/butler_server/bin/butler_server rpcterms butlerinfo get_by_id $1. | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
	sshpass -p 'apj0702' scp -o StrictHostKeyChecking=no /home/gor/easy_console/fw/app_bbb gor@$bot_ip:/tmp
	sshpass -p 'apj0702' ssh -o StrictHostKeyChecking=no -t gor@$bot_ip "echo 'apj0702'| sudo -S mv /tmp/app_bbb /data/fw/prog/apps"
	sudo /opt/butler_server/bin/butler_server rpcterms butler_functions send_programming_packet_one_butler $1.
	sleep 1
	sshpass -p 'apj0702' ssh -o StrictHostKeyChecking=no -t gor@$bot_ip "echo 'apj0702'| sudo -S python /data/fw/prog/programmers/bb_prog.py /data/fw/prog/apps/app_bbb"
	echo "##########################################"
	echo "PROGRAMMING DONE FOR NAV"
	echo "##########################################"
}

ods_update_face_0 () {
	echo "##########################################"
	echo "PROGRAMMING START FOR ODS 0"
	echo "##########################################"
	bot_ip=`sudo /opt/butler_server/bin/butler_server rpcterms butlerinfo get_by_id $1. | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
	sshpass -p 'apj0702' scp -o StrictHostKeyChecking=no /home/gor/easy_console/fw/app_ods gor@$bot_ip:/tmp
	sshpass -p 'apj0702' ssh -o StrictHostKeyChecking=no -t gor@$bot_ip "echo 'apj0702'| sudo -S mv /tmp/app_ods /data/fw/prog/apps"
	sshpass -p 'apj0702' ssh -o StrictHostKeyChecking=no -t gor@$bot_ip "echo 'apj0702'| sudo -S service butler_remote stop"
	sleep 1
	sshpass -p 'apj0702' ssh -o StrictHostKeyChecking=no -t gor@$bot_ip "echo 'apj0702'| sudo -S /data/fw/prog/programmers/ods_program 0"
	echo "##########################################"
	echo "PROGRAMMING DONE FOR ODS 0"
	echo "##########################################"
}
ods_update_face_1 () {
	echo "##########################################"
	echo "PROGRAMMING START FOR ODS 1"
	echo "##########################################"
	bot_ip=`sudo /opt/butler_server/bin/butler_server rpcterms butlerinfo get_by_id $1. | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
	#scp /home/gor/easy_console/fw/app_ods gor@$bot_ip:/data/fw/prog/apps
	#sshpass -p 'apj0702' ssh -o StrictHostKeyChecking=no -t gor@$bot_ip "echo 'apj0702'| sudo -S service butler_remote stop"
	sleep 1
	sshpass -p 'apj0702' ssh -o StrictHostKeyChecking=no -t gor@$bot_ip "echo 'apj0702'| sudo -S /data/fw/prog/programmers/ods_program 1"
	echo "##########################################"
	echo "PROGRAMMING DONE FOR ODS 1"
	echo "##########################################"

}
ss_update () {
	echo "##########################################"
	echo "PROGRAMMING START FOR SS"
	echo "##########################################"
	bot_ip=`sudo /opt/butler_server/bin/butler_server rpcterms butlerinfo get_by_id $1. | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
	sshpass -p 'apj0702' scp -o StrictHostKeyChecking=no /home/gor/easy_console/fw/app_ss gor@$bot_ip:/tmp
	sshpass -p 'apj0702' ssh -o StrictHostKeyChecking=no -t gor@$bot_ip "echo 'apj0702'| sudo -S mv /tmp/app_ss /data/fw/prog/apps"
	#sshpass -p 'apj0702' ssh -o StrictHostKeyChecking=no -t gor@$bot_ip "echo 'apj0702'| sudo -S service butler_remote stop"
	sshpass -p 'apj0702' ssh -o StrictHostKeyChecking=no -t gor@$bot_ip "echo 'apj0702'| sudo -S python /data/fw/prog/programmers/ss_program.py /data/fw/prog/apps/app_ss"
	echo "##########################################"
	echo "PROGRAMMING DONE FOR SS"
	echo "##########################################"
}
echo "##########################################"
echo "Programming Butler : $1"
butlerinfo $1
echo "##########################################"
echo  "Programming Butler : $2"
butlerinfo $2
echo "##########################################"
echo "Programming Butler : $3"
butlerinfo $3
echo "##########################################"
echo  "Programming Butler : $4"
butlerinfo $4
echo "##########################################"
echo "Programming Butler : $5"
butlerinfo $5
echo "##########################################"
echo  "Programming Butler : $6"
butlerinfo $6
echo "##########################################"
echo "Programming Butler : $7"
butlerinfo $7
echo "##########################################"
echo  "Programming Butler : $8"
butlerinfo $8
echo "##########################################"
echo "Programming Butler : $9"
butlerinfo $9


