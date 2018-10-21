# install Java 
echo Installing Java (Open JDK)

sudo apt update && sudo apt install openjdk-8-jdk

# install Jenkins
echo Installing Jenkins

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
&&
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
&&
sudo -y apt update
&&
sudo -y apt install jenkins
&&
sudo systemctl start jenkins

# enabled firewall in case it is not enabled
echo Enabling the firewall in case it is not enabled

sudo ufw enable

# open port 8080 Jenkins
echo Opening port 8080 on firewall for Jenkins

sudo ufw allow 8080


# get the repository key
# wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -

