# Seatbelt

## About

A modern realisation on seatbelt scripts, for additional roleplay and realism to your server.  

## Installation

- Install to your `resource` folder (or [download manually](https://github.com/TFNRP/seatbelt/archive/refs/heads/main.zip)):

```bash
git clone https://github.com/TFNRP/seatbelt.git
```

- (Optional) Copy `config.default.lua`, rename the copy to `config.lua` and edit it to your liking.
- Add the following to your `server.cfg`:
  - `ensure seatbelt`
  - (Optional) `add_ace group.police seatbelt.notify allow`  
    Replace `police` with your LEO group.  
    This is optional if you don't use ACL - read [Configuration](#configuration).

## Features

Modern Seatbelt does the following:

- Buckle up with `/seatbelt` or <kbd>K</kbd>.
- Keybinds can be changed in FiveM keybind settings.
- Quick unbuckle by pressing <kbd>Shift</kbd> + <kbd>F</kbd>.
- Heftier consequences for MVAs.
- Law enforcement notified of traffic violation
  when driving behind (or crossing infront).
- Out-of-the-way notifications whilst driving
  without seatbelt.
- Lightweight, out of the box.
- Supports the TFNRP framework.
- Realistic sound effects for buckling & driving w/o SB.

## Coming Soon

Features that are planned for Modern Seatbelt:

- Complimentary scripts for compatible UI support.

## Configuration

> Note: Do not edit `config.default.lua`

Copy `config.default.lua` and rename the copy to `config.lua`.  
Check [config.lua](https://github.com/TFNRP/seatbelt/blob/main/config.default.lua) for better details.

property | description
-- | --
`LeoCheck` = `2` | The method this script should use to check whether a player is an (on-duty) LEO.</br>`1` = be inside a police vehicle; or</br>`2` = have the `seatbelt.notify` ACL.
`PlayerIdentifierType` = `1` | What type of LEO notifications should be shown?</br>`1` = Player ID (i.e. "Player 7")</br>`2` = Seat position (i.e. "Driver", "Passenger", "Rear left passenger", "Far rear left passenger")</br>`3` = Username (i.e. "Hagen Hyena", "1D-32 Backer P.")
`Distance` = `20` | The amount of distance LEOs have to be to detect people not weaing a seatbelt.  
`DefaultKeybind` = `K` | The default seatbelt keybind.  
`Excluded` | A list of excluded vehicles and vehicle seats.

## Contributing

[Reports issues and create suggestions](https://github.com/TFNRP/seatbelt/issues).  
[Improve code, fix issues and add suggestions](https://github.com/TFNRP/seatbelt/pulls).

## Credits & Copyright

- [@TehRamsus](https://forum.cfx.re/u/TehRamsus) for their [Seatbelt](https://github.com/TehRamsus/Seatbelt) script, which inspired me to create Modern Seatbelt.  
- [@Mercy3](https://forum.cfx.re/u/Mercy3) for providing and giving permission of use of `static/assets/{buckle,chime,unbuckle}.ogg` files.

Licensed under [MIT License](https://github.com/TFNRP/seatbelt/blob/main/LICENSE). No code or assets of the inspiring work has been used.  
The author of [Seatbelt](https://github.com/TehRamsus/Seatbelt) stated they would rework their original work but has not done so since Oct 25th, '21, hence my release.  
