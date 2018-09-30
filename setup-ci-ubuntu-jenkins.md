# Setting up Ubuntu 18.04 for CI 

Here we describe how to set up Ubuntu 18.04 for CI using Jenkins

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

We'll install Node.js using `nvm` instead of using `apt`. This will ensure we can install the versionf of Node.js that we need.
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


## Angular CLI

Install the Angular cli

    $ npm install -g @angular/cli

## Typescript?


## .NET Core


````
$ wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
$ sudo dpkg -i packages-microsoft-prod.deb
$ sudo apt-get install apt-transport-https
$ sudo apt-get update
$ sudo apt-get install dotnet-sdk-2.1
````

Note: These instructions are from the Microsoft [site](https://www.microsoft.com/net/download/linux-package-manager/ubuntu18-04/sdk-current). If these don't work due to them changing it then please refer to the site and locate the instruction for Ubuntu 18.04

## Java



## Android SDK



## NativeScript

To use [NativeScript](https://www.nativescript.org) for native mobile development.

Run `tns doctor` to see if everything is correctly installed for NativeScript

## Jenkins

