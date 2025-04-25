---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

if lgc.isResourceActive('es_extended') then
    lgc.debug('ESX bridge loaded', 'info')

    local ESX = exports['es_extended']:getSharedObject()

    ---@param player number Player
    ---@return table (name, label, grade, grade_name, grade_label, grade_salary)
    local function getPlayerJob(player)
        local xPlayer = ESX.GetPlayerFromId(player)

        if not xPlayer then return {name = 'Unknown', label = 'Unknown'} end

        local job = xPlayer.getJob()
        return {
            name = job.name or 'Unknown',
            label = job.label or 'Unknown',
        }
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

        if not xPlayer then return {} end

        local accounts = xPlayer.getAccounts()
        return {
            money = accounts.money or 0,
            bank = accounts.bank or 0
        }
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
