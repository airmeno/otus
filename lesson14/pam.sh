#!/usr/bin/env bash

GROUP=$(groups $PAM_USER | grep -c admin)

if [[ $GROUP -eq 1 ]]; then 
   exit 0
  elif [[ $(date +%u) -gt 5 ]]; then
    exit 1
    else  
      exit 0 
    fi
fi