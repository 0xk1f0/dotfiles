# k1f0's setup file

> This file cotains some info for inital setup of a new system
> Also some things I usually forget which are quite handy

# language and locales /etc/locale.conf

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

# GRUB /etc/default/grub

```bash
GRUB_DEFAULT=0
GRUB_TIMEOUT_STYLE=hidden
GRUB_TIMEOUT=1
GRUB_DISTRIBUTOR="Arch"
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet initcall_blacklist=acpi_cpufreq_init amd_pstate.shared_mem=1"
GRUB_CMDLINE_LINUX=""
GRUB_PRELOAD_MODULES="part_gpt part_msdos"
GRUB_TERMINAL_INPUT=console
GRUB_GFXMODE=auto
GRUB_GFXPAYLOAD_LINUX=keep
GRUB_DISABLE_RECOVERY=true
```

# environment variables /etc/environment

```bash
_JAVA_AWT_WM_NONREPARENTING=1
QT_QPA_PLATFORMTHEME=qt5gtk2
EDITOR=nano
AMD_VULKAN_ICD=RADV
MOZ_X11_EGL=1
OBS_USE_EGL=1
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
# Although this should do it, the yubikey desktop app still
# breaks sometimes, just because
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
serverPath=
serverMount=
```

# Custom Backup Script Config ~/.bkupcfg

```bash
bkupTarget=
/folder1/
/folder2/folder3/
```

# sysctl stuff /etc/systctl.d/90-override.conf

```bash
net.core.default_qdisc = fq_pie
vm.swappiness=60
```

# Docker IP-Address Range /lib/systemd/system/docker.service

```bash
ExecStart=/usr/bin/dockerd -H fd:// --bip "192.168.8.1/24"
```
