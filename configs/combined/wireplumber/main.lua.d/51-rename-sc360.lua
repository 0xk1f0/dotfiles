rule = {
  matches = {
    {
      {
        "device.name",
        "equals",
        "alsa_card.usb-the_t.bone_SC_360_USB_the_t.bone_SC_360_USB-00"
      },
    },
  },
  apply_properties = {
    ["device.nick"] = "t.bone SC 360",
    ["device.description"] = "t.bone SC 360",
  },
}

table.insert(alsa_monitor.rules, rule)
