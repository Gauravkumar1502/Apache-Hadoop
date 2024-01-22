#!/bin/bash

mkdir -p $HADOOP_HOME/logs

#Start ssh server
/etc/init.d/ssh start

# Format the namenode
$HADOOP_HOME/bin/hdfs namenode -format

# Start Hadoop daemons
# Start HDFS daemons
$HADOOP_HOME/sbin/start-dfs.sh

# Start YARN daemons
$HADOOP_HOME/sbin/start-yarn.sh
# $SPARK_HOME/sbin/start-all.sh


# Create HDFS directory structure
$HADOOP_HOME/bin/hdfs dfs -mkdir -p /user/root
$HADOOP_HOME/bin/hdfs dfs -mkdir /input
$HADOOP_HOME/bin/hdfs dfs -mkdir /output