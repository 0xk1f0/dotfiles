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

## Generate Self-Signed SSL

```bash
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -keyout server.key -out server.crt
```

---

## Keymap Configuration

```bash
# set with localectl
localectl set-keymap [keymap]
```

---

## Kernel Parameters

```bash
# fix dracut initrd errors with luks partition
"cryptdevice=UUID=[UUID]:root rd.luks.name=[UUID]=root root=/dev/mapper/root"
# systemd-cryptenroll TPM auto decryption
"rd.luks.options=[UUID]=tpm2-device=auto"
# enable amd_pstate
"amd_pstate.replace=1 amd_pstate=[mode]"
# fix backlight issues
"acpi_backlight=vendor"
```

---

## Environment Parameters

```bash
# force Vulkan Driver statically
DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1
VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json
# force Mesa's Rusticl for OpenCL
OCL_ICD_VENDORS=/etc/OpenCL/vendors/rusticl.icd
# force Mesa OpenGL driver e.g. zink, radeonsi, etc.
MESA_LOADER_DRIVER_OVERRIDE=radeonsi
# ROCm device fix (rarely needed with newer versions)
HSA_OVERRIDE_GFX_VERSION=10.3.0
# Applications that get fired through systemd f.E. will
# need this in here because they ignore compositor env vars
QT_STYLE_OVERRIDE=kvantum
```

---

## dracut and systemd-boot

```bash
# install dracut and hooks
pacman -S dracut
paru -S dracut-hook-uefi systemd-boot-pacman-hook
# edit configuration
nano /etc/dracut.conf.d/flags.conf
> uefi="yes"
> hostonly="yes"
> compress="lz4"
> stdloglvl="3"
> show_modules="no"
> kernel_cmdline="quiet"
# regenerate
dracut --regenerate-all --force
# yeet mkinitcpio
pacman -Rs mkinitcpio
# install
bootctl install
# update
bootctl update
```

---

## Enable and manage Secure Boot using sbctl

```bash
# check status
sbctl status
# generate new keys
sbctl create-keys
# enroll keys
sbctl enroll-keys --microsoft # with microsoft keys
sbctl enroll-keys --tpm-eventlog # with TPM eventlog checksums
sbctl enroll-keys --yes-this-might-brick-my-machine # only user keys (dangerzone)
# verify what files are signed
sbctl verify
# sign a single file
sbctl sign /path/to/file
# sign all files
sbctl sign-all
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
systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=1+2+3+5+6+7 /dev/[disk]
# check if it worked
cryptsetup luksDump /dev/[disk]
# edit /etc/crypttab and add
nano /etc/crypttab
> # <name>    <device>          <password>      <options>
> root        UUID=[UUID]       -               tpm2-device=auto
# add params
nano /etc/dracut.conf.d/flags.conf
> add_dracutmodules+=" tpm2-tss "
> kernel_cmdline+="rd.luks.options=[UUID]=tpm2-device=auto"
# regenerate
dracut --regenerate-all --force
```

---

## LUKS systemd clear all TPM entries

```bash
systemd-cryptenroll /dev/[disk] --wipe-slot=tpm2
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
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules
```

---

## Change Papersize to A4

```bash
paperconf -p a4
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
# for linux hardened concerning flatpak
kernel.unprivileged_userns_clone=1
# docker rootless privs
net.ipv4.ping_group_range=0 2147483647
net.ipv4.ip_unprivileged_port_start=0
# cloudflare recommended network stuff
net.ipv4.tcp_adv_win_scale = -2
net.ipv4.tcp_rmem = 8192 262144 536870912
net.ipv4.tcp_wmem = 4096 16384 536870912
net.ipv4.tcp_shrink_window = 1
net.ipv4.tcp_collapse_max_bytes = 6291456
net.ipv4.tcp_notsent_lowat = 131072
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

## Fix GTK Cursor Theme ~/.icons/default/index.theme

***File***

- ~/.icons/default/index.theme

```bash
[Icon Theme]
Inherits=CursorThemeName
```

---

## Wine Temp Directory on tmpfs

```bash
rm -r ~/.wine/drive_c/users/$USER/Temp ~/.wine/drive_c/windows/temp
ln -s /tmp/ ~/.wine/drive_c/users/$USER/Temp
ln -s /tmp/ ~/.wine/drive_c/windows/temp
```

---

## Force GTK3 Pinentry by default

```bash
rm /usr/bin/pinentry
ln -s /usr/bin/pinentry-gnome3 /usr/bin/pinentry
```
