rule = {
  matches = {
    {
      {
        "node.name",
        "equals",
        "alsa_input.usb-the_t.bone_SC_360_USB_the_t.bone_SC_360_USB-00.analog-stereo"
      },
    },
  },
  apply_properties = {
    ["audio.format"] = "S24_3LE",
    ["audio.rate"] = 96000,
  },
}

table.insert(alsa_monitor.rules, rule)
