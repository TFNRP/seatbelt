if RegisterFrameworkCommand == nil then
  -- polyfill
  RegisterFrameworkCommand = function (name, handler, restricted)
    if type(name) == 'table' then
      for _, c in ipairs(name) do
        RegisterFrameworkCommand(c, handler, restricted)
      end
    else
      RegisterCommand(name, handler, restricted)
    end
  end
end

if GetConvar('tfnrp_framework_init', 'false') == 'true' then
  IsHudHidden = exports.framework.IsHudHidden
  function IsLEO()
    return exports.framework:GetLocalClientDuty() > 0
  end
else
  function IsHudHidden()
    return false
  end
  function IsLEO()
    return IsPedInAnyPoliceVehicle(PlayerPedId())
  end
end

-- config setup
Constants = {
  Distance = Config.Distance + 0.0,
  Excluded = Config.Excluded,
  DefaultKeybind = Config.DefaultKeybind,
}

local GetPlayerIdentifierMethods = {
  function(serverId)
    return '<C>Player ' .. serverId .. '</C>'
  end,
  function(_, playerPed, vehicle)
    local hash = GetEntityModel(vehicle)
    local seats = GetVehicleModelNumberOfSeats(hash)
    local names = {
      'Driver',
      'Passenger',
      'Rear left passenger',
      'Rear right passenger',
      'Far rear left passenger',
      'Far rear right passenger',
    }
    for seat = 1, math.min(#names, seats) do
      if GetPedInVehicleSeat(vehicle, seat - 2) == playerPed then
        return names[seat]
      end
    end
  end,
  function(serverId)
    return '<C>' .. GetPlayerName(serverId) .. '</C>'
  end,
}

--- GetPlayerIdentifier is a reserved namespace
GetPlayerIdentifier_ = GetPlayerIdentifierMethods[Config.PlayerIdentifierType]

GetPlayerIdentifierMethods = nil
Config = nil

function DoesPedVehicleHaveSeatbelt(ped)
  if not IsPedInAnyVehicle(ped)
     or IsPedOnAnyBike(ped)
     or IsPedInAnyBoat(ped)
     or IsPedInAnyPlane(ped)
     or IsPedInAnyHeli(ped)
  then return false, false end

  local vehicle = GetVehiclePedIsIn(ped)
  local model = GetEntityModel(vehicle)
  if Constants.Excluded[model] then
    if Constants.Excluded[model] == 2 then
      return true, true
    elseif type(Constants.Excluded[model]) == 'table' then
      for seat, type in pairs(Constants.Excluded[model]) do
        if GetPedInVehicleSeat(vehicle, seat - 2) == ped then
          return false, type == 2
        end
      end
    end
  end
  return true, false
end

function Fwv(entity)
  local hr = GetEntityHeading(entity) + 90.0
  if hr < 0.0 then hr = 360.0 + hr end
  hr = hr * 0.0174533
  return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

function ShowNotification(string)
  BeginTextCommandThefeedPost('STRING')
  AddTextComponentSubstringPlayerName(string)
  EndTextCommandThefeedPostTicker(true, true)
end

function ShowHelpText(text, beep)
  SetTextComponentFormat('STRING')
  AddTextComponentSubstringPlayerName(text)
  EndTextCommandDisplayHelp(0, 0, beep, -1)
end