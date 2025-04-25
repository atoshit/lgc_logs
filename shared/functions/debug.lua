---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

---@type table<string, {level: number, color: string}>
local LEVELS <const> = {
    ['default'] = {level = 0, color = '^7'},
    ['info'] = {level = 1, color = '^5'},
    ['warn'] = {level = 2, color = '^3'},
    ['fatal'] = {level = 3, color = '^1'}
}

---@param message string
---@param level string | 'default' | 'info' | 'warn' | 'fatal'
local function debug(message, level)
    if lgc.adjustments.debugLevel < LEVELS[level].level or not lgc.adjustments.debugLevel then return end

    local levelData = LEVELS[level] or LEVELS['default']
    
    return print(('%s[%s:%s] ^7%s'):format(levelData.color, "lgc", level, message))
end

lgc.debug = debug