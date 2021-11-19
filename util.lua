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

if GetConvar('tfnrp_framework_init') == 'true' then
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

function DoesPedVehicleHaveSeatbelt(ped)
  return not (
    not IsPedInAnyVehicle(ped)
    or IsPedOnAnyBike(ped)
    or IsPedInAnyBoat(ped)
    or IsPedInAnyPlane(ped)
    or IsPedInAnyHeli(ped)
  )
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