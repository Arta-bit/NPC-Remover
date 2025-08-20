Citizen.CreateThread(function()
    local DM = 0.0
    while true do
        SetGarbageTrucks(false)
        SetRandomBoats(false)
        SetCreateRandomCops(false)
        SetCreateRandomCopsNotOnScenarios(false)
        SetCreateRandomCopsOnScenarios(false)

        SetVehicleDensityMultiplierThisFrame(DM)
        SetPedDensityMultiplierThisFrame(DM)
        SetRandomVehicleDensityMultiplierThisFrame(DM)
        SetParkedVehicleDensityMultiplierThisFrame(DM)
        SetScenarioPedDensityMultiplierThisFrame(DM, DM)

        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
        ClearAreaOfVehicles(x, y, z, 100, false , false , false , false , false )
        RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0 , x + 500.0, y + 500.0, z + 500.0 )

        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        local a = PlayerPedId()
        local b = GetVehiclePedIsIn(a, false)

        SetUserRadioControlEnabled(false)
        SetFrontendRadioActive(false)
        if b ~= 0 then
            SetVehRadioStation(b, "OFF")
        end

        DistantCopCarSirens(false)
        CancelCurrentPoliceReport()
        StopAllAlarms(true)
        StopAudioScenes()

        SetAudioFlag("DisableFlightMusic", true)
        SetAudioFlag("WantedMusicDisabled", true)
        SetAudioFlag("PoliceScannerDisabled", true)

        for _, ped in ipairs(GetGamePool('CPed')) do
            if ped ~= a then
                DisablePedPainAudio(ped, true)
                StopPedSpeaking(ped, true)
            end
        end

        Citizen.Wait(10)
    end
end)

function StopAudioScenes()
    local scenes = {
        "CHARACTER_CHANGE_IN_SKY_SCENE",
        "FBI_HEIST_H5_MUTE_AMBIENCE_SCENE",
        "DLC_MPHEIST/HEIST_FLEE_SCENE"
    }
    for _, scene in ipairs(scenes) do
        StopAudioScene(scene)
    end
end
