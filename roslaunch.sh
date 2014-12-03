#!/bin/bash

start_ros () {
#Get ROS bash commands
  source /opt/ros/indigo/setup.sh
#Get custom packages (this script will launch with 'sudo', so it'll be the root user
  export ROS_PACKAGE_PATH=/home/palop/catkin_ws/src/:$ROS_PACKAGE_PATH

#Home directory of your user for logging
  export HOME="/home/user/palop"
#Home directory for your user for logging
  export ROS_HOME="/home/user/palop"
 
#I run ROS on a headless machine, so I want to be able to connect to it remotely
  export ROS_IP="82.130.46.91"
#I like to log things, so this creates a new log for this script
  LOG="/var/log/my_robot.log"
 
#Time/Date stamp the log
  echo -e "\n$(date +%Y:%m:%d-%T) - Starting ROS daemon at system startup" >> $LOG
  echo "This launch will export ROS's IP as $ip" >> $LOG
 
#For bootup time calculations
  START=$(date +%s.%N)
#This is important. You must wait until the IP address of the machine is actually configured by all of the Ubuntu process. Otherwise, you will get an error and launch will fail. This loop just loops until the IP comes up. 192.168.1.10
  while true; do
        IP="`ifconfig  | grep 'inet addr:'82.130.46.91''| cut -d: -f2 | awk '{ print $1}'`"

        if [ "$IP" ] ; then
                echo "Found"
                break
        	
	fi
  done
### Run multicopter_map as service


#For bootup time calculations
  END=$(date +%s.%N)
  echo "It took $(echo "$END - $START"|bc ) seconds for an IP to come up" >> $LOG
  echo "Launching default_package default_launch into a screen with name 'ros'." >> $LOG
  #screen -dmS roslaunch "multicopter_map" "rviz.launch"
  roslaunch "multicopter_map" "rviz.launch"
}
start_ros
#case "$1" in
#  start)
#        start_ros
#esac
# 
#exit 0
