---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

---@param entity number Entity
---@return boolean
local function isPlayerDead(entity)
    return GetEntityHealth(entity) <= 0
end

---@param player number Player
---@return table
local function getPlayerInfos(player)
    local data = {}

    local playerPed = GetPlayerPed(player)

    data.name = GetPlayerName(player) or 'Unknown'
    data.license = GetPlayerIdentifierByType(player, 'license') or 'Unknown'
    data.license2 = GetPlayerIdentifierByType(player, 'license2') or 'Unknown'
    data.steam = GetPlayerIdentifierByType(player, 'steam') or 'Unknown'
    data.discord = GetPlayerIdentifierByType(player, 'discord') or 'Unknown'
    data.xbl = GetPlayerIdentifierByType(player, 'xbl') or 'Unknown'
    data.live = GetPlayerIdentifierByType(player, 'live') or 'Unknown'
    data.fivem = GetPlayerIdentifierByType(player, 'fivem') or 'Unknown'
    data.ip = GetPlayerEndpoint(player) or 'Unknown'
    data.isDead = isPlayerDead(playerPed)
    data.position = GetEntityCoords(playerPed)

    return data
end

AddEventHandler('playerDropped', function(reason)
    local player = source
    
    local playerInfos = getPlayerInfos(player)
    
    if playerInfos then 
    end
end)

