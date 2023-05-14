# k1f0's setup file

> This file cotains some info for inital setup of a new system
>
> Also some things I usually forget which are quite handy

---

## NTP enabling

```bash
timedatectl set-ntp true
```

---

## Keymap Configuration

```bash
# set with localectl
# this modifies /etc/X11/xorg.conf.d/00-keyboard.conf
localectl set-keymap [keymap]
localectl set-x11-keymap [keymap]
```

---

## Kernel Parameters

```bash
# fix dracut initrd errors
"root=[UUID]"
# systemd-cryptenroll TPM auto decryption
"rd.luks.options=[UUID]=tpm2-device=auto rd.luks.name=[UUID]=root"
# enable amd_pstate
"amd_pstate.replace=1 amd_pstate=passive"
# fix backlight issues
"acpi_backlight=vendor"
```

---

## dracut and systemd-boot

```bash
# install dracut and hooks
pacman -S dracut
paru -S dracut-hook-uefi
# edit configuration
# !IMPORTANT! root must be specified or initrd will fail
nano /etc/dracut.conf.d/flags.conf
> uefi="yes"
> compress="lz4"
> force_drivers+=" amdgpu "
> omit_dracutmodules+=" brltty network-legacy network nfs "
> stdloglvl="3"
> show_modules="yes"
> kernel_cmdline="quiet root=[UUID]"
# regenerate
dracut --regenerate-all --force
# yeet mkinitcpio
pacman -Rs mkinitcpio
```

```bash
# systemd-boot hook
paru -S systemd-boot-pacman-hook
# install
bootctl install
# update
bootctl update
```

---

## fstab SSD performance improvements (noatime)

***File***

- /etc/fstab

```bash
# root
UUID=[UUID]    /    ext4    rw,noatime  0 1
```

---

## LUKS2 SSD speed improvements

***File***

- /etc/crypttab

```bash
# disable read-workqueue and write-workqueue for root
# <name>    <device>          <password>      <options>
root        UUID=[UUID]       -               no-read-workqueue,no-write-workqueue
```

---

## systemd TPM 2.0 LUKS2 Auto-Decryption

```bash
# all systemd things should already be installed
# bind against platform conf and secure boot
systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=1+7 /dev/[disk]
# check if it worked
cryptsetup luksDump /dev/[disk]
# edit /etc/crypttab and add
nano /etc/crypttab
> # <name>    <device>          <password>      <options>
> root        UUID=[UUID]       -               tpm2-device=auto
# add Kernel parameters
"rd.luks.options=[UUID]=tpm2-device=auto rd.luks.name=[UUID]=root"
# for mkinitcpio
nano /etc/mkinitcpio.conf
> HOOKS=(base systemd autodetect keyboard keymap sd-vconsole modconf block sd-encrypt filesystems fsck)
mkinitcpio -P
# for dracut
nano /etc/dracut.conf.d/flags.conf
> add_dracutmodules+=" tpm2-tss "
dracut --regenerate-all --force
```

---

## TPM 2.0 clear DA Lockdown Mode

```bash
tpm2_dictionarylockout --clear-lockout
```

---

## Swap File

```bash
# generate 2G file
dd if=/dev/zero of=/swapfile bs=1M count=[size] status=progress
# set permssions
chmod 0600 /swapfile
# format to swap
mkswap /swapfile
# enable swap
swapon /swapfile
# add to /etc/fstab
/swapfile   none    swap    defaults    0 0
```

---

## paru First-Time Install

```bash
# make sure build tools are installed
pacman -S base-devel
# clone
git clone https://aur.archlinux.org/paru-bin
cd paru-bin/
# build
makepkg -si
```

---

## Change to traditional Network Interface Naming

```bash
# simple symlink
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules
```

---

## Change Papersize to A4

```bash
# simple command so printers don't complain
paperconfig -p a4
```

---

## Make YubiKey work (PC/SC Smart Card Daemon)

```bash
# check if we have smartcard tools installed
pacman -S pcsc-tools
# enable and start the service
systemctl enable pcscd.service
systemctl start pcscd.service
```

---

## YubiKey Registration

```bash
# generate new key with
pamu2fcfg -o pam://[hostname] -i pam://[hostname]
# file format f.E. in /etc/u2f_mappings
<username>:<KeyHandle1>,<UserKey1>,<CoseType1>,<Options1>:<KeyHandle2>,<UserKey2>,<CoseType2>,<Options2>
```

---

## YubiKey PAM Module Code

***File***

- /etc/pam.d/hwkey

```bash
#%PAM-1.0
auth    sufficient  pam_u2f.so      cue [cue_prompt=Touch YubiKey..] authfile=/etc/u2f_mappings
# Implement like this f.E. in /etc/pam.d/doas
auth    include     hwkey
```

---

## sysctl Stuff

***File***

- /etc/sysctl.d/90-override.conf

```bash
# change likelyness of swapping
vm.swappiness=60
```

---

## Docker IP-Address Range

***File***

- /lib/systemd/system/docker.service

```bash
ExecStart=/usr/bin/dockerd -H fd:// --bip "192.168.8.1/24"
```

---

## Windows font rendering

***Files***

- /etc/fonts/conf.d/99-calibir-fix.conf
- ~/.config/fontconfig/fonts.conf

```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
<fontconfig>
    <!-- disable embedded bitmaps in fonts to fix Calibri, Cambria, etc. -->
    <match target="font">
       <edit mode="assign" name="embeddedbitmap"><bool>false</bool></edit>
    </match>
</fontconfig>
```

---

## Rust Dev Setup

```bash
# Make sure rustup is installed
pacman -S rustup
# Set default toolchain
rustup default stable
```

---

## avrdude Arduino Flashing

```bash
# Arduino MEGA 2560
avrdude -p m2560 -c wiring -P [port] -b [baudrate] -D -U flash:w:[filename]
```

---

## Set correct Keymap when using barrier

```bash
# barrier creates a new keyboard input, which defaults to english layout
setxkbmap -device `xinput list | grep "Virtual core XTEST keyboard" | sed -e 's/.\+=\([0-9]\+\).\+/\1/'` [keymap]
```

---

## Fix GTK Cursor Theme ~/.icons/default/index.theme

***File***

- ~/.icons/default/index.theme

```bash
[Icon Theme]
Inherits=CursorThemeName
```

---
