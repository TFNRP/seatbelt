--- Configuration variables
--- @type table
Config = {
  --- Changes how players are identified to LEOs. Cannot be nilish
  --- - `1` = Player ID (i.e. "Player 7")
  --- - `2` = Seat position (i.e. "Driver", "Passenger", "Back left passenger", "Far back left passenger")
  --- - `3` = Username (i.e. "Hagen Hyena", "1D-32 Backer P.")
  --- @type number
  PlayerIdentifierType = 1,


  --- Distance which LEOs can detect seatbelt-less occupants within.
  --- @type number
  Distance = 20,

  --- The default seatbelt keybind.  
  --- After a player joins, their keybind will not change if
  --- the default keybind changes.  
  --- Players can manually change this keybind in their settings.
  --- @type string
  --- @see {@link https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard}
  DefaultKeybind = 'K',

  --- Custom vehicles/seats that don't have seatbelts.  
  --- Bicycles, motorbikes and submersibles are excluded automatically
  --- - `1` or `true` = No seatbelt, windscreen ejection still occurs
  --- - `2` = Seatbelt always on, ejection is never calculated
  --- @type table<hash, boolean|table<number, boolean>>
  Excluded = {
    [GetHashKey('MINITANK')] = 2, -- Seatbelt always on.
    [GetHashKey('HALFTRACK')] = { [3] = true }, -- Seat #3 has no seatbelt.
    [GetHashKey('KHANJALI')] = 2,
    [GetHashKey('APC')] = 2,
    [GetHashKey('THRUSTER')] = 2,
    [GetHashKey('RHINO')] = 2,
  },
}

--- A model hash key
--- @alias hash number