#!/bin/csh -f
set SSH_USER="root"
set SSH_HOST="192.168.1.1"
set DATASET_SRC="source/data@snap1"
set DATASET_DST="dest/data"
set MBUFFER_SPEED="400k"
set TOKEN=`ssh $SSH_USER@$SSH_HOST zfs get -H receive_resume_token $DATASET_DST | awk '{print $3}'`
set COMMAND="zfs send -t $TOKEN | mbuffer -s 128k -m 1G -l /dev/null -q | ssh $SSH_USER@$SSH_HOST 'mbuffer -s 128k -m 1G -s $MBUFFER_SPEED | zfs receive -s $DATASET_DST'"
echo $COMMAND | sh
