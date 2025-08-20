Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        SetPedDensityMultiplierThisFrame(0.0)
        SetVehicleDensityMultiplierThisFrame(0.0)
        SetRandomVehicleDensityMultiplierThisFrame(0.0)
        SetParkedVehicleDensityMultiplierThisFrame(0.0)
        SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)

        SetCreateRandomCops(false)
        SetCreateRandomCopsNotOnScenarios(false)
        SetCreateRandomCopsOnScenarios(false)
        SetRandomBoats(false)
        SetGarbageTrucks(false)

        MuteAmbientSound(true)
        MuteVehicleAudio(true)
        DistantCopCarSirens(false)
        SetVehicleRadioEnabled(PlayerPedId(), false)
        SetUserRadioControlEnabled(false)
        SetFrontendRadioActive(false)
        StopAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
        StopAudioScene("MP_LEADERBOARD_SCENE")
        StopAudioScene("DLC_MPHEIST\\HEIST_HACKING_SNAKE")

        local peds = GetGamePool('CPed')
        for _, ped in ipairs(peds) do
            if not IsPedAPlayer(ped) and DoesEntityExist(ped) and not IsEntityDead(ped) then
                ClearPedTasksImmediately(ped)
                SetEntityAsMissionEntity(ped, true, true)
                DeletePed(ped)
            end
        end

        local vehicles = GetGamePool('CVehicle')
        for _, vehicle in ipairs(vehicles) do
            if DoesEntityExist(vehicle) and not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1)) then
                SetVehicleEngineOn(vehicle, false, true, true)
                SetVehicleSiren(vehicle, false)
                SetEntityAsMissionEntity(vehicle, true, true)
                DeleteVehicle(vehicle)
            end
        end
    end
end)
