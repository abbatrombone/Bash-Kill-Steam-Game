#!/bin/bash

echo "getting steam job id"
jobid=$( (pidof steam) )

if [[ -n "$jobid" ]]; then
echo "$jobid"
jobname=$( (ps -p "$jobid" -o cmd) )
jobcommandname=$( (ps -p "$jobid" -o comm) )
echo "job name: "$jobname" "
echo "job command name: "$jobcommandname" "
echo "killing steam"
kill $jobid
echo "steam is dead"
else
echo "steam was not running"
fi






