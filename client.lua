local showingWarning = false
local lastSpeed = 0
local lastVelocity = vector3(0, 0, 0)
local newbieBeep = true
local showHelp = false
local activated

RegisterKeyMapping('seatbelt', 'Seatbelt', 'keyboard', 'k')
RegisterFrameworkCommand('seatbelt', function()
  local ped = PlayerPedId()
  if IsPedInAnyVehicle(ped) and DoesPedVehicleHaveSeatbelt(ped) then
    if activated then
      DeactivateSeatbelt()
    else
      ActivateSeatbelt()
    end
  end
end)

function ActivateSeatbelt()
  if activated == true then
    return error("seatbelt attempted to activate when already active.")
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
    return error("seatbelt attempted to deactivate when already deactivated.")
  end
  TriggerEvent('seatbelt:stateChange', false)

  -- HUD
  Citizen.CreateThread(function()
    while not activated do
      Citizen.Wait(2e3)
      local ped = PlayerPedId()
      if IsPedInAnyVehicle(ped) and DoesPedVehicleHaveSeatbelt(ped) and not IsHudHidden() then
        local vehicle = GetVehiclePedIsIn(ped)
        local speed = GetEntitySpeed(vehicle) * 3.6

        if speed > 20 and not (IsPlayerDead(PlayerId()) or IsPauseMenuActive()) then
          SetWarning(true)
          showHelp = true
        else
          SetWarning(false)
          showHelp = false
        end
      else
        SetWarning(false)
        showHelp = false
      end
    end
  end)

  -- help text separate from hud
  Citizen.CreateThread(function()
    while not activated do
      Citizen.Wait(65)
      if showHelp then
        ShowHelpText('~BLIP_GANG_VEHICLE~ Press ~INPUT_REPLAY_SHOWHOTKEY~ to ~y~buckle~s~ your seatbelt.', newbieBeep)
        newbieBeep = false
      end
    end
  end)

  -- handling
  Citizen.CreateThread(function()
    while not activated do
      Citizen.Wait(50)
      local ped = PlayerPedId()
      if IsPedInAnyVehicle(ped) then
        if DoesPedVehicleHaveSeatbelt(ped) then

          local vehicle = GetVehiclePedIsIn(ped)
          local speed = GetEntitySpeed(vehicle)

          if speed > (50 / 3.6) and (lastSpeed - speed) > (speed * .2) then
            local coords = GetEntityCoords(ped)
            local fw = Fwv(ped)
            SetEntityCoords(ped, coords.x + fw.x, coords.y + fw.y, coords.z - .47, true, true, true)
            SetEntityVelocity(ped, lastVelocity.x, lastVelocity.y, lastVelocity.z)
            SetPedToRagdoll(ped, 1e3, 1e3, 0, false, false, false)
          end

          lastSpeed = speed
          lastVelocity = GetEntityVelocity(vehicle)
        end
      end
    end
  end)

  -- notification
  Citizen.CreateThread(function()
    while not activated do
      Citizen.Wait(3e3)
      local ped = PlayerPedId()
      local vehicle = GetVehiclePedIsIn(ped)
      if IsPedInAnyVehicle(ped) and DoesPedVehicleHaveSeatbelt(ped) and GetEntitySpeed(vehicle) * 3.6 > 10 then
        TriggerServerEvent('seatbelt:ServerNotify')
      end
    end
  end)

  activated = false
end

function SetWarning (bool)
  if bool then
    if not showingWarning then
      SendNUIMessage({ SeatbeltUIWarning = true })
      showingWarning = true
    end
  else
    if showingWarning then
      SendNUIMessage({ SeatbeltUIWarning = false })
      showingWarning = false
    end
  end
end

RegisterNetEvent('seatbelt:ClientNotify', function(serverId)
  local ped = PlayerPedId()
  local player = GetPlayerFromServerId(serverId)
  local vehicle = GetVehiclePedIsIn(ped)
  if IsLEO() and not IsHudHidden() then -- player ~= PlayerId() and
    print(#(GetEntityCoords(ped) - GetEntityCoords(GetPlayerPed(player))))
    if #(GetEntityCoords(ped) - GetEntityCoords(GetPlayerPed(player))) < 19.999 then
      ShowNotification('<C>Player ' .. serverId .. '</C> is not weaing a seatbelt in <C>~y~' .. GetVehicleNumberPlateText(vehicle) .. '~s~</C>.')
    end
  end
end)

DeactivateSeatbelt()