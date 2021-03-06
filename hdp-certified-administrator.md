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

cd /var/www/ip-172-31-89-188.ec2.internal/yum
nohup wget http://public-repo-1.hortonworks.com/ambari/centos7/ambari-2.1.0-centos7.tar.gz &
nohup wget http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.3.0.0/HDP-2.3.0.0-centos7-rpm.tar.gz &
nohup wget http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.20/repos/centos7/HDP-UTILS-1.1.0.20-centos7.tar.gz &

nohup tar xzf ambari-2.1.0-centos7.tar.gz &
nohup tar xzf HDP-2.3.0.0-centos7-rpm.tar.gz &
nohup tar xzf HDP-UTILS-1.1.0.20-centos7.tar.gz &

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

### Configuration

* Define and deploy a rack topology script

ssh to Namenode create two files rack_topology.sh, rack_topology.data in /etc/hadoop/conf and edit the core-site.xml file to add the following property to it:

```
<property>
  <name>net.topology.script.file.name</name>
  <value>/etc/hadoop/conf/rack-topology.sh</value>
</property>

# to check run
sudo -u hdfs hadoop dfsadmin -report
```

* Change the configuration of a service using Ambari

* Configure the Capacity Scheduler

To enable the Capacity Scheduler, set the following property in the /etc/hadoop/conf/yarn-site.xml file on the ResourceManager host:

```
<property>
 <name>yarn.resourcemanager.scheduler.class</name>
 <value>org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler</value>
</property>
```

The settings for the Capacity Scheduler are contained in the /etc/hadoop/conf/capacity-scheduler.xml file on the ResourceManager host.

```
yarn rmadmin -refreshQueues
```

* Create a home directory for a user and configure permissions

```
sudo su - hdfs
hadoop fs -ls /user
hadoop fs -mkdir /user/centos
hadoop fs -ls /user
hadoop fs -chown centos:hdfs /user/centos
hadoop fs -ls /user
hadoop fs -put testing /user/centos
 ```

* Configure the include and exclude DataNode files

```
sudo su - hdfs
cd /etc/hadoop/conf
vi dfs.exclude
vi dfs.include
hdfs dfsadmin -refreshNodes
```

### Troubleshooting

* Restart an HDP service

Use Services to monitor and manage selected services running in your Hadoop cluster.

To start or stop all listed services at once, select Actions, then choose Start All or Stop All

* View an application’s log file

```
yarn application -list all
sudo find / -name "*hadoop*examples*.jar"
hadoop jar /usr/hdp/2.3.0.0-2557/hadoop-mapreduce/hadoop-mapreduce-examples.jar randomwriter /user/centos/randomwriter
```
Go to http://hostname:8088 (8042) and look at the web UI

The following environment files define the log location for YARN and MRv2 for the daemons.

yarn-env.sh:export YARN_LOG_DIR=/var/log/hadoop-yarn/$USER

hadoop-env.sh:export HADOOP_LOG_DIR=/var/log/hadoop-mapred/$USER

```
cd /var/log/hadoop-yarn/yarn
ls -ltr

yarn logs -applicationId application_1383601692319_0008
```

Enabling log aggregation in yarn-site.xml

```
<property>
  <name>yarn.log-aggregation-enable</name>
  <value>true</value>
</property>

<property>
  <name>yarn.nodemanager.log-aggregation.roll-monitoring-interval-seconds</name>
  <value>3600</value>
</property>       
```

* Configure and manage alerts

```
cd /var/lib/ambari-server/resources/host_scripts
```

* Troubleshoot a failed job

```
yarn application -list
hadoop queue -list
hadoop queue -showacls

yarn application  -kill  <application_id>
hadoop job -kill-task <task-id>
hadoop job -fail-task <task-id>
hadoop job -list-attempt-ids <job-id> <task-type> <task-state>
```

Look at the job details in the Resource Manager  UI.

Use the UI to navigate to the job attempt.

Look at the log file for the failed attempt.

### High Availability

* Configure NameNode HA

* Configure ResourceManager HA

* Copy data between two clusters using distcp

```
hadoop distcp hdfs://nn1:8020/source hdfs://nn2:8020/destination
hadoop distcp hdfs://nn1:8020/source/a hdfs://nn1:8020/source/b hdfs:// nn2:8020/destination
```

The DistCp -update option is used to copy files from a source that do not exist at the target, or that have different contents. The DistCp -overwrite option overwrites target files even if they exist at the source, or if they have the same contents.

The -update and -overwrite options warrant further discussion, since their handling of source-paths varies from the defaults in a very subtle manner.

```
distcp -update hdfs://nn1:8020/source/first hdfs://nn1:8020/source/second hdfs://nn2:8020/target
```

* Create a snapshot of an HDFS directory

```
hdfs dfsadmin -allowSnapshot /user/centos/snapshotdemo
hadoop fs -createSnapshot /user/centos/snapshotdemo
sudo -u hdfs hdfs lsSnapshottableDir
hdfs snapshotDiff /sourcedir .snapshot/snapshotdir1 .snapshot/snapshotdir2
```

* Recover a snapshot

```
hadoop fs -cp /user/centos/snapshotdemo/.snapshot/snapshotname /user/centos/snapshotdemo
```

* Configure HiveServer2 HA

### Security

* Install and configure Knox

* Install and configure Ranger

* Configure HDFS ACLs

Only one property needs to be specified in the hdfs-site.xml file in order to enable ACLs on HDFS:

```
<property>
 <name>dfs.namenode.acls.enabled</name>
 <value>true</value>
</property>

hdfs dfs -setfacl -m user:hadoop:rw- /file
hdfs dfs -setfacl -x user:hadoop /file
hdfs dfs -setfacl -b /file
hdfs dfs -setfacl -k /dir
hdfs dfs -setfacl --set user::rw-,user:hadoop:rw-,group::r--,other::r-- /file
hdfs dfs -setfacl -R -m user:hadoop:r-x /dir
hdfs dfs -setfacl -m default:user:hadoop:r-x /dir

hdfs dfs -getfacl /file
hdfs dfs -getfacl -R /dir

hadoop fs -ls /user
sudo -u hdfs hadoop fs -mkdir /user/rustem
sudo -u hdfs hadoop fs -chown rustem:rustem /user/rustem
sudo su - rustem
hadoop fs -mkdir /user/rustem/aclsdemo
hadoop fs -ls /user/rustem

```
