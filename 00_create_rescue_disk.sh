#!/bin/sh
#bash create_rescue_disk.sh | tee live.log

# delete existing image
sudo rm -f *.iso

# prepare env variables
VERSION=0.9.1
DIR=$(pwd)
WORKDIR=$DIR/live_image
BUILDDIR=$DIR/build_files
ISONAME=rescue-disk-v$VERSION-$(date +%Y.%m.%d).iso
OSQUERYURL=https://pkg.osquery.io/deb/osquery_4.5.1_1.linux.amd64.deb

# remove existing workspace
sudo rm -rf $WORKDIR

# create a new workspace
mkdir $WORKDIR
cd $WORKDIR

# initialize the new workspace
lb config 

# copy live-build parameters
cp $BUILDDIR/auto/config $WORKDIR/auto

# copy the list of packages to be installed
cp $BUILDDIR/config/package-lists/rescue.list.chroot $WORKDIR/config/package-lists/

# copy the hook for creating the user with sudo privileges
cp $BUILDDIR/config/hooks/live/0901-create-user.chroot $WORKDIR/config/hooks/live/

# copy the hook for activeting lightdm autologin
cp $BUILDDIR/config/hooks/live/0902-lightdm-autologin.chroot $WORKDIR/config/hooks/live/

# copy the hook for allowing sshd password based authentication
cp $BUILDDIR/config/hooks/live/0903-sshd-conf.chroot $WORKDIR/config/hooks/live/

# copy the hook for forcing clamav update
cp $BUILDDIR/config/hooks/live/0904-update-clamav.chroot $WORKDIR/config/hooks/live/

# download osquery installation package then copy the hook for a built-in installation
mkdir -p $WORKDIR/config/includes.chroot/opt
curl -o $WORKDIR/config/includes.chroot/opt/osquery.deb $OSQUERYURL
cp $BUILDDIR/config/hooks/live/0905-osquery-install.chroot $WORKDIR/config/hooks/live/

# copy the custom grub screen
cp -r $BUILDDIR/config/includes.binary/isolinux/ $WORKDIR/config/includes.binary/

# copy the custom xfce4 environment
mkdir $WORKDIR/config/includes.chroot/etc/
cp -r $BUILDDIR/config/includes.chroot/etc/skel $WORKDIR/config/includes.chroot/etc/

# run live iso creation
lb config
sudo lb build

# move the iso to base dir with a timestamped filename
mv live-image-amd64.hybrid.iso $DIR/$ISONAME
cd ..
echo "ISO copied in:"
echo $DIR/$ISONAME
echo "ISO info:"
ls -lh $DIR/$ISONAME
