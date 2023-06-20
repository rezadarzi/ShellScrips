#!/bin/bash
for i in `docker service ls | grep -v NAME | awk '{print $2}'`
    do 
    for j in `docker service ls | grep -v NAME | grep $i |  awk '{print $4}' | cut -d "/" -f 2`
        do 
        echo $i $j >> serviceinfo
    done
done