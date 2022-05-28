# k1f0's install file

> This File cotains some Info for inital Install of a new Arch-based System
> 
> Most Things in here are done as stated in the [ArchWiki](https://wiki.archlinux.org/title/Installation_guide)

# Pre-Install for Boot Media

```bash
# Load Key Layout
loadkeys de
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
# Enable NTP
timedatectl set-ntp true
timedatectl status
```

# Disk Setup

```bash
# list all disks
fdisk -l
# edit a disk
fdisk [/dev/sdX] || [/dev/nvme0nX]
# fdisk commands
> d #delete partition
> t #change partition type
> w #write changes to disk
> g #create new GPT partition table
> q #quit WITHOUT saving
> m #print help
> n #add new partition
# We need a root and a boot (UEFI) Partition
# Swap Partition is optional, Swap File is prefered 
```

# Disk Formatting and Mounting

```bash
# EXT4 for root
mkfs.ext4 [/dev/root_part]
# FAT32 for boot (UEFI)
mkfs.fat -F32 [/dev/boot_part]
# Depending on Drive Size/Speed this can take a bit
# If successful we can proceed
# Mount root
mount [/dev/root_part] /mnt
```

# Initial Setup of the New Filesystem

```bash
# Run pacstrap to install Base Packages
pacstrap /mnt base linux linux-headers linux-firmware opendoas nano git
# Generate initial fstab
genfstab -U /mnt >> /mnt/etc/fstab
# chroot into your New System
arch-chroot /mnt
```

# Configuring the New System

```bash
# Set Timezone
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
# Enable NTP
timedatectl set-ntp true
timedatectl status
# Set Hardware Clock
hwclock --systohc
# Choose Locales
nano /etc/locale.gen
> en_US.UTF-8 UTF-8 #uncomment this f.E.
# Generate Locales
locale-gen
# Set Keymap
nano /etc/vconsole.conf
> KEYMAP=de
# Set Hostname
nano /etc/hostname                                                                                         
> yourHostname
# Set a Password
passwd
# Network Setup
pacman -S networkmanager
systemctl enable NetworkManager
```

# Adding a New User

```bash
useradd -m [username]
passwd [username]
usermod -aG wheel,audio,video,network,uucp [username]
```
# Making "wheel" Members Superusers

```bash
# With doas
nano /etc/doas.conf
> permit persist :wheel
>
# With sudo
EDITOR=nano visudo
> %wheel ALL=(ALL) ALL #uncomment this
```

# Installing the Bootloader

```bash
# Get a few extra packages
pacman -S grub efibootmgr dosfstools os-prober mtools
# Mount boot (UEFI)
mkdir /boot/EFI
mount [/dev/boot_part] /boot/EFI
# Install GRUB
grub-install --target=x86_64-efi --bootloader-id=Archlinux --recheck
grub-mkconfig -o /boot/grub/grub.cfg
```

# Finishing Up

```bash
# Install proper Microcode for your system
pacman -S amd-ucode #for AMD
pacman -S intel-ucode #for Intel
# Exit chroot
exit
# Properly unmount the New System
umount -l /mnt
# Reboot
reboot
```
