#Ambari setup
JDK_VERSION=jdk1.7.0_51
JDK_DIR=/usr/java/$JDK_VERSION

yum install -y ambari-server
ambari-server setup --java-home=$JDK_DIR < /vagrant/input.txt
ambari-server start
