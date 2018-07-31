#!/bin/bash
pscp.pssh -v -l centos -h cluster_hosts.txt -x " -oStrictHostKeyChecking=no" prepareNode.sh /home/centos/prepareNode.sh

pssh -v -t 0 -l centos -h cluster_hosts.txt -x "-t -t -oStrictHostKeyChecking=no" 'chmod u+x /home/centos/prepareNode.sh && /home/centos/prepareNode.sh >> prepareNode.log && sudo reboot'
