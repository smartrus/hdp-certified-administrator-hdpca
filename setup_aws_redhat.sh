#!/bin/bash
pscp.pssh -v -l centos -h cluster-hosts.txt -x " -oStrictHostKeyChecking=no" 'chmod u+x /home/centos/prepareNode.sh && /home/centos/prepareNode.sh >> prepareNode.log && sudo reboot'
