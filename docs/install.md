# k1f0's install file

> This File cotains some Info for inital Install of a new Arch-based System
>  
> The setup includes Full Disk Encryption, which you can and SHOULD use because your data is important
>  
> Most Things in here are done as stated in the [ArchWiki](https://wiki.archlinux.org/title/Installation_guide)

---

## Pre-Install for Boot Media

```bash
# Load Key Layout
loadkeys [keymap]
# Make sure we have Internet
ip a
ping 1.1.1.1
nslookup archlinux.org
# WiFI Connection (if needed)
iwctl
> device list
> station device scan
> station [dev] get-networks
> station [dev] connect [ssid]
```

---

## Partition Setup

```bash
# list all disks
fdisk -l
# edit the target disk
fdisk [/dev/disk]
# We need a root and a boot Partition:
# boot: Type 1 (EFI System), max 550M
# root: Type 20 (Linux filesystem)
# Swap Partition is optional, Swap File is prefered:
# swap: Type 19 (Linux swap)
# fdisk commands:
> d #delete partition
> t #change partition type
> w #write changes to disk
> g #create new GPT partition table
> q #quit WITHOUT saving
> m #print help
> n #add new partition
```

---

## Formatting and Mounting with Full Disk Encryption

```bash
# The result will look like this
# +-----------------------+------------------------+
# | Boot partition        | LUKS2 encrypted system |
# |                       | partition              |
# |                       |                        |
# | /boot                 | /                      |
# |                       |                        |
# |                       | /dev/mapper/root       |
# |                       |------------------------|
# | /dev/disk1            | /dev/disk2             |
# +-----------------------+------------------------+
# new LUKS for root
# Make sure to use a strong password
cryptsetup -y -v luksFormat [/dev/root_part]
cryptsetup open [/dev/root_part] root
# EXT4 for encrypted root
mkfs.ext4 /dev/mapper/root
# FAT32 for boot (UEFI)
mkfs.fat -F32 [/dev/boot_part]
# Mount root
mount /dev/mapper/root /mnt
# Mount boot (UEFI)
# We mount directly to /boot because the unencrypted
# boot partition will need to house our kernel
mkdir /mnt/boot
mount [/dev/boot_part] /mnt/boot
```

---

## Initial Setup

```bash
# Run pacstrap to install Base Packages
pacstrap /mnt base linux linux-headers linux-firmware git base-devel
# Generate initial fstab
genfstab -U /mnt >> /mnt/etc/fstab
# chroot into your New System
arch-chroot /mnt
```

---

## Configuring the New System

```bash
# Set a Password
passwd
# Set Timezone
ln -sf /usr/share/zoneinfo/[Region]/[City] /etc/localtime
# Set Hardware Clock
hwclock --systohc
# Choose Locales
nano /etc/locale.gen
> [locale].UTF-8 UTF-8
# Generate
locale-gen
# Set Keymap
nano /etc/vconsole.conf
> KEYMAP=[keymap]
# Set Hostname
nano /etc/hostname            
> yourHostname
# Edit hosts file
nano /etc/hosts
> 127.0.0.1     localhost
> 127.0.1.1     [hostname].localdomain    [hostname]
> ::1           localhost
# Network Setup
pacman -S networkmanager
systemctl enable NetworkManager
```

---

## Adding a New User

```bash
useradd -m [username]
passwd [username]
# example groups, some may not be available
usermod -aG wheel,audio,video,uucp,render,realtime,libvirt [username]
```

---

## Making "wheel" Members Superusers

```bash
nano /etc/sudoers
> %wheel ALL=(ALL:ALL) ALL
```

---

## Installing the Bootloader

```bash
# dracut install
pacman -S dracut dosfstools efibootmgr
# hooks from AUR
paru -S dracut-hook-uefi systemd-boot-pacman-hook
# edit configuration
# !IMPORTANT! root must be specified or initrd will fail
nano /etc/dracut.conf.d/flags.conf
> uefi="yes"
> hostonly="yes"
> compress="lz4"
> stdloglvl="3"
> show_modules="no"
> kernel_cmdline="quiet cryptdevice=UUID=[UUID]:root rd.luks.name=[UUID]=root root=/dev/mapper/root"
# regenerate
dracut --regenerate-all --force
# systemd-boot install
bootctl install
bootctl update
# remove mkinitcpio
pacman -Rs mkinitcpio
```

---

## Finishing Up

```bash
# Exit chroot
exit
# Properly unmount the New System
umount -l /mnt
# If running encryted setup
cryptsetup close root
# Reboot
reboot
```
