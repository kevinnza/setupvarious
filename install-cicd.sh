# cd to home directory
cd ~



# install curl in case it's not available
sudo apt install curl -y



# install Git
echo ""
echo "********************"
echo "*  Installing Git  *"
echo "********************"
echo ""

sudo apt update -y
sudo apt install git -y



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



# add the current user to the docker group so we don't have to be logged on as root user or use sudo to use docker command
# note: we may have to do the same for the jenkins user later on
sudo usermod -aG docker ${USER}



# install Node.js
echo ""
echo "************************"
echo "*  Installing Node.js  *"
echo "************************"
echo ""

cd ~
curl -sL https://deb.nodesource.com//setup_8.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs -y
sudo apt install build-essential -y



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



# install Java (Open JDK)
echo ""
echo "******************************"
echo "*  Installing Java Open JDK  *"
echo "******************************"
echo ""

sudo apt update -y
sudo apt install openjdk-8-jdk -y



# install Android SDK
echo ""
echo "******************************"
echo "*  Installing Android SDK    *"
echo "******************************"
echo ""

# NOTE: if the zip link doesn't exist anymore then
#       - Go to https://developer.android.com/studio/#downloads 
#       - Find the "Command Line Tools only" section
#       - Locate the SDK tools package for Linux and download the zip file.
#       - Goto your browser's download history and locate the link from there
#       - replace the value of ANDROID_SDK_DOWNLOAD_URI with the link you found
#       - replace the value of ANDROID_SDK_ZIP_FILE with the name of the zip file you found
ANDROID_SDK_DOWNLOAD_URI="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
ANDROID_SDK_ZIP_FILE="sdk-tools-linux-4333796.zip"
wget $ANDROID_SDK_DOWNLOAD_URI
mkdir $HOME/Android && mkdir $HOME/Android/Sdk
sudo apt install unzip -y
unzip $ANDROID_SDK_ZIP_FILE -d $HOME/Android/Sdk
# Set ANDROID_HOME system environment variables by creating a new .sh file in /etc/profile.d:
sudo bash -c "echo -e \"export ANDROID_HOME=$HOME/Android/Sdk\nexport PATH=$PATH:$HOME/Android/Sdk/tools:$HOME/Android/Sdk/platform-tools \" > /etc/profile.d/android-sdk-path.sh"
# export the android variables for the rest of this session as they wouldn't take effect unless we log out and back in
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$HOME/Android/Sdk/tools:$HOME/Android/Sdk/platform-tools
# download the Android sdks required for NativeScript
echo y | sudo $HOME/Android/Sdk/tools/bin/sdkmanager "tools" "emulator" "platform-tools" "platforms;android-25" "build-tools;27.0.3" "extras;android;m2repository" "extras;google;m2repository"



# set up additional stuff for Android/Nativescript to work
echo ""
echo "***************************************************"
echo "*  Adding support for Android/Nativescript stuff  *"
echo "***************************************************"
echo ""

sudo dpkg --add-architecture i386
sudo apt-get update -y
sudo apt-get install lib32z1 lib32ncurses5 libbz2-1.0:i386 libstdc++6:i386 -y
sudo apt-get install g++ -y



# Install Angular CLI
echo ""
echo "****************************"
echo "*  Installing Angular CLI  *"
echo "****************************"
echo ""
sudo npm install -g @angular/cli



# Install Nativescript
echo ""
echo "*****************************"
echo "*  Installing Nativescript  *"
echo "*****************************"
echo ""

# install, then uninstall and then reinstall - this seems to be the only way to sort out weird permission issues when the Nativescript cli runs
# TODO: need to look into this one again
echo "n\nn" | sudo npm install nativescript -g --unsafe-perm

# native schematics for angular
sudo npm i -g @nativescript/schematics



# install Jenkins
echo ""
echo "************************"
echo "*  Installing Jenkins  *"
echo "************************"
echo ""

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins



# Set up firewall
echo ""
echo "*************************"
echo "*  Setting up firewall  *"
echo "*************************"
echo ""

# enabled firewall in case it is not enabled
echo "Enabling the firewall in case it is not enabled"
echo y | sudo ufw enable

# open port 8080 Jenkins
echo "Opening port 8080 on firewall for Jenkins"
sudo ufw allow OpenSSH

# open port for SSH just in case we have just enabled the firewall
echo "Opening port for open SSH just in case we have just enabled the firewall"
sudo ufw allow 8080



# wait for a bit in case Jenkins is stil busy setting up admin password
echo ""
echo "********************************************************************"
echo "*  Almost done, just waiting for a bit to let changes take effect  *"
echo "********************************************************************"
echo ""
sleep 5



# show the initial admin password
echo ""
echo "****************************************************************************************"
echo "*  SETUP COMPLETE"
echo "*"
echo "*  Jenkins has been installed - please do the following:"
echo "*  1. Open a browser tab on your machine and navigate to http://[vps_ip_address]:8080"
echo "*  2. When prompted for the initial admin password please enter this:"
echo "*  " && sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo "*"
echo "***************************************************************************************"


