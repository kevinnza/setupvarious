# cd to home directory
cd ~



# install curl in case it's not available
sudo apt install curl -y



# install Git
echo "Installing Git"

sudo apt update -y
sudo apt install git -y



# install Docker
echo "Installing Docker"

sudo apt update -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update -y
apt-cache policy docker-ce
sudo apt install docker-ce -y



# add the current user to the docker group so we don't have to be logged on as root user or use sudo to use docker command
# note: we may have to do the same for the jenkins user later on
sudo usermod -aG docker ${USER}



# install Node.js
echo "Installing Node.js"

cd ~
curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs
sudo apt install build-essential



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



