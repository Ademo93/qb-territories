local minGangMemberConnected = 0
local QBCore = exports['qb-core']:GetCoreObject()

function checkGroup(table, val)
    for k, v in pairs(table) do
        if val == v.label then
            return true
        end
    end
    return false
end

function removeGroup(tab, val)
    for k, v in pairs(tab) do
        if v.label == val then
            tab[k] = nil
        end
    end
end

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

RegisterNetEvent("qb-gangs:server:updateterritories")
AddEventHandler("qb-gangs:server:updateterritories", function(zone, inside)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Gang = Player.PlayerData.gang
    local gangMemberConnected = 0
    Territory = Zones["Territories"][zone]

    if Territory ~= nil then
        -- If they're not in a gang or they're not a cop just ignore them
        if Gang.name ~= "none" then
            if inside then
                if not checkGroup(Territory.occupants, Gang.label) then
                    Territory.occupants[Gang.label] = {
                        label = Gang.label,
                        score = 0
                    }
                else
                    for k, v in pairs(QBCore.Functions.GetPlayers()) do
                        local Player = QBCore.Functions.GetPlayer(v)
                        if Player ~= nil then
                            if (Player.PlayerData.gang.name == Territory.occupants[Gang.label]) then
                                gangMemberConnected = gangMemberConnected + 1
                            end
                        end
                    end
                    if gangMemberConnected >= minGangMemberConnected then
                        local score = Territory.occupants[Gang.label].score
                        if score < Zones["Config"].minScore and Territory.winner ~= Gang.label then
                            if isContested(Territory.occupants) == "" then
                                Territory.occupants[Gang.label].score = Territory.occupants[Gang.label].score + 1
                                TriggerClientEvent('QBCore:Notify',source,"Capturing Turf. Progress "..Territory.occupants[Gang.label].score.."/"..Zones["Config"].minScore, "info", 50)
                                if Territory.occupants[Gang.label].score == 5 then
                                    -- you can add custom event for notification on this line. TriggerEvent('template:server:sendchatmessage', "A Turf war zone is being captured. Gang members, hurry up and intercept!", "fa-solid fa-skull", "Turf War", "#cccccc") --message, icon, category, color(hex)
                                end
                            else
                                TriggerClientEvent('QBCore:Notify',source,"You are being contested by another gang! Kill them all!", "error", 50)
                            end
                        else
                            Territory.winner = Gang.label
                            TriggerClientEvent("qb-gangs:client:updateblips", source, zone, Gang.label)                
                            --print("success "..Gang.name)
                            Wait(1000)
                        end
                    else
                            --TriggerClientEvent('QBCore:Notify',src,Lang:t("error.member_not_connected"),"error")
                    end
                   
                end
            else
                removeGroup(Territory.occupants, Gang.label)
            end
        end
    end
end)

RegisterNetEvent("qb-territories:server:addmoney", function(amount)
    for k, t in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(t)
        local Gang = Player.PlayerData.gang
        print(Gang.label.." / "..Territory.winner)
        if Gang.label == Territory.winner then
            Player.Functions.AddMoney('cash', amount)
            
        end
    end
end)
