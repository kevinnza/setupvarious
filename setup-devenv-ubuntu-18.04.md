# Setting up your development environment on Ubuntu 18.04

This will install the necessary components for development on Ubuntu 18.04

## Install via script
Make sure you are logged in as the user you created 

Change current directory to the home directory:
````
cd ~
````

Get the script file:
````
wget https://raw.githubusercontent.com/kevinnza/setupvarious/master/install-devenv-ubuntu-18.04.sh
````

Execute the script file:
````
sudo bash install-devenv-ubuntu-18.04.sh
````

Once done, REBOOT the OS for changes to take effect properly

Uninstall and then reinstall NativeScript to fix permission issues:
````
sudo npm uninstall nativescript -g --unsafe-perm

sudo npm install nativescript -g --unsafe-perm
````

## Running in a VirtualBox virtual machine

If you are running your dev environment in VirtualBox then ensure that the VirtualBox Extension Pack and VirtualBox Guest Additions is installed.


