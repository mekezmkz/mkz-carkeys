ESX.RegisterServerCallback('clubhouse_script:ControllaChiavi', function(source, cb, plate, idTarget)
    local src = source
    if idTarget then
        src = idTarget
    end

    -- Get the player object from the ID
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if xPlayer then
        -- Using oxmysql for query execution
        MySQL.scalar('SELECT 1 FROM owned_vehicles WHERE owner = ? AND plate = ?', {xPlayer.identifier, plate}, function(result)
            if result then
                cb(true)
            else
                cb(false)
            end
        end)
    else 
        -- If xPlayer is nil, return false
        cb(false)
    end
end)
