#!/bin/bash
for i in ` cat serviceinfo | awk '{print $1}'`
    do 
        for j in `cat serviceinfo | grep $i | awk '{print $2}'`
            do docker service scale $i=$j ; sleep 10s 
            done
    done
