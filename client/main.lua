local vthirst
local vhunger
Citizen.CreateThread(function ()
    while true do
        if Framework == "esx" then
            while not ESX.PlayerLoaded do
                Citizen.Wait(0)
            end
            TriggerEvent("esx_status:getStatus",'hunger',function(status)
                vhunger = status.val / 10000
            end)
            TriggerEvent("esx_status:getStatus",'thirst',function(status)
                vthirst = status.val / 10000
            end)
        elseif Framework == "qb" then
            while not NetworkIsPlayerActive(PlayerId()) do
                Citizen.Wait(0)
            end
        else
            -- custom waiting loading
        end
        local playerped = PlayerPedId()
        local vhealth = (GetEntityHealth(playerped) /2)
        local varmor = (GetPedArmour(playerped) / 2)
        SendNUIMessage({basicneed = true,thirst = vthirst,hunger = vhunger,health = vhealth,armor = varmor})
        Citizen.Wait(1000)
    end
end)


Citizen.CreateThread(function ()
        while true do
            if IsPauseMenuActive() and not IsPaused then
                IsPaused = true
                SendNUIMessage({toggleUI = true, value = IsPaused})
            elseif not IsPauseMenuActive() and IsPaused then
                IsPaused = false
                SendNUIMessage({toggleUI = true, value = IsPaused})
            end
            Citizen.Wait(250)
        end
end)

AddEventHandler("pma-voice:setTalkingMode",function(mode)
        SendNUIMessage({number = mode,voice = true})
end)


Citizen.CreateThread(function ()
    while true do
        if MumbleIsPlayerTalking(PlayerId()) then
            SendNUIMessage({voiceEnabled = true, value = true})
        elseif not MumbleIsPlayerTalking(PlayerId()) then
            SendNUIMessage({voiceEnabled = true, value = false})
        end
        Citizen.Wait(250)
    end
end)

-- Minimap


Citizen.CreateThread(function()
    if Config.disableRadarInFoot then
        while true do
            local PlayerPed = PlayerPedId()

            local radarEnabled = IsRadarEnabled()

            if not IsPedInAnyVehicle(PlayerPed,false) and radarEnabled then
                DisplayRadar(false)
            elseif IsPedInAnyVehicle(PlayerPed,false) and not radarEnabled then
                DisplayRadar(true)
            end
            Citizen.Wait(500)
        end
    end
end)

-- Service Job
RegisterNetEvent("e_hud:updateTimeService",function (time)
    if Config.jobService then
        time = time
    else
        time = 0
    end
    SendNUIMessage({timeEnabled = true, value = time})
end)