#!/bin/env bash

WORD=$1
LOG=$2
DATE=`date`

if grep $WORD $LOG &> /dev/null
then
   logger "$DATE: If it ain’t broke, don’t fix it!"
else
   exit 0
fi
