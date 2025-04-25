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
        if not Player then return {id = 0, name = 'Unknown', label = 'Unknown', grade = 0, grade_name = 'Unknown', grade_label = 'Unknown', grade_salary = 0, skin_male = nil, skin_female = nil } end

        local job = Player.PlayerData.job
        return {
            id = job.id or 0,
            name = job.name or 'Unknown',
            label = job.label or 'Unknown',
            grade = job.grade.level or 0,
            grade_name = job.grade.name or 'Unknown',
            grade_label = job.grade.label or 'Unknown',
            grade_salary = job.payment or 0,
            skin_male = nil, -- QBCore ne gère pas les skins comme ESX
            skin_female = nil
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
            bank = Player.PlayerData.money['bank'] or 0,
            black_money = Player.PlayerData.money['crypto'] or 0 -- QBCore utilise 'crypto' au lieu de 'black_money'
        }
    end

    ---@param player number Player
    ---@return string
    local function getPlayerName(player)
        local Player = QBCore.Functions.GetPlayer(player)
        if not Player then return 'Unknown' end

        local charInfo = Player.PlayerData.charinfo
        return string.format('%s %s', charInfo.firstname or 'Unknown', charInfo.lastname or 'Unknown')
    end

    lgc.getPlayerJob = getPlayerJob
    lgc.getPlayerGroup = getPlayerGroup
    lgc.getPlayerAccounts = getPlayerAccounts
    lgc.getPlayerName = getPlayerName
end

