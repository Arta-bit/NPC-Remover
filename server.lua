a = nil

TriggerEvent('esx:getSharedObject', function(b) a = b end)

RegisterCommand("dv", function(b, c, d)
    e = a.GetPlayerFromId(b)
    if not e then return end
    TriggerClientEvent('dv:showNearbyVehicles', b)
end, false)
