# cd to home directory
cd ~



# install curl in case it's not available
sudo apt install curl -y



# install Docker
echo ""
echo "***********************"
echo "*  Installing Docker  *"
echo "***********************"
echo ""

sudo apt update -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update -y
apt-cache policy docker-ce
sudo apt install docker-ce -y

# wait for a few moments in case docker group is not created yet
sleep 5

# add the current user to the docker group so we don't have to be logged on as root user or use sudo to use docker command
# note: we may have to do the same for the jenkins user later on
sudo usermod -aG docker ${USER}



# install .NET Core
echo ""
echo "******************************"
echo "*  Installing .NET Core 2.1  *"
echo "******************************"
echo ""

wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get install apt-transport-https -y
sudo apt-get update -y
sudo apt-get install dotnet-sdk-2.1 -y



# install Nginx
echo ""
echo "**********************"
echo "*  Setting up Nginx  *"
echo "**********************"
echo ""

sudo apt update -y
sudo apt install nginx -y



# Set up firewall
echo ""
echo "*************************"
echo "*  Setting up firewall  *"
echo "*************************"
echo ""

# enabled firewall in case it is not enabled
echo "Enabling the firewall in case it is not enabled"
echo y | sudo ufw enable

# open ports
echo "Opening ports"
sudo ufw allow OpenSSH
sudo ufw allow 80
sudo ufw allow 443



echo ""
echo "**********************************"
echo "*  SETUP COMPLETE! Please reboot *"
echo "**********************************"


