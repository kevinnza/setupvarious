# Nativescript

This describes setting up various software components for Nativescript development

## Visual Studio Code

Install the NativeScript extension from Telerik

If you encounter errors like angular, etc not found you may need to run `npm install` in the folder containing your NativeScript if you have just got the project from source control - typically the node modules won't be checked into source control and you need to install them using `npm install`.

If you see error like "" then goto File => Preferences => Settings. You should see an elipsis that allows you to edit settings.json.
Add this: 
"javascript.implicitProjectConfig.experimentalDecorators": true

If you want to debug a code share app using webpack then make sure to edit the launch.json file by:
 - Click View => Debug
 - Click the gear icon to display launch.json
 - Locate the Attach on Android and Launch on Android items
 - Add this property to each:
   "tnsArgs":\["--bundle"\]
   

## Code Sharing between Mobile and Web Applications

To gain the maximum benefit of code reuse, set up a code sharing project which will cover web and mobile uis.

See these links for more info:
https://docs.nativescript.org/code-sharing/intro
https://docs.nativescript.org/code-sharing/creating-a-new-project


## Windows

### 

### Check environment set up

Run `tns doctor` to see if your environment is set up correctly for NativeScript and it's dependencies.

### Issues you may find

During building if you see "Duplicate..." errors then make sure you are building using the --bundle option. If it's a code share project (web and mobile) then build with the --bundle




