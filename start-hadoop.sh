#!/bin/bash

# Start Hadoop daemons / Start HDFS daemons
$HADOOP_HOME/sbin/start-dfs.sh

# Start YARN daemons
$HADOOP_HOME/sbin/start-yarn.sh

# Start all Hadoop daemons
# $HADOOP_HOME/sbin/start-all.sh

# Create HDFS directory structure
$HADOOP_HOME/bin/hdfs dfs -mkdir -p /user/root
$HADOOP_HOME/bin/hdfs dfs -mkdir /input
$HADOOP_HOME/bin/hdfs dfs -mkdir /output