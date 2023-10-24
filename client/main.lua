farm = false
blckkeys = false

CreateThread(function()
    for k, v in pairs(cl_config.zonen) do
        if v.blip then
            blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
            SetBlipSprite(blip, v.blip.id)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, v.blip.size)
            SetBlipColour(blip, v.blip.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(v.blip.name)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        sleep = true
        range = false
        coords = GetEntityCoords(PlayerPedId())
        for k, v in pairs(cl_config.zonen) do
            distance = #(coords - v.coords)
            if distance < v.markerdist then
                sleep = false
                DrawMarker(v.marker.typ, v.coords.x, v.coords.y, v.coords.z - v.marker.size, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 1.0, v.marker.color.r, v.marker.color.g, v.marker.color.b, v.marker.color.t, false, false, 2, false, nil, nil, false)
                if distance < v.farmdist then
                    range = true
                    if not farm and not IsEntityPlayingAnim(PlayerPedId(), "anim@mp_snowball", "pickup_snowball", 3) then
                        BeginTextCommandDisplayHelp('STRING')
                        if cl_config.language == 'de' then
                            AddTextComponentSubstringPlayerName('Drücke ~INPUT_CONTEXT~ um '..v.item..' zu Sammeln.')
                        elseif cl_config.language == 'en' then
                            AddTextComponentSubstringPlayerName('Press ~INPUT_CONTEXT~ to collect '..v.item)
                        end
                        EndTextCommandDisplayHelp(0, false, true, -1)
                        if IsControlJustReleased(0, 38) and IsPedOnFoot(PlayerPedId()) then
                            farm = true
                            DisableControlAction(0, 38)
                            RequestAnimDict('anim@mp_snowball')
                            while not HasAnimDictLoaded('anim@mp_snowball') do
                                Citizen.Wait(0)
                            end
                            TaskPlayAnim(GetPlayerPed(-1), 'anim@mp_snowball', 'pickup_snowball', 8.0, 8.0, -1, 0, 0, false, false, false)
                            TriggerServerEvent('veuqx:farming', v.item)
                            if cl_config.language == 'de' then
                                print('Du hast 1x '..v.item..' Gesammelt')
                            elseif cl_config.language == 'en' then
                                print('You have collected 1x '..v.item)
                            end
                            farm = false
                        end
                    end
                end
            end
        end
        if sleep then
            Wait(1200)
        end
    end
end)