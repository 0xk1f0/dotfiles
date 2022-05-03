# k1f0's setup.txt

> This file cotains some info for inital setup of a new system
> Also some things I usually forget which are quite handy

# /etc/locale.conf

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
```

# /etc/environment

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
```

# SMB ~/.smbcfg

```bash
serverPath=
serverMount=
```

# BACKUP ~/.bkupcfg

```bash
bkupTarget=
/folder1/
/folder2/folder3/
```
