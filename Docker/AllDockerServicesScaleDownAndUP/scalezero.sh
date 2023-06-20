#!/bin/bash
for i in `docker service ls | grep -v NAME | awk '{print $2}'`
    do docker service scale $i=0
done
