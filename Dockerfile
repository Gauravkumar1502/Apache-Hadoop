# Use Ubuntu as the base image
FROM ubuntu:latest

# Update the system and install necessary packages such as wget, tar, ssh, rsync, openjdk-8-jdk, vim, pdsh
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    ssh \
    rsync \
    openjdk-8-jdk \
    vim \
    pdsh \
    net-tools

# Download hadoop-3.3.6.tar.gz and extract it to /usr/local/hadoop
RUN wget https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz && \
    tar -xzf hadoop-3.3.6.tar.gz -C /usr/local/ && \
    mv /usr/local/hadoop-3.3.6 /usr/local/hadoop && \
    rm hadoop-3.3.6.tar.gz

# Configure SSH
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Set HADOOP_HOME
ENV HADOOP_HOME=/usr/local/hadoop

# Set HADOOP_CONF_DIR
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

# Srt HADOOP_LOG_DIR
ENV HADOOP_LOG_DIR=$HADOOP_HOME/logs

# Set PATH
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# Set HADOOP_MAPRED_HOME
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME

# Set HADOOP_COMMON_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME

# Set HADOOP_HDFS_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME

# Set YARN_HOME
ENV YARN_HOME=$HADOOP_HOME

# Define HDFS_NAMENODE_USER, HDFS_DATANODE_USER, and HDFS_SECONDARYNAMENODE_USER
ENV HDFS_NAMENODE_USER=root
ENV HDFS_DATANODE_USER=root
ENV HDFS_SECONDARYNAMENODE_USER=root

# Define YARN_RESOURCEMANAGER_USER, YARN_NODEMANAGER_USER
ENV YARN_RESOURCEMANAGER_USER=root
ENV YARN_NODEMANAGER_USER=root


# Copy Hadoop Configuration Files
COPY core-site.xml $HADOOP_CONF_DIR/core-site.xml
COPY hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml
COPY mapred-site.xml $HADOOP_CONF_DIR/mapred-site.xml
COPY yarn-site.xml $HADOOP_CONF_DIR/yarn-site.xml

# Copy hadoop-env.sh file
COPY hadoop-env.sh $HADOOP_CONF_DIR/hadoop-env.sh

# Copy start-hadoop.sh file
COPY start-hadoop.sh /start-hadoop.sh

# Expose ports
EXPOSE 9870 8088 9000

# docker build -t hadoop-pseudo-distributed .
# docker run -it --name hadoop-pseudo-distributed -p 9870:9870 -p 8088:8088 -p 9000:9000 hadoop-pseudo-distributed  