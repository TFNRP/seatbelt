--- Configuration variables
--- @type table<string, any>
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
}
