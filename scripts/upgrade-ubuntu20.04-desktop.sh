#This shell script refers this tip : https://qiita.com/ikwzm/items/be06b07e26cbf05fec2b
#rootfs which this script generates is compatible for v2020.1.1 of https://github.com/ikwzm/ZynqMP-FPGA-Linux

#### Setup APT

distro=focal
export LANG=C

#### Install Xorg HWE (Option)

# apt-get install -y xserver-xorg-core-hwe-18.04 xserver-xorg-input-all-hwe-18.04 xserver-xorg-legacy-hwe-18.04
# apt-get install -y xorg

#### Install Ubuntu Desktop

apt-get install -y ubuntu-desktop

#### Install ZynqMP-FPGA-Xserver

dpkg -i /home/fpga/debian/xserver-xorg-video-armsoc-xilinx_1.4-ubuntu20-2_arm64.deb
cp      /home/fpga/debian/xorg.conf /etc/X11

#### Change Display Manager gdm -> lightdm

apt install -y lightdm lightdm-settings slick-greeter

#### Disable Sleep/Suspend Mode

systemctl mask sleep.target suspend.target hybrid-sleep.target

#### Work around Upower Service 

sed -i -e 's/PrivateUsers=yes/#PrivateUsers=yes/g'             /usr/lib/systemd/system/upower.service
sed -i -e 's/RestrictNamespaces=yes/#RestrictNamespaces=yes/g' /usr/lib/systemd/system/upower.service

#### Work around Gtk application crashes

update-mime-database /usr/share/mime
/usr/lib/aarch64-linux-gnu/gdk-pixbuf-2.0/gdk-pixbuf-query-loaders --update-cache

#### Clean Cache

apt-get clean

##### Create Debian Package List

dpkg -l > dpkg-desktop-list.txt
