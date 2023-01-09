rule = {
  matches = {
    {
      {
        "device.name",
        "equals",
        "alsa_card.usb-Tdlasunnic_Sharkoon_Gaming_DAC_Pro_S_20181228.1-00"
      },
    },
  },
  apply_properties = {
    ["device.nick"] = "HyperX Cloud 2",
    ["device.description"] = "HyperX Cloud 2",
  },
}

table.insert(alsa_monitor.rules, rule)
