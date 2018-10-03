# Setting up Ubuntu 18.04 for CI 

Here we describe how to set up Ubuntu 18.04 for CI using Jenkins

Note:
If some of the apt install commands which prompt with a Y/N automatically abort then add the -y flag to force a Yes

## git

````
$ sudo apt update
$ sudo apt install git
````
To check if git installed correctly run `git --version`

Optional: At this point, you can choose to set up your personal information for git.
````
$ git config --global user.name "Your Name Here"
$ git config --global user.email "youremail@address.here"
````

## Node.js

We'll install Node.js using PPA from NodeSource. We'll use this to install a more precise version of node instead of using the default Ubuntu PPAs. Some modules like Angular CLI require a specific version or later and the default version from Ubuntu apt install may be older that what's needed. 

````
$ cd ~
$ curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
$ sudo bash nodesource_setup.sh
$ sudo apt install nodejs
$ sudo apt install build-essential


IGNORE  $ cd ~
IGNORE  $ sudo apt-get install curl software-properties-common
IGNORE  $ curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
IGNORE  $ sudo apt-get install -y nodejs
IGNORE  $ sudo apt install build-essential
````

Note: If curl is not installed then install it with `$ sudo apt install curl`


## Node.js (Ignore)

We'll install Node.js using `nvm` instead of using `apt`. This will ensure we can install the version of Node.js that we need.
Sometimes installing an older version will not work well with other components required for builds, etc. eg. Angular CLI.

Download the nvm installation script from the project's GitHub page.

````shell
$ curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh
````

Note: If curl is not installed then install it with `$ sudo apt install curl`

Install the nvm setup script:
````
$ bash install_nvm.sh
````

To access nvm functionality, either log out and log back in again or source the ~/.profile file so that your current session knows about the changes:
    
    $ source ~/.profile

With nvm installed, you can install isolated Node.js versions. For information about the versions of Node.js that are available, run:

    $ nvm ls-remote

A list of node version will display. Make a note of the current LTS version eg. 8.12.0

Install that version by running `$ nvm install [version]` eg: `$ nvm install 8.12.0`


## NativeScript

To use [NativeScript](https://www.nativescript.org) for native mobile development.

Note: Adapted from set up instructions for Linux at [NativeScript](https://docs.nativescript.org/start/ns-setup-linux)

Install nativescript
````
$ sudo npm install nativescript -g --unsafe-perm
````
Note: At time of writing the NativeScript docs indicate using `sudo npm` for the install but after research and because we are using nvm as a node version manager, we should use it without sudo. This is more secure.

Close terminal and open again and then to check if everything is set up correctly
````
$ tns doctor
````

If there's EACCES permission errors then try uninstalling and reinstalling
Uninstall is `$ sudo npm uninstall -g nativescript`


## Angular CLI

Install the Angular cli

    $ sudo npm install -g @angular/cli
    
Note: might have to use sudo if permission errors    


## Docker



## Java

Install JDK 8. We install this version as NativeScript supports this version at time of writing.
Adapted [from](https://docs.nativescript.org/start/ns-setup-linux) to set up for linux

````
$ sudo apt-get install software-properties-common
$ sudo add-apt-repository ppa:webupd8team/java
$ sudo apt-get update
$ sudo apt-get install oracle-java8-installer
````

Log out and back in for the JAVA_HOME environment variable to take effect. The install should have set this variable.


## Android SDK

Go to https://developer.android.com/studio/#downloads and go to the "Command Line Tools only" section and locate the SDK tools package for Linux and download the file. It should be a zip file.

Make a folder called Android/Sdk in the home directory
    
    $ mkdir $HOME/Android && mkdir $HOME/Android/Sdk

Then unzip it into the Android/Sdk folder:

    $ unzip [filename].zip -d $HOME/Android/Sdk

Set `ANDROID_HOME` system environment variables by creating a new .sh file in /etc/profile.d:

See: https://help.ubuntu.com/community/EnvironmentVariables (System Wide Environment Variables)
````
    $ sudo bash -c "echo -e \"export ANDROID_HOME=$HOME/Android/Sdk\nexport PATH=$PATH:$HOME/Android/Sdk/tools:$HOME/Android/Sdk/platform-tools \" > /etc/profile.d/android-sdk-path.sh"
````    

Log out and log back in for the environment variables to take effect

Download android sdks required for NativeScript:

    $ sudo $ANDROID_HOME/tools/bin/sdkmanager "tools" "emulator" "platform-tools" "platforms;android-25" "build-tools;27.0.3" "extras;android;m2repository" "extras;google;m2repository"



## Additional setup steps

These are required to set up for NativeScript development - there may be some overlap with other steps
Adapted [from](https://docs.nativescript.org/start/ns-setup-linux) to set up for linux

````
$ sudo apt-get install lib32z1 lib32ncurses5 lib32bz2-1.0 libstdc++6:i386
````

If you encounter an error showing "Unable to locate package lib32bz2-1.0" then use
````
$ sudo apt-get install lib32z1 lib32ncurses5 libbz2-1.0:i386 libstdc++6:i386
````

If you STILL have errors then try running this and repeat the step again
````
sudo dpkg --add-architecture i386
sudo apt-get update
````

Install g++ compiler
````
$ sudo apt-get install g++
````


## NativeScript Test

````
$ tns doctor
````

If there's still issues about issues with the Android SDK then install Open JDK as well:
````
sudo apt-get install openjdk-8-jre
````


## .NET Core

````
$ wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
$ sudo dpkg -i packages-microsoft-prod.deb
$ sudo apt-get install apt-transport-https
$ sudo apt-get update
$ sudo apt-get install dotnet-sdk-2.1
````

Note: These instructions are from the Microsoft [site](https://www.microsoft.com/net/download/linux-package-manager/ubuntu18-04/sdk-current). If these don't work due to them changing it then please refer to the site and locate the instruction for Ubuntu 18.04



## Jenkins

See: https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-18-04

Install Jenkins
````
$ wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
$ sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
$ sudo apt update
$ sudo apt install jenkins
````

Start Jenkins
````
$ sudo systemctl start jenkins
````

Open Firewall
````
$ sudo ufw allow 8080
$ sudo ufw status
````

Note: If firewall not active then
````
$ sudo ufw allow OpenSSH
$ sudo ufw enable
````

Display the initial admin password. You will need this for the next step
````
$ sudo cat /var/lib/jenkins/secrets/initialAdminPassword
````

Use Jenkins web interface by opening a webbrowser in Ubuntu and navigate to http://localhost:8080:

1. In the Unlock Jenkins screen enter the password from the previous step

2. Click on "Install suggested plugins"

3. Enter the first admin user and follow next steps, then it's done

