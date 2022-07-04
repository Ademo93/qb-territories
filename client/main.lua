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
        SetBlipColour(blip, Zones["Gangs"][v.winner].color ~= nil and Zones["Gangs"][v.winner].color or Zones["Gangs"]["neutral"].color)


        local blip2 = AddBlipForCoord(v.centre.x, v.centre.y, v.centre.z)
        SetBlipSprite (blip2, v.blip)
        SetBlipDisplay(blip2, 4)
        SetBlipScale(blip2, 0.8)
        SetBlipAsShortRange(blip2, true)
        SetBlipColour(blip2, Zones["Gangs"][v.winner].color ~= nil and Zones["Gangs"][v.winner].color or Zones["Gangs"]["neutral"].color)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Zones["Gangs"][v.winner].name)
        EndTextCommandSetBlipName(blip2)

        Territories[k] = {
            zone = zone,
            id = k,
            blip = blip
        }
    end
end)

RegisterNetEvent("qb-gangs:client:updateblips")
AddEventHandler("qb-gangs:client:updateblips", function(zone, winner)
    local colour = Zones["Colours"][winner]
   -- local blip = AddBlipForRadius(Zones["Territories"][zone].centre.x, Zones["Territories"][zone].centre.y, Zones["Territories"][zone].centre.z, Zones["Territories"][zone].radius)
    local blip = Territories[zone].blip
    SetBlipColour(blip,colour)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(winner)
    EndTextCommandSetBlipName(blip)


 
end)

function isContested(tab)
    local count = 0
    for k, v in pairs(tab) do
        count = count + 1
    end

    if count > 1 then
        return "contested"
    end
    return ""
end

CreateThread(function()
    while true do 
        Wait(500)
        if isLoggedIn then
            
            local PlayerPed = PlayerPedId()
            local pedCoords = GetEntityCoords(PlayerPed)
                    
            for k, v in pairs(Zones["Territories"]) do
    
                while isContested(v.occupants) == "contested" do
                    for i,v in pairs((v.occupants)) do
                        last = #(v.occupants) - 0
                    end

                    --local blip = AddBlipForRadius(v.centre.x, v.centre.y, v.centre.z, v.radius)
                    --SetBlipAlpha(blip, 80) -- Change opacity here
                    --SetBlipColour(blip, Zones["Gangs"][v.winner].color ~= nil and Zones["Gangs"][v.winner].color or Zones["Gangs"]["neutral"].color)
                    --Wait(100)
                    --SetBlipAlpha(blip, 80) -- Change opacity here
                    --SetBlipColour(blip,Zones["Gangs"][v.last.label].color)
                    
                end
            end 

            for k, zone in pairs(Territories) do  

                if Territories[k].zone:isPointInside(pedCoords) then
                    insidePoint = true
                    activeZone = Territories[k].id
                        
                    TriggerEvent("QBCore:Notify",Lang:t("error.enter_gangzone"), "error")
          
                    while insidePoint == true do   
                        exports['qb-drawtext']:DrawText(Lang:t("error.hostile_zone"),'right')
                        if PlayerGang.name ~= "none" then
                            TriggerServerEvent("qb-gangs:server:updateterritories", activeZone, true) 
                        end   
                        if not Territories[k].zone:isPointInside(GetEntityCoords(PlayerPed)) then

                            if PlayerGang.name ~= "none" then
                                TriggerServerEvent("qb-gangs:server:updateterritories", activeZone, false)
                            end
                            insidePoint = false
                            activeZone = nil
                            QBCore.Functions.Notify(Lang:t("error.leave_gangzone"), "error")
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

