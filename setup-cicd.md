# Setting up Ubuntu 18.04 for CI/CD 

This describes setting up a Jenkins server for CI/CD to build and deploy .NET Core web apis and NativeScript apps.

## Setting up a new Digital Ocean VPS on Windows 10 with SSH
Ignore this section if you already have a VM set up on Digital Ocean or other platform or if you are not using Windows 10.

Make sure the OpenSSH client is installed. If not follow these [instructions](https://pureinfotech.com/install-openssh-client-windows-10/).

If you don't already have an SSH key then before creating the droplet make sure to create a SSH key on your Windows 10 machine by running `ssh-keygen` 

Then in the Digital Ocean droplet creation ui make sure to add the SSH key.
If will be the contents of the .pub file created from the `ssh-keygen` tool. 

Finish creation of the VPS in Digital Ocean.

## SSH into the new VPS using the command line on your OS and add a new user

Access the VPS using ssh:
````
ssh root@[ip address of your VPS] -i [path to your ssh key file]
````

Add a new user:

````
adduser [the user name you want to create]
````

Assign the new user to the sudo group so it has administrative privileges:
````
usermod -aG sudo [the user name you created]
````

Switch to the newly created user:
````
su [the user name you created]
````

Note: If you ever SSH in again rather use this user than root ie `ssh \[youruser\]@[vps ip address]`

## git