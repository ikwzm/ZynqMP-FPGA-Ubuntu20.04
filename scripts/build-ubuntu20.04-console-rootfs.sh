
### Build Ubuntu 20.04(Console) RootFS

#### Setup APT

distro=focal
export LANG=C

/debootstrap/debootstrap --second-stage

cat <<EOT > /etc/apt/sources.list
deb http://ports.ubuntu.com/ubuntu-ports focal main restricted universe multiverse
deb-src http://ports.ubuntu.com/ubuntu-ports focal main restricted universe multiverse
deb http://ports.ubuntu.com/ubuntu-ports focal-updates main restricted universe multiverse
deb-src http://ports.ubuntu.com/ubuntu-ports focal-updates main restricted universe multiverse
deb http://ports.ubuntu.com/ubuntu-ports focal-security main restricted universe multiverse
deb-src http://ports.ubuntu.com/ubuntu-ports focal-security main restricted universe multiverse
EOT

cat <<EOT > /etc/apt/apt.conf.d/71-no-recommends
APT::Install-Recommends "0";
APT::Install-Suggests   "0";
EOT

apt-get update  -y
apt-get upgrade -y

#### Install Core applications

apt-get install -y locales dialog
dpkg-reconfigure locales
apt-get install -y net-tools openssh-server ntpdate resolvconf sudo less hwinfo ntp tcsh zsh file

#### Setup hostname

echo "ubuntu-fpga" > /etc/hostname

#### Set root password

echo Set root password
passwd

cat <<EOT >> /etc/securetty
# Seral Port for Xilinx Zynq
ttyPS0
EOT

#### Add fpga user

echo Add fpga user
adduser fpga
echo "fpga ALL=(ALL:ALL) ALL" > /etc/sudoers.d/fpga

#### Setup sshd config

sed -i -e 's/#PasswordAuthentication/PasswordAuthentication/g' /etc/ssh/sshd_config

#### Setup Time Zone

dpkg-reconfigure tzdata

#### Setup fstab

cat <<EOT > /etc/fstab
none            /config         configfs        defaults        0       0
EOT

#### Setup /lib/firmware

mkdir /lib/firmware
mkdir /lib/firmware/ti-connectivity
mkdir /lib/firmware/mchp

#### Install Development applications

apt-get install -y build-essential
apt-get install -y pkg-config
apt-get install -y curl
apt-get install -y git
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
apt-get install -y git-lfs
apt-get install -y kmod
apt-get install -y flex bison
apt-get install -y u-boot-tools device-tree-compiler
apt-get install -y libssl-dev
apt-get install -y socat
apt-get install -y ruby rake ruby-msgpack ruby-serialport
apt-get install -y python3 python3-dev python3-setuptools python3-wheel python3-pip python3-numpy
pip3 install msgpack-rpc-python

#### Install Wireless tools and firmware

apt-get install -y wireless-tools
apt-get install -y wpasupplicant
#apt-get install -y firmware-realtek
#apt-get install -y firmware-ralink

git clone git://git.ti.com/wilink8-wlan/wl18xx_fw.git
cp wl18xx_fw/wl18xx-fw-4.bin /lib/firmware/ti-connectivity
rm -rf wl18xx_fw/

git clone git://git.ti.com/wilink8-bt/ti-bt-firmware
cp ti-bt-firmware/TIInit_11.8.32.bts /lib/firmware/ti-connectivity
rm -rf ti-bt-firmware

git clone git://github.com/linux4wilc/firmware  linux4wilc-firmware  
cp linux4wilc-firmware/*.bin /lib/firmware/mchp
rm -rf linux4wilc-firmware  

#### Install Other applications

apt-get install -y avahi-daemon
apt-get install -y samba

#### Install haveged for Linux Kernel 4.19

apt-get install -y haveged

#### Install network-manager for Ubuntu18.04

apt-get install -y network-manager

#### Move Debian Package to /home/fpga/debian

mkdir /home/fpga/debian
mv *.deb     /home/fpga/debian
mv xorg.conf /home/fpga/debian
chown fpga.fpga -R /home/fpga/debian

#### Install Linux Image and Header Debian Packages

dpkg -i home/fpga/debian/linux-image-5.4.0-xlnx-v2020.2-zynqmp-fpga_5.4.0-xlnx-v2020.2-zynqmp-fpga-1_arm64.deb

#### Clean Cache

apt-get clean

##### Create Debian Package List

dpkg -l > dpkg-console-list.txt
