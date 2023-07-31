-- Do not edit config.default.lua
-- Copy config.default.lua and rename the copy to config.lua

--- Configuration variables
--- @type {}
Config = {}

--- The method that should be used to check whether a player is an on-duty LEO.  
--- For a player to receive an LEO notification, they must
--- - `1` = be inside a police vehicle; or
--- - `2` = have the `seatbelt.notify` ACL.
--- @type 1 | 2
Config.LeoCheck = 2

--- Changes how players are identified to LEOs. Cannot be nilish
--- - `1` = Player ID (i.e. "Player 7")
--- - `2` = Seat position (i.e. "Driver", "Passenger", "Rear left passenger", "Far rear left passenger")
--- - `3` = Username (i.e. "Hagen Hyena", "1D-32 Backer P.")
--- @type 1 | 2 | 3
Config.PlayerIdentifierType = 1

--- Distance which LEOs can detect seatbelt-less occupants within.
--- @type number -- A postive number
Config.Distance = 20

--- The default seatbelt keybind.  
--- After a player joins, their keybind will not change if
--- the default keybind changes.  
--- Players can manually change this keybind in their settings.
--- @type string
--- @see {@link https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard}
Config.DefaultKeybind = 'K'

--- Custom vehicles/seats that don't have seatbelts.  
--- Bicycles, motorbikes and submersibles are excluded automatically
--- - `1` = Seatbelt always off, windscreen ejection still occurs
--- - `2` = Seatbelt always on, ejection is never calculated
--- @type table<hash, (1 | 2) | table<number, 1 | 2>>
Config.Excluded = {
  [GetHashKey('MINITANK')] = 2, -- Seatbelt always on.
  [GetHashKey('HALFTRACK')] = { [3] = 1 }, -- Seat #3 has no seatbelt.
  [GetHashKey('KHANJALI')] = 2,
  [GetHashKey('APC')] = 2,
  [GetHashKey('THRUSTER')] = 2,
  [GetHashKey('RHINO')] = 2,
}

--- A model hash key
--- @alias hash number