#!/bin/bash
SERVER_IP="172.19.40.46"
butlerinfo () {
    data="$1"
    bot_ip=`sudo /opt/butler_server/bin/butler_server rpcterms butlerinfo get_by_id $1. | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
    echo "Butler Ip: $bot_ip"
    echo "<br>" 
    if [ ! -n "$bot_ip" ]
    then
        echo "Wrong Butler ID"
    else
        ping -c1 -W 1 $bot_ip   >/dev/null
        if [ $? -eq 0 ]; then
           tmux new-session -d -s $data "sshpass -p 'apj0702' ssh -o StrictHostKeyChecking=no -t gor@$bot_ip 'echo 'apj0702' | sudo -S /data/puppet/puppetsync.sh'"
           echo "Tmux created for Butler $1...."
        else
           echo "Butler is not ON.....turn on Butler FIRST"
        fi  
    fi
}

butlerinfo $1
sleep 0.5
butlerinfo $2
sleep 0.5
butlerinfo $3
sleep 100.5
butlerinfo $4
sleep 0.5
butlerinfo $5
sleep 0.5
butlerinfo $6
sleep 0.5
butlerinfo $7
sleep 0.5
butlerinfo $8
sleep 0.5
butlerinfo $9
sleep 0.5

session_1="$1"
session_2="$2"
session_3="$3"
session_4="$4"
session_5="$5"
session_6="$6"
session_7="$7"
session_8="$8"
session_9="$9"
sion_1=false
sion_2=false
sion_3=false
sion_4=false
sion_5=false
sion_6=false
sion_7=false
sion_8=false
sion_9=false

while [ "$sion_1" == false ] || [ "$sion_2" == false ] || [ "$sion_3" == false ] || [ "$sion_4" == false ] || [ "$sion_5" == false ] || [ "$sion_6" == false ] || [ "$sion_7" == false ] || [ "$sion_8" == false ] || [ "$sion_9" == false ]
do
  # Check if the session exists, discarding output
  # We can check $? for the exit status (zero for success, non-zero for failure)
  sleep 0.1

  ###############################

  tmux has-session -t $session_1 2>/dev/null
  
  if [ $? != 0 ]; then
      echo "Butler Id : $session_1 puppetsync complete"
      sion_1=true
  else
    echo "Butler Id : $session_1 puppetsync RUNNING"
  fi
  sleep 0.1

  ###################################

  tmux has-session -t $session_2 2>/dev/null
  
  if [ $? != 0 ]; then
      echo "Butler Id : $session_2 puppetsync complete"
      sion_2=true
  else
    echo "Butler Id : $session_2 puppetsync RUNNING"
  fi
  sleep 0.1

  ##########################


  tmux has-session -t $session_3 2>/dev/null
  
  if [ $? != 0 ]; then
      echo "Butler Id : $session_3 puppetsync complete"
      sion_3=true
  else
    echo "Butler Id : $session_3 puppetsync RUNNING"
  fi
  sleep 0.1

  #########################################
  tmux has-session -t $session_4 2>/dev/null
  
  if [ $? != 0 ]; then
      echo "Butler Id : $session_4 puppetsync complete"
      sion_4=true
  else
    echo "Butler Id : $session_4 puppetsync RUNNING"
  fi
  sleep 0.1

  ##################################3

  tmux has-session -t $session_5 2>/dev/null
  
  if [ $? != 0 ]; then
      echo "Butler Id : $session_5 puppetsync complete"
      sion_5=true
  else
    echo "Butler Id : $session_5 puppetsync RUNNING"
  fi
  sleep 0.1
  #################################3

  tmux has-session -t $session_6 2>/dev/null
  
  if [ $? != 0 ]; then
      echo "Butler Id : $session_6 puppetsync complete"
      sion_6=true
  else
    echo "Butler Id : $session_6 puppetsync RUNNING"
  fi
  sleep 0.1

  ###############################

  tmux has-session -t $session_7 2>/dev/null
  
  if [ $? != 0 ]; then
      echo "Butler Id : $session_7 puppetsync complete"
      sion_7=true
  else
    echo "Butler Id : $session_7 puppetsync RUNNING"
  fi
  sleep 0.1

  ####################################

  tmux has-session -t $session_8 2>/dev/null
  
  if [ $? != 0 ]; then
      echo "Butler Id : $session_8 puppetsync complete"
      sion_8=true
  else
    echo "Butler Id : $session_8 puppetsync RUNNING"
  fi
  sleep 0.1

  ###############################

  tmux has-session -t $session_9 2>/dev/null
  
  if [ $? != 0 ]; then
      echo "Butler Id : $session_9 puppetsync complete"
      sion_9=true
  else
    echo "Butler Id : $session_9 puppetsync RUNNING"
  fi
  sleep 2
done
