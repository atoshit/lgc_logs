---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

local GPIBT <const> = GetPlayerIdentifierByType

local gameName <const> = lgc.gameName
local serverLogo <const> = lgc.adjustments.serverLogo

---@param entity number Entity
---@return boolean
local function isPlayerDead(entity)
    return GetEntityHealth(entity) <= 0
end

---@param player number Player
---@param esx boolean
---@return table
local function getPlayerInfos(player, esx)
    local data = {}

    local playerPed = GetPlayerPed(player)

    data.name = GetPlayerName(player) or 'Unknown'
    data.license = GPIBT(player, 'license') or 'Unknown'
    data.license2 = GPIBT(player, 'license2') or 'Unknown'
    data.steam = GPIBT(player, 'steam') or 'Unknown'
    data.discord = GPIBT(player, 'discord') or 'Unknown'
    data.xbl = GPIBT(player, 'xbl') or 'Unknown'
    data.live = GPIBT(player, 'live') or 'Unknown'
    data.fivem = GPIBT(player, 'fivem') or 'Unknown'
    data.ip = GetPlayerEndpoint(player) or 'Unknown'

    if esx then
        data.isDead = isPlayerDead(playerPed)
        local position = GetEntityCoords(playerPed)
        data.position = position.x .. ',' .. position.y .. ',' .. position.z
        data.job = lgc.getPlayerJob(player)
        data.group = lgc.getPlayerGroup(player)
        data.accounts = lgc.getPlayerAccounts(player)
        data.rpname = lgc.getPlayerName(player)
    end

    return data
end

if lgc.adjustments.logs.playerLeave then

    local function onPlayerDropped(reason)
        if not lgc.webhooks['playerLeave'] or type(lgc.webhooks['playerLeave']) ~= 'string' or lgc.webhooks['playerLeave'] == '' then 
            return lgc.debug('Player leave webhook not found, please check the config in lgc_logs/shared/configs/webhooks.lua', 'warn')
        end

        local _source = source
        local data = getPlayerInfos(_source, true)
        
        return lgc.discordLogs.send(lgc.webhooks['playerLeave'], {
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

    AddEventHandler('playerDropped', onPlayerDropped)
end

if lgc.adjustments.logs.playerJoin then

    local function onPlayerConnecting(name)
        if not lgc.webhooks['playerJoin'] or type(lgc.webhooks['playerJoin']) ~= 'string' or lgc.webhooks['playerJoin'] == '' then 
            return lgc.debug('Player join webhook not found, please check the config in lgc_logs/shared/configs/webhooks.lua', 'warn')
        end

        local _source = source
        local data = getPlayerInfos(_source, false)

        return lgc.discordLogs.send(lgc.webhooks['playerJoin'], {
            username = gameName,
            avatar_url = serverLogo,
            embed = {
                title = lgc.locale('playerJoin_title'),
                description = lgc.locale('playerJoin_description'),
                color = 40507, 
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
                        value = name,
                        inline = true
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

    AddEventHandler('playerConnecting', onPlayerConnecting)
end

if lgc.adjustments.logs.resources then
    local function onResourceStart(resource)
        if not lgc.webhooks['resources'] or type(lgc.webhooks['resources']) ~= 'string' or lgc.webhooks['resources'] == '' then
            return lgc.debug('Resources webhook not found, please check the config in lgc_logs/shared/configs/webhooks.lua', 'warn')
        end

        return lgc.discordLogs.send(lgc.webhooks['resources'], {
            username = gameName,
            avatar_url = serverLogo,
            embed = {
                title = lgc.locale('resource_start_title'),
                description = lgc.locale('resource_start_description'),
                color = 40507,
                footer = {
                    text = "Made by Logic. Studios (Atoshi)"
                    --icon_url = serverLogo
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
                fields = {
                    {
                        name = lgc.locale('resource_name'),
                        value = resource,
                        inline = true
                    },
                    {
                        name = lgc.locale('version'),
                        value = GetResourceMetadata(resource, 'version') or 'Unknown',
                        inline = true
                    },
                    {
                        name = lgc.locale('author'),
                        value = GetResourceMetadata(resource, 'author') or 'Unknown',
                        inline = true
                    },
                    {
                        name = lgc.locale('description'),
                        value = GetResourceMetadata(resource, 'description') or 'Unknown',
                        inline = false
                    }
                }
            }
        })
    end

    local function onResourceStop(resource)
        if not lgc.webhooks['resources'] or type(lgc.webhooks['resources']) ~= 'string' or lgc.webhooks['resources'] == '' then
            return lgc.debug('Resources webhook not found, please check the config in lgc_logs/shared/configs/webhooks.lua', 'warn')
        end

        return lgc.discordLogs.send(lgc.webhooks['resources'], {
            username = gameName,
            avatar_url = serverLogo,
            embed = {
                title = lgc.locale('resource_stop_title'),
                description = lgc.locale('resource_stop_description'),
                color = 16711680,
                footer = {
                    text = "Made by Logic. Studios (Atoshi)"
                    --icon_url = serverLogo
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
                fields = {
                    {
                        name = lgc.locale('resource_name'),
                        value = resource,
                        inline = true
                    },
                    {
                        name = lgc.locale('version'),
                        value = GetResourceMetadata(resource, 'version') or 'Unknown',
                        inline = true
                    },
                    {
                        name = lgc.locale('author'),
                        value = GetResourceMetadata(resource, 'author') or 'Unknown',
                        inline = true
                    },
                    {
                        name = lgc.locale('description'),
                        value = GetResourceMetadata(resource, 'description') or 'Unknown',
                        inline = false
                    }
                }
            }
        })
    end

    AddEventHandler('onResourceStop', onResourceStop)
    AddEventHandler('onResourceStart', onResourceStart)
end