This is a `userbox` application which enables the user to add new users and also gives provision to select and delete a user.

Tested with Qt 5.12.1, 5.12.4 and 5.12.5  

## Supported Platforms  
* Windows 7 or later  
* macOS 10.13 or later  
eventhough it was not tested on linux distros it shouldn't be a problem to run the app on any latest linux distors.

## Building
NOTE: you should point to the Qt5 include directories, which you can do by exporting the `Qt5_DIR` variable.
Ex: Qt5_DIR="/Users/bob/Qt/5.12.7/clang_64/lib/cmake/Qt5"

1. makdir build
2. cd build
3. cmake ../.
4. make all
5. execute generated application binary

## Features of the app  
1. Add a random API user
2. Select a user
3. Delete a selected user
4. View the selected users details in screen2
5. Get the real time count of the user

## Limitations of the app  
1. You can not save the users and use them in next session, you have to start over again.
