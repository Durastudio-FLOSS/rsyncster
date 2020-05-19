#!/bin/bash
# Call from cron. Scan for changes and invoke main.sh.
# Using cookie sessions on haproxy. This script gathers changes from app servers. 

LIB_PATH="$HOME/rsyncster/lib"
. $LIB_PATH/env.sh
. $LIB_PATH/function_aggregate_changes.sh
. $LIB_PATH/function_sync.sh
. $LIB_PATH/function_timestamp.sh

if [ ! -d /tmp/$CHANGES_STRING.lock ]; then

   /bin/mkdir /tmp/$CHANGES_STRING.lock

fi

if [ $? = "1" ]; then

   echo "$(timestamp) - FAILURE : unable to create $CHANGES_STRING.lock" >> $status	

else

   if [ ! -d $LOG_DIR ]; then
      /bin/mkdir $LOG_DIR
   fi
   echo "$(timestamp) - SUCCESS : created $CHANGES_STRING.lock" > $status

fi

aggregate_changes

if [ -d /tmp/$CHANGES_STRING.lock ]; then

   echo " - TASK : Updating merged changes list in local path $WORKING_DIR" >> $status

else

   echo " - TASK : Getting merged changes list in local path $WORKING_DIR" >> $status

fi

if [ -f $DOMAINS_FILE ] && [ ! -s $DOMAINS_FILE ] ; then	

   echo "$(timestamp) - FUNCTION : No changes, exiting" >> $status	
   /bin/rmdir /tmp/$CHANGES_STRING.lock
	
   if [ $? = "1" ]; then

      echo "$(timestamp) - FAILURE : Unable to delete $CHANGES_STRING.lock" >> $status
      exit 1
	
   else
        
      echo "$(timestamp) - SUCCESS : Deleted $CHANGES_STRING.lock" >> $status
      exit 1
fi

else 

   echo "$(timestamp) - SUCCESS : Syncing changes list" >> $status
   sync
   /bin/rmdir /tmp/$CHANGES_STRING.lock
   
   if [ $? = "1" ]; then

      echo "$(timestamp) - FAILURE : Unable to delete $CHANGES_STRING.lock" >> $status

   else

      echo "$(timestamp) - SUCCESS : Deleted $CHANGES_STRING.lock" >> $status

   fi
fi
