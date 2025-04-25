---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

if lgc.isResourceActive('qb-core') then
    lgc.debug('QBCore bridge loaded', 'info')
    
    local QBCore = exports['qb-core']:GetCoreObject()

    ---@param player number Player
    ---@return table (id, name, label, grade, grade_name, grade_label, grade_salary, skin_male, skin_female)
    local function getPlayerJob(player)
        local Player = QBCore.Functions.GetPlayer(player)

        if not Player then return {name = 'Unknown', label = 'Unknown'} end

        local job = Player.PlayerData.job
        return {
            name = job.name or 'Unknown',
            label = job.label or 'Unknown',
        }
    end

    ---@param player number Player
    ---@return string
    local function getPlayerGroup(player)
        local Player = QBCore.Functions.GetPlayer(player)
        if not Player then return 'Unknown' end
        
        return Player.PlayerData.permission or 'user'
    end

    ---@param player number Player
    ---@return table (money, bank, black_money)
    local function getPlayerAccounts(player)
        local Player = QBCore.Functions.GetPlayer(player)

        if not Player then return {} end

        return {
            money = Player.PlayerData.money['cash'] or 0,
            bank = Player.PlayerData.money['bank'] or 0
        }
    end

    ---@param player number Player
    ---@return string
    local function getPlayerName(player)
        local Player = QBCore.Functions.GetPlayer(player)
        if not Player then return 'Unknown' end

        local firstname = Player.PlayerData.firstname or 'Unknown'
        local lastname = Player.PlayerData.lastname or 'Unknown'

        local name = firstname .. ' ' .. lastname

        return name
    end

    lgc.getPlayerJob = getPlayerJob
    lgc.getPlayerGroup = getPlayerGroup
    lgc.getPlayerAccounts = getPlayerAccounts
    lgc.getPlayerName = getPlayerName
end

