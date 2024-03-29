local showingWarning = false
local lastSpeed = 0
local lastVelocity = vector3(0, 0, 0)
local newbieBeep = true
local showHelp = false
local activated
local hasSeatbelt

RegisterKeyMapping('seatbelt', 'Seatbelt', 'keyboard', Constants.DefaultKeybind)
RegisterFrameworkCommand('seatbelt', function()
  local ped = PlayerPedId()
  if IsPedInAnyVehicle(ped) then
    local vehcileHasSeatbelt, strong = DoesPedVehicleHaveSeatbelt(ped)
    if vehcileHasSeatbelt and not strong then
      if activated then
        DeactivateSeatbelt()
      else
        ActivateSeatbelt()
      end
      SendNuiMessage('{"t":0,"d":' .. (activated == true and '1' or '0') .. '}')
    end
  end
end)

function ActivateSeatbelt()
  if activated == true then
    return error('seatbelt attempted to activate when already active.')
  end
  -- compat for other resources like carhud
  TriggerEvent('seatbelt:stateChange', true)

  -- disable exit keys
  Citizen.CreateThread(function()
    while activated do
      Citizen.Wait(1)
      DisableControlAction(0, 75, true)
      DisableControlAction(27, 75, true)
    end
  end)

  -- quick unbuckled
  Citizen.CreateThread(function()
    while activated do
      Citizen.Wait(1)
      if IsDisabledControlJustPressed(0, 75) and IsControlPressed(0, 21) then
        DeactivateSeatbelt()
      end
    end
  end)

  -- validation
  Citizen.CreateThread(function()
    while activated do
      if not IsPedInAnyVehicle(PlayerPedId()) then
        DeactivateSeatbelt()
      end
      Citizen.Wait(50)
    end
  end)

  activated = true
end

function DeactivateSeatbelt()
  if activated == false then
    return error('seatbelt attempted to deactivate when already deactivated.')
  end
  TriggerEvent('seatbelt:stateChange', false)

  -- help text separate from hud
  Citizen.CreateThread(function()
    while not activated do
      if showHelp then
        local message = '~BLIP_GANG_VEHICLE~ Press ~INPUT_REPLAY_SHOWHOTKEY~ to ~y~buckle~s~ your seatbelt.'
        ShowHelpText(message, newbieBeep)
        newbieBeep = false
        for _ = 0, 8 do
          Citizen.Wait(5)
          ShowHelpText(message, false)
        end
      end
      Citizen.Wait(65)
    end
  end)

  -- handling and HUD
  Citizen.CreateThread(function()
    while not activated do
      local ped = PlayerPedId()
      if IsPedInAnyVehicle(ped) then
        local _hasSeatbelt, strong = DoesPedVehicleHaveSeatbelt(ped)
        hasSeatbelt = _hasSeatbelt
        if hasSeatbelt and not strong then
          local vehicle = GetVehiclePedIsIn(ped)
          local speed = GetEntitySpeed(vehicle)

          if speed > (50 / 3.6) and (lastSpeed - speed) > (speed * .2) then
            local coords = GetEntityCoords(ped)
            local fw = Fwv(ped)
            ForceStopWarning()
            showHelp = false
            SetEntityCoords(ped, coords.x + fw.x, coords.y + fw.y, coords.z - .47, true, true, true)
            SetEntityVelocity(ped, lastVelocity.x, lastVelocity.y, lastVelocity.z)
            SetPedToRagdoll(ped, 1e3, 1e3, 0, false, false, false)
          elseif speed > (20 / 3.6) then
            SetWarning(true)
            showHelp = not (IsPauseMenuActive() or IsHudHidden() or IsPlayerDead(PlayerId()))
          else
            SetWarning(false)
            showHelp = false
          end

          lastSpeed = speed
          lastVelocity = GetEntityVelocity(vehicle)
        end
      else
        ForceStopWarning()
        showHelp = false
      end
      Citizen.Wait(50)
    end

    SetWarning(false)
    showHelp = false
  end)

  -- notification
  Citizen.CreateThread(function()
    while not activated do
      local ped = PlayerPedId()
      local vehicle = GetVehiclePedIsIn(ped)
      if IsPedInAnyVehicle(ped) and hasSeatbelt and GetEntitySpeed(vehicle) * 3.6 > 10 then
        TriggerServerEvent('seatbelt:ServerNotify')
      end
      Citizen.Wait(3e3)
    end
  end)

  activated = false
end

function SetWarning(bool)
  if bool ~= showingWarning then
    SendNuiMessage('{"t":1,"d":' .. (bool == true and '1' or '0') .. '}')
    showingWarning = bool
  end
end

function ForceStopWarning()
  if showingWarning then
    SendNuiMessage('{"t":1,"d":3}')
    showingWarning = false
  end
end

RegisterNetEvent('seatbelt:ClientNotify', function(serverId)
  local ped = PlayerPedId()
  local player = GetPlayerFromServerId(serverId) -- onesync notice: returns -1 if not loaded
  local playerPed = GetPlayerPed(player)
  if player ~= PlayerId() and player > 0 and IsLEO() and not IsHudHidden() and IsPedInAnyVehicle(playerPed) then
    local vehicle = GetVehiclePedIsIn(playerPed)
    local identifier = GetPlayerIdentifier_(serverId, playerPed, vehicle)
    if #(GetEntityCoords(ped) - GetEntityCoords(GetPlayerPed(player))) < Constants.Distance and identifier then
      ShowNotification(
        identifier ..
        ' is not weaing a seatbelt in <C>~y~' ..
        GetVehicleNumberPlateText(vehicle) ..
        '~s~</C>.'
      )
    end
  end
end)


Citizen.CreateThread(function()
  DeactivateSeatbelt()
end)