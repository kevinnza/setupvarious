# install Java 
echo "Installing Java Open JDK"

sudo apt update -y
sudo apt install openjdk-8-jdk -y


# install Jenkins
echo "Installing Jenkins"

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins


# enabled firewall in case it is not enabled
echo "Enabling the firewall in case it is not enabled"

echo y | sudo ufw enable


# open port 8080 Jenkins
echo "Opening port 8080 on firewall for Jenkins"

sudo ufw allow OpenSSH


# open port for SSH just in case we have just enabled the firewall
echo "Opening port for open SSH just in case we have just enabled the firewall"

sudo ufw allow 8080


# wait for a bit
sleep 5


# show the initial admin password
echo ""
echo ""
echo "Jenkins has been installed - please do the following:"
echo "1. Open a browser tab on your machine and navigate to http://[vps_ip_address]:8080"
echo "2. When prompted for the initial admin password please enter this:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword



