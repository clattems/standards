#!/bin/bash
# This script should be run as root to ensure
# all artifacts are collected.

############################################
# ACTION REQUIRED
# Specify remote location to move results to
############################################
REMOTEDIR="/tmp"
HOSTNAME=$(hostname --long)
OUTPUTFILE=$HOSTNAME.txt

############################################

cd $REMOTEDIR

echo "Collecting Data......"

printf "###### Kernel Info\n" >> $OUTPUTFILE
uname -a >> $OUTPUTFILE

printf "######## Getting user and account information\n" >> $OUTPUTFILE
ls -l /etc/passwd >> $OUTPUTFILE
cat /etc/passwd >> $OUTPUTFILE
ls -l /etc/shadow >> $OUTPUTFILE
cat /etc/shadow >> $OUTPUTFILE
ls -l /etc/group >> $OUTPUTFILE
cat /etc/group >> $OUTPUTFILE
ls -l /etc/profile >> $OUTPUTFILE
cat /etc/profile >> $OUTPUTFILE
cat /etc/shells >> $OUTPUTFILE
cat /etc/securetty >> $OUTPUTFILE
who -s /etc/security/failedlogin >> $OUTPUTFILE
cat ~/.login >> $OUTPUTFILE

# sed 's/:.*$//' /etc/passwd |while [[ i ]]; do
# finger $i
# done

for i in $(sed 's/:.*$//' /etc/passwd); do
finger $i >> $OUTPUTFILE
done

last |awk '{print$1}'|sort|uniq >> $OUTPUTFILE

printf "########## End of user info" >> $OUTPUTFILE


printf "##### Access control and system configuration"

umask >> $OUTPUTFILE
cat /etc/aliases >> $OUTPUTFILE

printf "######This replaces the inittab in RHEL 7\n"
systemctl get-default >> $OUTPUTFILE

cat ~/.cshrc >> $OUTPUTFILE
cat ~/.profile >>$OUTPUTFILE
cat /etc/profile >> $OUTPUTFILE

printf "####### System Network Configs ######\n"

cat /etc/issue.net >> $OUTPUTFILE
cat /etc/issue >> $OUTPUTFILE
cat /etc/vsftpd.conf >> $OUTPUTFILE
cat /etc/motd >> $OUTPUTFILE
cat /etc/inet/inetd.conf >> $OUTPUTFILE
cat /etc/xinetd.conf >> $OUTPUTFILE
cat /etc/netgroup >> $OUTPUTFILE
ls -l /etc/services >> $OUTPUTFILE
cat /etc/services >> $OUTPUTFILE

cat /etc/ssh/sshd_config >> $OUTPUTFILE

cat /etc/hosts.equiv >> $OUTPUTFILE
ls -l /etc/hosts.equiv >> $OUTPUTFILE
ls -l /etc/ftpusers >> $OUTPUTFILE
cat /etc/ftpaccess.ctl >> $OUTPUTFILE
cat /etc/xtab >> $OUTPUTFILE
/usr/sbin/rpcinfo -p >> $OUTPUTFILE
xhost >> $OUTPUTFILE
showmount -e >> $OUTPUTFILE


printf "###### Job info"\n >> $OUTPUTFILE
find / -name crontab >> $OUTPUTFILE

printf "##### Directory listings"\n >> $OUTPUTFILE

ls -alLR /bin >> $OUTPUTFILE
ls -alLR /dev >> $OUTPUTFILE
ls -alLR /etc >> $OUTPUTFILE
ls -alLR /home >> $OUTPUTFILE
ls -alLR /sbin >> $OUTPUTFILE
ls -alLR /tmp >> $OUTPUTFILE
ls -alLR /usr >> $OUTPUTFILE
ls -alLR /var >> $OUTPUTFILE

printf "####### Audit loggin configs"\n >> $OUTPUTFILE
cat /etc/rsyslog.conf >> $OUTPUTFILE
cat /var/log/messages >> $OUTPUTFILE
cat /var/log/secure >> $OUTPUTFILE
cat /var/log/spooler >> $OUTPUTFILE
ls -l /var/log >> $OUTPUTFILE


printf "######### Getting installed packages"
rpm -qa --list >> $OUTPUTFILE
