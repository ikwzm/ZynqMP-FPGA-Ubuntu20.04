## Build Ubuntu 20.04(Desktop) RootFS

### Prepare to build Ubuntu 20.04 Desktop RootFS

#### Build Ubuntu 20.04(Console) RootFS

 * [Build Ubuntu 20.04(Console) RootFS](./ubuntu20.04-console.md)

#### Install Ubuntu 20.04(Console) to Ultra96/Ultra96-V2/Kv260

 * [Ultra96](../install/ultra96-console.md)
 * [Ultra96-V2](../install/ultra96v2-console.md)
 * [Kv260](../install/kv260-console.md)

#### Setup Ultra96/Ultra96-V2/Kv260 borad

 * Put the SD-Card in the slot on Ultra96/Ultra96-V2/Kv260.
 * Plug in your Display Port monitor into the Ultra96 using the mini Display Port connector.
 * Plug in a USB mouse and USB keyboard into the USB ports of the Ultra96.

#### Starting Ultra96/Ultra96-V2/Kv260 board

 * Turn on the Ultra96/Ultra96-V2/Kv260.
 * After a few seconds, the Ubuntu login screen will appear on the display.
 * The password for administrator rights is "admin".
   
#### Setup Network

 * Use 'nmcli' if you use the command line.
 * Use 'nmtui' if you use the Text-UI.

#### Download Ubuntu 20.04(Console) RootFS

```console
shell# git clone --depth=1 --branch v2021.1-console-rc1 git://github.com/ikwzm/ZynqMP-FPGA-Ubuntu20.04
shell# cd ZynqMP-FPGA-Ubuntu20.04
shell# git lfs pull
```

#### Prepare 

```console
shell# export targetdir=ubuntu20.04-rootfs
shell# export distro=focal
shell# mkdir $PWD/$targetdir
shell# tar xfz ubuntu20.04-console-rootfs.tgz -C $PWD/$targetdir
shell# cp scripts/upgrade-ubuntu20.04-desktop.sh $PWD/$targetdir
shell# mount -vt proc proc                       $PWD/$targetdir/proc
shell# mount -vt devpts devpts -o gid=5,mode=620 $PWD/$targetdir/dev/pts
```

### Build ubuntu20.04-rootfs

#### Change Root to ubuntu20.04-rootfs

```console
shell$ sudo chroot $PWD/$targetdir
```

There are two ways

1. run upgrade-ubuntu20.04-desktop.sh (easy)
2. run this chapter step-by-step (annoying)

#### Setup APT

````console
ubuntu20.04-rootfs# export distro=focal
ubuntu20.04-rootfs# export LANG=C
````
#### Install Ubuntu Desktop

```console
ubuntu20.04-rootfs# apt-get install -y ubuntu-desktop
```

#### Install ZynqMP-FPGA-Xserver

```console
ubuntu20.04-rootfs# dpkg -i /home/fpga/debian/xserver-xorg-video-armsoc-xilinx_1.4-ubuntu20-2_arm64.deb
ubuntu20.04-rootfs# cp      /home/fpga/debian/xorg.conf /etc/X11
```

#### Change Display Manager gdm -> lightdm

```console
ubuntu20.04-rootfs# apt install -y libpam-gnome-keyring libpam-kwallet5
ubuntu20.04-rootfs# apt install -y lightdm lightdm-settings slick-greeter
```

#### Disable Sleep/Suspend Mode

```console
ubuntu20.04-rootfs# systemctl mask sleep.target suspend.target hybrid-sleep.target
```

#### Work around Upower Service 

```console
ubuntu20.04-rootfs# sed -i -e 's/PrivateUsers=yes/#PrivateUsers=yes/g'             /usr/lib/systemd/system/upower.service
ubuntu20.04-rootfs# sed -i -e 's/RestrictNamespaces=yes/#RestrictNamespaces=yes/g' /usr/lib/systemd/system/upower.service
```

#### Work around Gtk application crashes

 * https://gitlab.gnome.org/GNOME/gdk-pixbuf/-/issues/159

```console
ubuntu20.04-rootfs# update-mime-database /usr/share/mime
ubuntu20.04-rootfs# /usr/lib/aarch64-linux-gnu/gdk-pixbuf-2.0/gdk-pixbuf-query-loaders --update-cache
```

#### Clean Cache

```console
ubuntu20.04-rootfs# apt-get clean
```

#### Create Debian Package List

```console
ubuntu20.04-rootfs# dpkg -l > dpkg-desktop-list.txt
```

#### Finish

```console
ubuntu20.04-rootfs# exit
shell$ sudo rm -f  $PWD/$targetdir/upgrade-ubuntu20.04-desktop.sh
shell$ sudo mv     $PWD/$targetdir/dpkg-desktop-list.txt files/ubuntu20.04-desktop-dpkg-list.txt
shell$ sudo umount $PWD/$targetdir/proc
shell$ sudo umount $PWD/$targetdir/dev/pts
```

### Build ubuntu20.04-desktop-rootfs.tgz

```console
shell$ cd $PWD/$targetdir
shell$ sudo tar cfz ../ubuntu20.04-desktop-rootfs.tgz *
```

