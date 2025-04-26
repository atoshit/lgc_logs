---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

local gameName <const> = lgc.gameName
local serverLogo <const> = lgc.adjustments.serverLogo

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
    local position = GetEntityCoords(playerPed)
    data.position = position.x .. ',' .. position.y .. ',' .. position.z
    data.job = lgc.getPlayerJob(player)
    data.group = lgc.getPlayerGroup(player)
    data.accounts = lgc.getPlayerAccounts(player)
    data.rpname = lgc.getPlayerName(player)

    return data
end

if lgc.adjustments.playerLeave then
AddEventHandler('playerDropped', function(reason)
    local _source = source
    local data = getPlayerInfos(_source)
    
    lgc.discordLogs.send(lgc.webhooks['playerLeave'], {
        username = gameName,
        avatar_url = serverLogo,
        embed = {
            title = lgc.locale('playerLeave_title'),
            description = lgc.locale('playerLeave_description') .. ' : ' .. reason,
            color = 16711680, 
            footer = {
                text = "Made by Logic. Studios (Atoshi)"
                --icon_url = serverLogo
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
            fields = {
                {
                    name = lgc.locale('id'),
                    value = _source,
                    inline = true
                },
                {
                    name = lgc.locale('name'),
                    value = data.name,
                    inline = true
                },
                {
                    name = lgc.locale('rpname'),
                    value = data.rpname,
                    inline = true
                },
                {
                    name = lgc.locale('group'),
                    value = data.group,
                    inline = true
                },
                {
                    name = lgc.locale('job'),
                    value = data.job.label,
                    inline = true
                },
                {
                    name = lgc.locale('isDead'),
                    value = data.isDead,
                    inline = true
                },
                {
                    name = lgc.locale('position'),
                    value = data.position,
                    inline = false
                },
                {
                    name = lgc.locale('license'),
                    value = data.license,
                    inline = false
                },
                {
                    name = lgc.locale('license2'),
                    value = data.license2,
                    inline = false
                },
                {
                    name = lgc.locale('steam'),
                    value = data.steam,
                    inline = false
                },
                {
                    name = lgc.locale('discord'),
                    value = "<@" .. string.gsub(data.discord, "discord:", "") .. ">",
                    inline = false
                },
                {
                    name = lgc.locale('xbl'),
                    value = data.xbl,
                    inline = false
                },
                {
                    name = lgc.locale('live'),
                    value = data.live,
                    inline = false
                },
                {
                    name = lgc.locale('fivem'),
                    value = data.fivem,
                    inline = false
                },
                {
                    name = lgc.locale('ip'),
                    value = data.ip,
                    inline = false
                }
            }
        }
        }, 1) 
    end
end)