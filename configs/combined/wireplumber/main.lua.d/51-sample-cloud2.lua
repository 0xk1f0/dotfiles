rule = {
  matches = {
    {
      {
        "node.name",
        "equals",
        "alsa_output.usb-Tdlasunnic_Sharkoon_Gaming_DAC_Pro_S_20181228.1-00.analog-stereo"
      },
    },
  },
  apply_properties = {
    ["audio.format"] = "S32_3LE",
    ["audio.rate"] = 96000,
  },
}

table.insert(alsa_monitor.rules, rule)
