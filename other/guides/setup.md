# k1f0's setup file

> This file cotains some info for inital setup of a new system 

> Also some things I usually forget which are quite handy

# NTP enabling

```bash
timedatectl set-ntp true
```

# Keymap Configuration

```bash
# set with localectl
localectl set-keymap de
localectl set-x11-keymap de
```

# GRUB /etc/default/grub

```bash
# force enable amd_pstate
GRUB_CMDLINE_LINUX="initcall_blacklist=acpi_cpufreq_init amd_pstate.shared_mem=1"

# fix backlight issues
GRUB_CMDLINE_LINUX="acpi_backlight=vendor" 

# with full disk encryption
GRUB_CMDLINE_LINUX="cryptdevice=UUID=[UUID]:root root=/dev/mapper/root"
GRUB_ENABLE_CRYPTODISK=y
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
