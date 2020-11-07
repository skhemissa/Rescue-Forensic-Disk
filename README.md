# Rescue & Forensics Disk
>Author: Sabri Khemissa sabri.khemissa@gmail.com

> Rescue & Forensics Disk aka R&F Disk, version: 0.9.1

> Validated on: Debian Buster 10.6

This script build a live image based on Debian Linux for addressing three purposes:
- Removing malicious content (especially for operating systems not supported by antivirus vendors) and doing forensics on the hard drive of the machine that run the R&S Disk image;
- Remote access to machine for fast response in case of incident;
- Education for building a live image based on Debian Linux.

## Table of contents

* [Prerequisite and installation](#prerequisite-and-installation)
* [Building the disk image](#building-the-disk-image)
* [Disk image information and usages](#disk-image-information-and-usages)
  * [General information](#general-information)
  * [Mounting a drive to be analyzed](#mounting-a-drive-to-be-analyzed)
  * [Available tools](#available-tools)
* [For education purposes](#for-education-purposes)
  * [Workspace initialization](#workspace-initialization)
  * [Image customization](#image-customization)
* [Sources](#sources)

## Prerequisite and installation
Packages installation:
```
$ sudo su
# apt install sudo ca-certificates curl live-build
```
User that execute the script for building S&D Disk image should sudo with no password.
 ```
 # echo "<USER> ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/<USER>
```
 **TODO:**
 - [ ] Restrict the sudo capabilties to necessary commande
 - [ ] Create a docker/LXC container for easy execution

## Building the Disk image

Run the following command:
```
$ bash 00_create_rescue_disk.sh | tee live.log
```
An iso file
## Disk image information and usages

### General information
Autologin is configured.

The default username and associated password is displayed in the conky window on the desktop.

For changing the keyboard layout,
Click on the flag in the panel and select the layout (configured fr, en, us).
For a new layout, right click on the flag in the panel, "Keyboard settings", "Layout", button "Add", select your layout, then put your layout in the top.

 **TODO:**
 - [ ] Menu customization 

### Available tools
Launchers configured in the panel:
- Xfce terminal;
- Firefox-esr;
- Filezilla for file transfert;
- Keepass2 for secure password storage;
- Abiword for word processing;
- Flameshot for screenshots;
- Clamtk, a front-end for ClamAV (run in sudo): clamav update is forced during the R&F Disk image build;
- Wireshark-gtk for capturing and analyzing packets off the wire (run in sudo);
- Zenmap, a nmap front end (run in sudo);
- Gparted for partition edition (run in sudo).
For forenscis, the Debian metapackage "forensics-full" is installed. The full list of packages is available in the following page https://packages.debian.org/fr/buster/forensics-full.

OpenSSH server is installed for remote access (the ip of the machine is displayed in the conky window on the desktop).

 **TODO:**
 - [ ] Work on additional tools not in standard Debian repositories

#### Mounting a drive to be analyzed
Identify the list of drive :
 ```
 $ sudo fstab -l
```
Mount, **IN READ ONLY**, the drive to analyze:
Generally, the drive to analyse is the bootable device, identified with a "*" in the fstab output.
 ```
 $ sudo mount -o ro -t auto /dev/sd?? /media/
```
## For education purposes
### Workspace initialization
The file "auto/config" contents the configuration of the image loaded with the command "lb config". Please note, that the command "lb config" should be executed for initializing the image creation workplace then executed one more time when all customization tasks are done.

### Image customization
- The directory "config/package-lists/" contents files that lists packages to be installed. Multi files is allowed and in a file multi lines is allowed.
- The directory "config/includes.chroot/" contents file and directory to be added in the filesystem of the image.
- The directoty "config/hooks/live" contents scripts to be executed in the chroot during image creation (configuring a service, creating an user, package compilation, etc.). Multi files is allowed. Numbers in the begining of the file name provides the execution priority. Each file should be "chmod +x".
- The directory "config/includes.binary/isolinux" contents the grub screen customization.
Don't forget to (re)run "lb config" before creating the image.

Creating the image:
 ```
 $ sudo lb build
```
Cleaning the workplace (directories that includes customization files are not deleted):
 ```
 $ sudo lb clean
```

> The script 00_create_rescue_disk.sh automates all actions for initialization and, for customization, it copies all file to the right directories.

## Sources
- [Debian Live Manual](https://live-team.pages.debian.net/live-manual/html/live-manual/index.en.html)
- [lb_config manual](https://manpages.debian.org/buster/live-build/lb_config.1.en.html)
