Security & Rescue Disk
aka S&D Disk

Author: Sabri Khemissa sabri.khemissa[at]gmail.com

Version: 0.9.1

S&D Disk should be used for:
- Removing malicious content (especialy on machine which are not supported by antivirus vendors) and doing forensics on the hard drive of the machine that run the live image;
- Remote access to machine for fast response in case of incident;

Mounting a hard drive to be analyzing:
Identify the list of devices :
 $ sudo fstab -l

Mount, IN READ ONLY, the hard drive to analyze:
Generally, the hard drive to analyse is the bootable device, identified with a "*" in the fstab output.
 $ sudo mount -o ro -t auto /dev/sd?? /media/

S&D Disk image information and usages:

The default username and associated password is displayed in the conky window on the desktop.

For changing the keyboard layout,
Click on the flag in the panel and select the layout (configured fr, en, us).
For a new layout, right click on the flag in the panel, "Keyboard settings", "Layout", button "Add", select your layout, then put your layout in the top.

Available tools:
Launcher configured in the panel:
- Xfce terminal;
- Firefox-esr;
- Filezilla for file transfert;
- Keepass2 for secure password storage;
- Abiword for word processing;
- Flameshot for screenshots;
- Clamtk, a front-end for ClamAV (run in sudo): clamav update is forced during the S&R Disk build;  
- Wireshark-gtk for capturing and analyzing packets off the wire (run in sudo);
- Zenmap, a nmap front end (run in sudo);
- Gparted for partition edition (run in sudo).

For forenscis, the Debian metapackage "forensics-full" is installed. The full list of packages is available in the following page https://packages.debian.org/fr/buster/forensics-full.

OpenSSH server is installed for remote access (the ip of the machine is displayed in the conky window on the desktop).
