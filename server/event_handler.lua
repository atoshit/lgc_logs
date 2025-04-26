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
    data.position = GetEntityCoords(playerPed)
    data.job = lgc.getPlayerJob(player)
    data.group = lgc.getPlayerGroup(player)
    data.accounts = lgc.getPlayerAccounts(player)
    data.rpname = lgc.getPlayerName(player)

    --lgc.debug(json.encode(data, { indent = true }), 'info')

    return data
end

AddEventHandler('playerDropped', function(reason)
    print("playerDropped event triggered")
    local playerInfos = {}


    local player = source
    local playerPed = GetPlayerPed(player)

    playerInfos.name = GetPlayerName(player) or 'Unknown'
    playerInfos.license = GetPlayerIdentifierByType(player, 'license') or 'Unknown'
    playerInfos.license2 = GetPlayerIdentifierByType(player, 'license2') or 'Unknown'
    playerInfos.steam = GetPlayerIdentifierByType(player, 'steam') or 'Unknown'
    playerInfos.discord = GetPlayerIdentifierByType(player, 'discord') or 'Unknown'
    playerInfos.xbl = GetPlayerIdentifierByType(player, 'xbl') or 'Unknown'
    playerInfos.live = GetPlayerIdentifierByType(player, 'live') or 'Unknown'
    playerInfos.fivem = GetPlayerIdentifierByType(player, 'fivem') or 'Unknown'
    playerInfos.ip = GetPlayerEndpoint(player) or 'Unknown'
    playerInfos.isDead = isPlayerDead(playerPed)
    playerInfos.position = GetEntityCoords(playerPed)
    playerInfos.job = lgc.getPlayerJob(player)
    playerInfos.group = lgc.getPlayerGroup(player)
    playerInfos.accounts = lgc.getPlayerAccounts(player)
    playerInfos.rpname = lgc.getPlayerName(player)

    print(lgc.webhooks['playerLeave'])
    
    lgc.discordLogs.send(lgc.webhooks['playerLeave'], {
        username = gameName,
        avatar_url = serverLogo,
        --content = "⚠️ Action administrative importante",
        embed = {
            title = lgc.locales['playerLeave_title'],
            description = lgc.locales['playerLeave_description'],
            --url = "https://ton-panel-admin.com/bans/123",
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
            color = 16711680,
            footer = {
                text = "Made by Logic. Studios (Atoshi)",
                --icon_url = "https://ton-logo.png"
            },
            -- author = {
            --     name = "Admin Pierre",
            --     icon_url = "https://avatar-admin.png",
            --     url = "https://profil-admin.com"
            -- },
            fields = {
                {
                    name = lgc.locales['name'],
                    value = playerInfos.name,
                    inline = true
                },
                {
                    name = lgc.locales['id'],
                    value = player,
                    inline = true
                },
                {
                    name = lgc.locales['reason'],
                    value = reason,
                    inline = true
                },
                {
                    name = lgc.locales['job'],
                    value = playerInfos.job.name .. ' - ' .. playerInfos.job.label,
                    inline = true
                },
                {
                    name = lgc.locales['group'],
                    value = playerInfos.group,
                    inline = true
                },
                {
                    name = lgc.locales['money'],
                    value = playerInfos.accounts.money,
                    inline = true
                },
                {
                    name = lgc.locales['bank'],
                    value = playerInfos.accounts.bank,
                    inline = true
                },
                {
                    name = lgc.locales['rpname'],
                    value = playerInfos.rpname,
                    inline = true
                },
                {
                    name = lgc.locales['isDead'],
                    value = playerInfos.isDead,
                    inline = true
                },
                {
                    name = lgc.locales['position'],
                    value = playerInfos.position,
                    inline = false
                },
                {
                    name = lgc.locales['license'],
                    value = playerInfos.license,
                    inline = false
                },
                {
                    name = lgc.locales['license2'],
                    value = playerInfos.license2,
                    inline = false
                },
                {
                    name = lgc.locales['steam'],
                    value = playerInfos.steam,
                    inline = false
                },
                {
                    name = lgc.locales['discord'],
                    value = "<@" .. playerInfos.discord .. ">",
                    inline = false
                },
                {
                    name = lgc.locales['xbl'],
                    value = playerInfos.xbl,
                    inline = false
                },
                {
                    name = lgc.locales['live'],
                    value = playerInfos.live,
                    inline = false
                },
                {
                    name = lgc.locales['fivem'],
                    value = playerInfos.fivem,
                    inline = false
                },
                {
                    name = lgc.locales['ip'],
                    value = playerInfos.ip,
                    inline = false
                }
            }
        }
    }, 1, player)
end)


RegisterNetEvent('lgc_logs:testbridge', function()
    local source = source
    
    -- Debug prints
    lgc.debug('Test bridge triggered by ' .. source, 'info')
    
    -- Récupérer les infos du joueur
    local job = lgc.getPlayerJob(source)
    local group = lgc.getPlayerGroup(source)
    local accounts = lgc.getPlayerAccounts(source)
    local name = lgc.getPlayerName(source)
    
    -- Debug des données
    lgc.debug('Player data:', 'info')
    lgc.debug('Name: ' .. name, 'info')
    lgc.debug('Job: ' .. job.name, 'info')
    lgc.debug('Group: ' .. group, 'info')
    print(lgc.locales['playerLeave_title'])

    print(lgc.webhooks['playerLeave'])
    -- Envoyer le log Discord
    lgc.discordLogs.send(lgc.webhooks['playerLeave'], {
        username = "Test Bridge",
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        color = 16711680,
        footer = {
            text = "Made by Logic. Studios (Atoshi)",
            --icon_url = "https://ton-logo.png"
        },
        embed = {
            title = lgc.locales['playerLeave_title'],
            description = lgc.locales['playerLeave_description'],
            color = 3447003, -- Bleu
            fields = {
                {
                    name = "Joueur",
                    value = name,
                    inline = true
                },
                {
                    name = "Job",
                    value = job.name .. " (" .. job.label .. ")",
                    inline = true
                },
                {
                    name = "Groupe",
                    value = group,
                    inline = true
                },
                {
                    name = "Argent",
                    value = "Cash: $" .. accounts.money .. "\nBanque: $" .. accounts.bank,
                    inline = false
                }
            }
        }
    }, 1, source) -- Priorité 1 avec screenshot
end)