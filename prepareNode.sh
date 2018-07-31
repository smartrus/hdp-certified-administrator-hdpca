#!/bin/bash
umask 022
echo "umask 022" ? ~/.bashrc

sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

#sudo chkconfig ntpd on
#sudo ntpd -q
#sudo service ntpd start

#sudo service iptables stop
#sudo chkconfig iptables off
#sudo service ip6tables stop
#sudo chkconfig ip6tables off
echo 0 | sudo tee /proc/sys/vm/swappiness
echo vm.swappiness = 0 | sudo tee -a /etc/sysctl.conf

sudo -c 'echo hdfs - nofile 32768 >> /etc/security/limits.conf'
sudo -c 'echo mapred - nofile 32768 >> /etc/security/limits.conf'
sudo -c 'echo hbase - nofile 32768 >> /etc/security/limits.conf'
sudo -c 'echo hdfs - nproc 32768 >> /etc/security/limits.conf'
sudo -c 'echo mapred - nproc 32768 >> /etc/security/limits.conf'
sudo -c 'echo hbase - nproc 32768 >> /etc/security/limits.conf'
