# portable-nas script
A menu driven single file light-weight script written to automate the process
of installing and configuring various modules to set-up NAS in your own SBCs.

Requirements:
SBCs such as Raspberry Pi, Orange Pi, etc
Internet connection

Flow of action:
1. Open terminal
2. Clone the repository to the local storage of the SBC
3. Modify the permissions to grant execution with the command "chmod 777 main.sh"
4. Execute the script with the command "./main.sh"
5. Select one of the options and wait for the process to finish

Available options:
1. Download, install and configure Samba protocol
2. Change shared directory path of Samba
3. Download, install and configure SFTP protocol
4. Add Wi-Fi configuration for hidden hostspots or other to connect automatically at startup

Tested on Raspbeery Pi 3B, Raspbian OS
