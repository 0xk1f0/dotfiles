# k1f0's setup file

> This file cotains some info for inital setup of a new system
> 
> Also some things I usually forget which are quite handy

# NTP enabling

```bash
timedatectl set-ntp true
```

# Hosts File /etc/hosts

```bash
# IPV4
127.0.0.1       localhost
127.0.1.1       hostname.localdomain    hostname

# IPV6
::1             localhost
fe00::0         ipv6-localnet
ff00::0         ipv6-mcastprefix
ff02::1         ipv6-allnodes
ff02::2         ipv6-allrouters
ff02::3         ipv6-allhosts
```

# Language and Locales /etc/locale.conf

```bash
LANG=C
LC_CTYPE=en_US.UTF-8
LC_NUMERIC=de_AT.UTF-8
LC_TIME=C
LC_COLLATE=de_AT.UTF-8
LC_MONETARY=de_AT.UTF-8
LC_MESSAGES=en_US.UTF-8
LC_PAPER=de_AT.UTF-8
LC_NAME=de_AT.UTF-8
LC_ADDRESS=de_AT.UTF-8
LC_TELEPHONE="C"
LC_MEASUREMENT="C"
LC_IDENTIFICATION="C"
# requires both "de_AT" and "en_US" locales to be generated
# see /etc/locale.gen
```

# Keymap Configuration

```bash
# add in /etc/vconsole.conf
KEYMAP=de
# set with localectl
localectl set-keymap de
localectl set-x11-keymap de
```

# GRUB /etc/default/grub

```bash
# default
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"
# force enable amd_pstate
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet initcall_blacklist=acpi_cpufreq_init amd_pstate.shared_mem=1"
# other
GRUB_CMDLINE_LINUX=""
GRUB_DISTRIBUTOR="Arch"
GRUB_DEFAULT=0
GRUB_PRELOAD_MODULES="part_gpt part_msdos"
GRUB_TERMINAL_INPUT=console
GRUB_GFXMODE=auto
GRUB_GFXPAYLOAD_LINUX=keep
GRUB_DISABLE_RECOVERY=true
GRUB_TIMEOUT_STYLE=hidden
GRUB_TIMEOUT=1
```

# Swap File /swapfile

```bash
# generate 2G file
dd if=/dev/zero of=/swapfile bs=1M count=2048 status=progress
# set permssions
chmod 0600 /swapfile
# format to swap
mkswap -U clear /swapfile
# enable swap
swapon /swapfile
# add to /etc/fstab
/swapfile   none    swap    defaults    0 0
```

# Environment Variables /etc/environment

```bash
#general
_JAVA_AWT_WM_NONREPARENTING=1
QT_QPA_PLATFORMTHEME=qt5gtk2
EDITOR=nano
VISUAL=nano
# vulkan
DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=0
AMD_VULKAN_ICD=RADV
# firefox and obs egl
MOZ_X11_EGL=1
OBS_USE_EGL=1
```

# Paru First-Time Install

```bash
# make sure build tools are installed
pacman -S base-devel
# clone
git clone https://aur.archlinux.org/paru-bin
cd paru-bin/
# build
makepkg -si
```

# Change to traditional Network Interface Naming

```bash
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules
```

# Custom Name for Network Interfaces /etc/udev/rules.d/10-network.rules

```bash
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="<mac>", NAME="<name>"
SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="<mac>", NAME="<name>"
```

# Change Papersize to A4

```bash
paperconfig -p a4
```

# Make YubiKey work (PC/SC Smart Card Daemon)

```bash
systemctl enable pcscd.service
systemctl start pcscd.service
```

# YubiKey Registration /etc/u2f_mappings

```bash
# generate new key with
pamu2fcfg -o pam://hostname -i pam://hostname
# file format
<username>:<KeyHandle1>,<UserKey1>,<CoseType1>,<Options1>:<KeyHandle2>,<UserKey2>,<CoseType2>,<Options2>
```

# YubiKey PAM Module Code /etc/pam.d/hwkey

```bash
#%PAM-1.0
auth    sufficient  pam_u2f.so      cue [cue_prompt=Touch YubiKey..] authfile=/etc/u2f_mappings

# Implement like this f.E. in /etc/pam.d/doas
auth    include     hwkey
```

# Custom SMB Mount Script Config ~/.smbcfg

```bash
SMB_SERVER=//path/to/server
serverMount=/path/to/mountpoint
```

# Custom Backup Script Config ~/.bkupcfg

```bash
BTARGET=/path/to/target
DIRS=(
    "/folder1"
    "/path/to/folder2"
)
```

# sysctl Stuff /etc/sysctl.d/90-override.conf

```bash
# change network qdisc
net.core.default_qdisc = fq_pie
# change likelyness of swapping
vm.swappiness = 60
```

# Docker IP-Address Range /lib/systemd/system/docker.service

```bash
ExecStart=/usr/bin/dockerd -H fd:// --bip "192.168.8.1/24"
```

# Rust Dev Setup

```bash
# Make sure rustup is installed
pacman -S rustup
# Set default toolchain
rustup default stable
```

# avrdude Arduino Flashing

```bash
# Arduino MEGA 2560
avrdude -p m2560 -c wiring -P [port] -b [baudrate] -D -U flash:w:[filename]
```
