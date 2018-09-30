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

It will install the software into a subdirectory of your home directory at ~/.nvm. It will also add the necessary lines to your ~/.profile file to use the file.

To gain access to the nvm functionality, you'll need to either log out and log back in again or source the ~/.profile file so that your current session knows about the changes:

    source ~/.profile

With nvm installed, you can install isolated Node.js versions. For information about the versions of Node.js that are available, type:

    nvm ls-remote

Output
...
         v8.11.1   (Latest LTS: Carbon)
         v9.0.0
         v9.1.0
         v9.2.0
         v9.2.1
         v9.3.0
         v9.4.0
         v9.5.0
         v9.6.0
         v9.6.1
         v9.7.0
         v9.7.1
         v9.8.0
         v9.9.0
        v9.10.0
        v9.10.1
        v9.11.0
        v9.11.1
        v10.0.0  

As you can see, the current LTS version at the time of this writing is v8.11.1. You can install that by typing:

## Angular CLI



## Typescript?


## .NET Core


## Java



## Android SDK



## NativeScript

To use [NativeScript](https://www.nativescript.org) for native mobile development.

Run `tns doctor` to see if everything is correctly installed for NativeScript

## Jenkins

