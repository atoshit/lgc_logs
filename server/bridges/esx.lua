---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

if lgc.isResourceActive('es_extended') then
    print('ESX bridge loaded')

    local ESX = exports['es_extended']:getSharedObject()

    ---@param player number Player
    ---@return table (id, name, label, grade, grade_name, grade_label, grade_salary, skin_male, skin_female)
    local function getPlayerJob(player)
        local xPlayer = ESX.GetPlayerFromId(player)
        return xPlayer.getJob() or {id = 0, name = 'Unknown', label = 'Unknown', grade = 0, grade_name = 'Unknown', grade_label = 'Unknown', grade_salary = 0, skin_male = nil, skin_female = nil }
    end
    ---@param player number Player
    ---@return string
    local function getPlayerGroup(player)
        local xPlayer = ESX.GetPlayerFromId(player)
        return xPlayer.getGroup() or 'Unknown'
    end
    ---@param player number Player
    ---@return table (money, bank, black_money)
    local function getPlayerAccounts(player)
        local xPlayer = ESX.GetPlayerFromId(player)
        return xPlayer.getAccounts() or {}
    end
    ---@param player number Player
    ---@return string
    local function getPlayerName(player)
        local xPlayer = ESX.GetPlayerFromId(player)
        return xPlayer.getName() or 'Unknown'
    end

    lgc.getPlayerJob = getPlayerJob
    lgc.getPlayerGroup = getPlayerGroup
    lgc.getPlayerAccounts = getPlayerAccounts
    lgc.getPlayerName = getPlayerName
end
