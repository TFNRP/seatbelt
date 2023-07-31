RegisterNetEvent('seatbelt:ServerNotify', function()
  TriggerClientEvent('seatbelt:ClientNotify', -1, source)
end)

RegisterNetEvent('seatbelt:ServerHasAce', function()
  TriggerClientEvent('seatbelt:ClientHasAce', source, IsPlayerAceAllowed(source, 'seatbelt.notify'))
end)