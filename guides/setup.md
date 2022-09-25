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

## GRUB /etc/default/grub

```bash
# force enable amd_pstate
GRUB_CMDLINE_LINUX="initcall_blacklist=acpi_cpufreq_init amd_pstate.shared_mem=1"
# fix backlight issues
GRUB_CMDLINE_LINUX="acpi_backlight=vendor"
```

---

## clevis TPM 2.0 LUKS2 partition Auto-Decryption /etc/mkinitcpio.conf

```bash
# get necessary things
pacman -S clevis libpwquality
paru -S mkinitcpio-clevis-hook
# bind clevis to disk and seal against UEFI and Secure Boot
clevis luks bind -d /dev/[disk] tpm2 '{"pcr_ids":"1,7"}'
# check if it worked
cryptsetup luksDump /dev/[disk]
# edit mkinitcpio.conf and regenerate
nano /etc/mkinitcpio.conf
> HOOKS=(base udev autodetect keyboard keymap consolefont modconf block clevis encrypt lvm2 filesystems fsck)
mkinitcpio -P
```

---

## TPM 2.0 clear DA Lockdown Mode

```bash
tpm2_dictionarylockout --clear-lockout
```

---

## Swap File /swapfile

```bash
# generate 2G file
dd if=/dev/zero of=/swapfile bs=1M count=[size] status=progress
# set permssions
chmod 0600 /swapfile
# format to swap
mkswap -U clear /swapfile
# enable swap
swapon /swapfile
# add to /etc/fstab
/swapfile   none    swap    defaults    0 0
```

---

## Paru First-Time Install

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

## YubiKey Registration /etc/u2f_mappings

```bash
# generate new key with
pamu2fcfg -o pam://[hostname] -i pam://[hostname]
# file format f.E.
<username>:<KeyHandle1>,<UserKey1>,<CoseType1>,<Options1>:<KeyHandle2>,<UserKey2>,<CoseType2>,<Options2>
```

---

## YubiKey PAM Module Code /etc/pam.d/hwkey

```bash
#%PAM-1.0
auth    sufficient  pam_u2f.so      cue [cue_prompt=Touch YubiKey..] authfile=/etc/u2f_mappings
# Implement like this f.E. in /etc/pam.d/doas
auth    include     hwkey
```

---

## sysctl Stuff /etc/sysctl.d/90-override.conf

```bash
# change likelyness of swapping
vm.swappiness=60
```

---

## Docker IP-Address Range /lib/systemd/system/docker.service

```bash
ExecStart=/usr/bin/dockerd -H fd:// --bip "192.168.8.1/24"
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

## set correct keymap when using barrier

```bash
# barrier creates a new keyboard input, which defaults to english layout
setxkbmap -device `xinput list | grep "Virtual core XTEST keyboard" | sed -e 's/.\+=\([0-9]\+\).\+/\1/'` [keymap]
```
