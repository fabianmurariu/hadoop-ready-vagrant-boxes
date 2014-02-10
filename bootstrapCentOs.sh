#!/usr/bin/env bash
#Configure the Romanian Ubuntu 12.04 repositories
#cp /vagrant/sources.list /etc/apt/sources.list
#curl -s http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh/archive.key | apt-key add -
#apt-get update

#configure the JDK to 1.7 from Oracle
JDK_INSTALL=~/jdk_install
JDK_VERSION=jdk1.7.0_51
JDK_DIR=/usr/java/$JDK_VERSION

rm -Rf $JDK_INSTALL
mkdir $JDK_INSTALL
tar -xvf /vagrant/jdk-7u51-linux-x64.tar.gz -C $JDK_INSTALL
mkdir -p /usr/java
mv $JDK_INSTALL/$JDK_VERSION $JDK_DIR

for file in "$JDK_DIR"/bin/*
do
  filename=$(basename "$file")
  alternatives --install "/usr/bin/"$filename $filename $file 20000
  chmod 0755 "/usr/bin/"$filename
done

chown -R root:root $JDK_DIR
rm -Rf $JDK_INSTALL

echo "export JAVA_HOME="$JDK_DIR >> /root/.bashrc
echo "export JAVA_HOME="$JDK_DIR >> /home/vagrant/.bashrc

cat /vagrant/add_hosts >> /etc/hosts

cp /vagrant/ambari.repo /etc/yum.repos.d

# copy the ssh key for root and vagrant
cp -R /vagrant/root/.ssh /root/
cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

cp -R /vagrant/vagrant/.ssh /home/vagrant/
cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/authorized_keys

#prepare stuff for Ambari
echo "configure NTP"
chkconfig ntpd on
ntpdate pool.ntp.org
service ntpd start
cat /vagrant/add_ntp >> /etc/ntp.conf

echo "remove lzo and update openssl and stop iptables"
#Fix packages as per ambari
cp -R /vagrant/yum /var/cache/
yum update openssl -y
yum remove lzo -y
service iptables stop

