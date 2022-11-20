rule = {
  matches = {
    {
      {
        "node.name",
        "equals",
        "bluez_output.2C_BE_EB_0F_6D_52.1"
      },
    },
  },
  apply_properties = {
    ["audio.format"] = "S16LE",
    ["audio.rate"] = 48000,
  },
}

table.insert(bluez_monitor.rules, rule)
