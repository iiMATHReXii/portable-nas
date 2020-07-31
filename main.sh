echo "$(tput setaf 3)Thank you for downloading the automatic script to configure NAS for SBCs.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
This has been tested with Raspberry Pi 3, 4 Variant SBC(s) running Raspbian OS.
We do not take any responsibility for any productive loss that you concur because of improper configuration of the NAS, Internet downtime, or so forth which is not under our control.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Select any one option from below and press enter to execute:
1. Install & Configure Samba Protocol
2. Change Path Of Samba Protocol
3. Install & Configure SFTP Protocol
4. Configure Wi-Fi For Hidden Hotspots OR Automatic Connection At Startup"
read menu_option
case "$menu_option" in
1)
echo "************************************************"
echo "************************************************"
echo "Downloading required modules"
sudo apt-get install samba samba-common-bin
echo "************************************************"
echo "************************************************"
echo "Configuring Samba file"
echo "[global]
netbios name = Pi
server string = Portable NAS with Pi
workgroup = WORKGROUP

[HOMEPI]
comment = no comment
browsable = yes
writeable = yes
create mask = 0777
directory mask = 0777
public = no
path = /home/pi" | sudo tee /etc/samba/smb.conf
echo "************************************************"
echo "************************************************"
echo "Enter username for samba (use pi as default):"
read username_smb
sudo smbpasswd -a $username_smb
echo "************************************************"
echo "************************************************"
echo "Restarting Samba services"
sudo service smbd restart
echo "Successfully installed and configured Samba"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
;;
2)
echo "************************************************"
echo "************************************************"
echo "Samba Path Selection"
echo "1. Home (Default)
2. External Devices
3. Custom Path"
read input_path
sudo sed -i '$d' /etc/samba/smb.conf
if [ $input_path == 1 ]
then	
echo "path = /home/pi" | sudo tee -a /etc/samba/smb.conf
elif [ $input_path == 2 ]
then	
echo "path = /media/pi" | sudo tee -a /etc/samba/smb.conf
elif [ $input_path == 3 ]
then	
echo "Please enter the new path:"
read new_path
echo "path = $new_path" | sudo tee -a /etc/samba/smb.conf
else
echo "Invalid Input."
fi
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
;;
3)
echo "**************************************"
echo "**************************************"
sudo apt install openssh-server openssh-sftp-server
echo "************************************************"
echo "************************************************"
echo "OpenSSH and SFTP server successfully installed"
echo "Restarting SSH services"
sudo systemctl restart ssh
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
;;
4)
echo "**************************************"
echo "**************************************"
echo "Enter the SSID for the Wi-Fi:"
read ssid
echo "Enter the password for the Wi-Fi:"
read passwd_wifi
echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=GB

network={
        ssid=\"$ssid\"
        scan_ssid=1
        psk=\"$passwd_wifi\"
        key_mgmt=WPA-PSK
}" | sudo tee sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
;;
*)
echo "Unavailable Option."
;;
esac
