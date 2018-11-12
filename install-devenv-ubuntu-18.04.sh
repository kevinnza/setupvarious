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

#curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh
#sudo bash install_nvm.sh

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

#nvm install 8.10.0

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

# install
echo "n\nn" | sudo npm install nativescript -g --unsafe-perm

# uninstall
#sudo npm uninstall nativescript -g --unsafe-perm

# then reinstall - this seems to resolve permission issues
#echo "n\nn" | sudo npm install nativescript -g --unsafe-perm

# native schematics for angular
sudo npm i -g @nativescript/schematics



# Install Visual Studio Code
echo ""
echo "***********************************"
echo "*  Installing Visual Studio Code  *"
echo "***********************************"

sudo apt update -y
sudo apt install software-properties-common apt-transport-https wget -y
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" -y
sudo apt install code -y



# Setup complete
echo ""
echo "**********************************************************************"
echo "*  SETUP COMPLETE!                                                   *"
echo "*                                                                    *"
echo "*  Reboot your machine for all the necessary changes to take effect  *"
echo "*                                                                    *"
echo "**********************************************************************"


