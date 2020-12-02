#!/usr/bin/env bash
lockfile=/tmp/localfile

# Variables
mail_addr=$1
logfile=/var/log/nginx/access.log
mylogfile=myaccess.log
top_lines=10
export top_lines mylogfile

# Check parameters. Need e-mail address parameter
if [[ -n "$1" ]]
then

# Block repeat run script
if ( set -o noclobber; echo "$$" > "$lockfile") 2> /dev/null;
then
    trap 'rm -f "$lockfile"; exit $?' INT TERM EXIT
    if  true
    then
    # What to do
	read log_line_file < ./linefile
	a=$(wc $logfile)
	count_log_file=$(echo $a|cut -d' ' -f1)
	
	# echo "Tail -n $( expr $count_log_file - $log_line_file )"
	# echo "Line is read from log - $log_line_file"
	# echo "Line in access.log file - $count_log_file"
	# Read log file in every running
	if [[ $log_line_file > $count_log_line ]]
		then cat $logfile | tail -n $( expr $count_log_file - $log_line_file ) > $mylogfile 
		echo "$count_log_file" > ./linefile
		else if [[ $log_line_file < $count_log_line ]]
			then cat $logfile > $mylogfile 
			echo "$count_log_file" > ./linefile
			else echo "Nothing to report" >> messages.txt
			exit
			fi
	fi
	
	# Create Report file 
	echo "NGINX Log Report $(date +'%d/%b/%Y:%H:%M' -d '-1 hour') - $(date +'%d/%b/%Y:%H:%M')" >> messages.txt
        /bin/bash script
        mail -s "CronTab report" $mail_addr < messages.txt && rm -f messages.txt
    fi
   sleep 30 # Only for test 
   rm -f "$mylogfile"
   rm -f "$lockfile"
   trap - INT TERM EXIT
else
   echo "Failed to acquire lockfile: $lockfile."
   echo "Held by $(cat $lockfile)"
fi

else
	echo "Please enter e-mail address parametr. Exit..."
	exit
fi