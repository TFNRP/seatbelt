RegisterNetEvent('seatbelt:ServerNotify', function()
  TriggerClientEvent('seatbelt:ClientNotify', -1, source)
end)