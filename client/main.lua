local Territories = {}
local insidePoint = false
local activeZone = nil

local QBCore = exports['qb-core']:GetCoreObject()

isLoggedIn = false
PlayerGang = {}
PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerGang = QBCore.Functions.GetPlayerData().gang
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate')
AddEventHandler('QBCore:Client:OnGangUpdate', function(GangInfo)
    PlayerGang = GangInfo
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnGangUpdate', function(JobInfo)
    PlayerJob = JobInfo
    isLoggedIn = true
end)

CreateThread(function()
    Wait(500)
    for k, v in pairs(Zones["Territories"]) do
        local zone = CircleZone:Create(v.centre, v.radius, {
            name = "greenzone-"..k,
            debugPoly = Zones["Config"].debug,
        })

        local blip = AddBlipForRadius(v.centre.x, v.centre.y, v.centre.z, v.radius)
        SetBlipAlpha(blip, 80) -- Change opacity here
        SetBlipColour(blip, Zones["Colours"][v.winner] ~= nil and Zones["Colours"][v.winner] or Zones["Colours"].neutral)


        local blip2 = AddBlipForCoord(v.centre.x, v.centre.y, v.centre.z)
        SetBlipSprite (blip2, v.blip)
        SetBlipDisplay(blip2, 4)
        SetBlipAsShortRange(blip2, true)
        SetBlipColour(blip2, Zones["Colours"][v.winner] ~= nil and Zones["Colours"][v.winner] or Zones["Colours"].neutral)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(v.winner)
        EndTextCommandSetBlipName(blip2)

        Territories[k] = {
            zone = zone,
            id = k,
            blip = blip
        }
    end
end)

CreateThread(function()
    while true do 
        Wait(500)
        if isLoggedIn then
            
                local PlayerPed = PlayerPedId()
                local pedCoords = GetEntityCoords(PlayerPed)

                for k, zone in pairs(Territories) do
                    if Territories[k].zone:isPointInside(pedCoords) then
                        insidePoint = true
                        activeZone = Territories[k].id
                        
                        TriggerEvent("QBCore:Notify",Lang:t("error.enter_gangzone"), "error")

                       
                        while insidePoint == true do
                            
                           
                                exports['qb-drawtext']:DrawText(Lang:t("error.hostile_zone"),'right')
                            
                           
                            

                            if not Territories[k].zone:isPointInside(GetEntityCoords(PlayerPed)) then

                                insidePoint = false
                                activeZone = nil

                                QBCore.Functions.Notify(Lang:t("error.leave_gangzone"), "error")

                                Wait(1000)

                            end

                            Wait(1000)
                        end
                        exports['qb-drawtext']:HideText()
                    end
                end
                Wait(2000)
         
        end
    end
end)

