rule = {
  matches = {
    {
      {
        "device.name",
        "equals",
        "bluez_card.2C_BE_EB_0F_6D_52"
      },
    },
  },
  apply_properties = {
    ["device.nick"] = "nothing ear (1)",
    ["device.description"] = "nothing ear (1)",
  },
}

table.insert(bluez_monitor.rules, rule)
