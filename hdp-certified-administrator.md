# Hortonworks Data Platform Certified Administrator exam study guide

> The outline is copied from [Hortonworks website](https://hortonworks.com/services/training/certification/).

Hortonworks has redesigned its certification program to create an industry-recognized certification where
individuals prove their Hadoop knowledge by performing actual hands-on tasks on a Hortonworks Data
Platform (HDP) cluster, as opposed to answering multiple-choice questions. The HDP Certified Administrator
(HDPCA) exam is designed for Hadoop system administrators and operators responsible for installing,
configuring and supporting an HPD cluster. The cost of the exam is $250 USD per attempt.

## Purpose of the exam

The purpose of this exam is to provide organizations that use Hadoop with a means of identifying suitably
qualified staff to install, configure, secure and troubleshoot a Hortonworks Data Platform cluster using Apache
Ambari.

## Exam description

The exam has five main categories of tasks that involve:

* Installation
* Configuration
* Troubleshooting
* High Availability
* Security

The exam is based on the Hortonworks Data Platform 2.3 installed and managed with Ambari 2.1.

## Prerequisites

Candidates for the HPDCA exam should be able to perform each of the objectives in the list on our website at:

[Exam objectives](https://hortonworks.com/services/training/certification/exam-objectives/#hdpca)

Candidates are also encouraged to attempt the practice exam:

[Practice exam](https://2xbbhjxc6wk3v21p62t8n4d4-wpengine.netdna-ssl.com/wp-content/uploads/2015/04/HDPCA-PracticeExamGuide.pdf)

## Exam objectives

### Installation

* Configure a local HDP repository

```
yum install httpd
vi /etc/httpd/conf/httpd.conf
  ServerName ip-172-31-89-188.ec2.internal:80

  NameVirtualHost ip-172-31-89-188.ec2.internal:80

  <VirtualHost ip-172-31-89-188.ec2.internal:80>
          ServerAdmin webmaster@ip-172-31-89-188.ec2.internal
          DocumentRoot /var/www/ip-172-31-89-188.ec2.internal
          ServerName ip-172-31-89-188.ec2.internal
          ErrorLog logs/ip-172-31-89-188.ec2.internal-error_log
          CustomLog logs/ip-172-31-89-188.ec2.internal-access_log common
  </VirtualHost>

mkdir -p /var/www/ip-172-31-89-188.ec2.internal/yum
service httpd start
systemctl enable httpd

yum install wget -y

wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.1.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
wget -nv http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.3.0.0/hdp.repo -O /etc/yum.repos.d/hdp.repo
wget -nv http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/centos7 -O /etc/yum.repos.d/hdp-utils.repo

cd /var/www/ip-172-31-89-188.ec2.internal/yum
nohup wget http://public-repo-1.hortonworks.com/ambari/centos7/ambari-2.1.0-centos7.tar.gz &
nohup wget http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.3.0.0/HDP-2.3.0.0-centos7-rpm.tar.gz &
nohup wget http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/centos7/HDP-UTILS-1.1.0.20-centos7.tar.gz &

nohup tar xzf ambari-2.1.0-centos7.tar.gz
nohup tar xzf HDP-2.3.0.0-centos7-rpm.tar.gz
nohup tar xzf HDP-UTILS-1.1.0.20-centos7.tar.gz

# Change .repo urls to your localhost url

# Copy /etc/hosts and repo files to each cluster instance

scp /etc/yum.repos.d/ambari.repo ip-172-31-87-208.ec2.internal:~
scp /etc/yum.repos.d/hdp.repo ip-172-31-87-208.ec2.internal:~
ssh -tt centos@ip-172-31-87-208.ec2.internal "sudo mv ~/*.repo /etc/yum.repos.d/"

scp /etc/yum.repos.d/ambari.repo ip-172-31-89-46.ec2.internal:~
scp /etc/yum.repos.d/hdp.repo ip-172-31-89-46.ec2.internal:~
ssh -tt centos@ip-172-31-89-46.ec2.internal "sudo mv ~/*.repo /etc/yum.repos.d/"

scp /etc/yum.repos.d/ambari.repo ip-172-31-93-133.ec2.internal:~
scp /etc/yum.repos.d/hdp.repo ip-172-31-93-133.ec2.internal:~
ssh -tt centos@ip-172-31-93-133.ec2.internal "sudo mv ~/*.repo /etc/yum.repos.d/"

scp /etc/yum.repos.d/ambari.repo ip-172-31-93-34.ec2.internal:~
scp /etc/yum.repos.d/hdp.repo ip-172-31-93-34.ec2.internal:~
ssh -tt centos@ip-172-31-93-34.ec2.internal "sudo mv ~/*.repo /etc/yum.repos.d/"

scp /etc/yum.repos.d/ambari.repo ip-172-31-84-208.ec2.internal:~
scp /etc/yum.repos.d/hdp.repo ip-172-31-84-208.ec2.internal:~
ssh -tt centos@ip-172-31-84-208.ec2.internal "sudo mv ~/*.repo /etc/yum.repos.d/"

```


Configuring remote HDP repository:

```
wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.1.0/ambari.repo -O /etc/yum.repos.d/ambari.repo

wget -nv http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.3.0.0/hdp.repo -O /etc/yum.repos.d/hdp.repo

yum-config-manager --add-repo http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/centos7
```

* Install ambari-server and ambari-agent

```
yum install ambari-server

vi /etc/python/cert-verification.cfg
[https]
verify=disable

ambari-server setup
ambari-server start
```

```
yum install ambari-agent

vi /etc/ambari-agent/conf/ambari-agent.ini
[server]
hostname=<your.ambari.server.hostname>
url_port=8440
secured_url_port=8441

vi /etc/python/cert-verification.cfg
[https]
verify=disable

ambari-agent start
```

* Install HDP using the Ambari install wizard



* Add a new node to an existing cluster

* Decommission a node

* Add an HDP service to a cluster using Ambari
