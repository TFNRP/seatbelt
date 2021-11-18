# Seatbelt

## About

A modern realisation on seatbelt scripts, for additional roleplay and realism to your server.  

## Installation

- Install to your `resource` folder (or [download manually](https://github.com/TFNRP/seatbelt/archive/refs/heads/main.zip)):

```bash
$ git clone https://github.com/TFNRP/seatbelt.git
```

- Add the following to your `server.cfg`:
  - `ensure seatbelt`

https://github.com/TFNRP/seatbelt

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

## Coming Soon

Features that are planned for Modern Seatbelt:

- Complimentary scripts for compatible UI support.
- Audible realistic beeping tone whilst driving without SB.

## Configuration

Modern Seatbelt has no config.
<details>
<summary>Change the default <code>/seatbelt</code> <kbd>K</kbd> keybind</summary>

Go to [client.lua:8:56](https://github.com/TFNRP/seatbelt/blob/main/client.lua#L8) (line 8, character 56) and change `k` to anything from [the documentation](https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard) (or anything from `A-Z`)

</details>

## Contributing

[Reports issues and create suggestions](https://github.com/TFNRP/seatbelt/issues).
[Improve code, fix issues and add suggestions](https://github.com/TFNRP/seatbelt/pulls).

## Credits & Copyright

Thanks to @TehRamsus for their [Seatbelt](https://github.com/TehRamsus/Seatbelt) script, which inspired me to create Modern Seatbelt.
Licensed under [MIT License](https://github.com/TFNRP/seatbelt/blob/main/LICENSE). No code or assets of the inspiring work has been used.
The original author stated they would rework their original work but has not done so since Oct 25th, '21, hence my release.
I messaged @TehRamsus regarding my script on Oct 11th, '21 and yet to receive a response. I'm happy to take down this release upon request.