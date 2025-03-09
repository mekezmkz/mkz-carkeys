local targhe = {}

function haChiavi(targaVeh)
    for k, v in ipairs(targhe) do
        if tostring(v) == tostring(targaVeh) then
            return true
        end
    end
    return false
end

RegisterNetEvent('clubhouse_custom:vehcall', function(targa)
	if not haChiavi(targa) then
		table.insert(targhe, targa)
	end
end)

function ToggleVehicleLock()
	local playerPed = cache.ped
	local veh, distance = ESX.Game.GetClosestVehicle()
    if distance <= 5.0 and distance > -1 and distance ~= -1 then
        local targaVeicolo = ESX.Math.Trim(GetVehicleNumberPlateText(veh))
		ESX.TriggerServerCallback('clubhouse_script:ControllaChiavi', function(isProprietario)
			if isProprietario or haChiavi(targaVeicolo) then
				local dict = 'anim@mp_player_intmenu@key_fob@'
				ESX.Streaming.RequestAnimDict(dict)
				TaskPlayAnim(playerPed, dict, 'fob_click_fp', 8.0, 8.0, -1, 48, 1, false, false, false)
				Citizen.Wait(125)
				local statoVeicolo = GetVehicleDoorLockStatus(veh)
				if statoVeicolo == 1 then 
					NetworkRequestControlOfEntity(veh)

					while not NetworkHasControlOfEntity(veh) do
						NetworkRequestControlOfEntity(veh)
						Wait(50)
					end

					SetVehicleDoorsLocked(veh, 2)
					PlayVehicleDoorCloseSound(veh, 1)
					ESX.ShowNotification('Hai chiuso il tuo veicolo','success')
				elseif statoVeicolo == 2 then 
					NetworkRequestControlOfEntity(veh)

					while not NetworkHasControlOfEntity(veh) do
						NetworkRequestControlOfEntity(veh)
						Wait(50)
					end

					SetVehicleDoorsLocked(veh, 1)
					PlayVehicleDoorOpenSound(veh, 0)
					ESX.ShowNotification('Hai aperto il tuo veicolo', 'warning')
				else
					ESX.ShowNotification('Errore!', 'error')
				end
			else
				ESX.ShowNotification('Il veicolo non è tuo', 'error')
				return
			end
		end, targaVeicolo)
	else
		ESX.ShowNotification('Nessun veicolo nelle vicinanze', 'error')
		return
	end
end

RegisterCommand('_ApriVeicolo', ToggleVehicleLock)

RegisterKeyMapping('_ApriVeicolo', 'Apri/Chiudi Veicolo', 'keyboard', 'U')
