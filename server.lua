ESX.RegisterServerCallback('clubhouse_script:ControllaChiavi', function(source, cb, plate, idTarget)
    local src = source
    if idTarget then
        src = idTarget
    end
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        local found = MySQL.scalar.await('SELECT 1 FROM owned_vehicles WHERE owner = ? AND plate = ?', {xPlayer.identifier, plate})

        cb(found ~= nil)
    else 
        cb(false)
    end
end)
