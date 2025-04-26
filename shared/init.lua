---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

local GRM <const> = GetResourceMetadata

local ENV <const> = GetCurrentResourceName()
local SERVICE <const> = (IsDuplicityVersion() and 'server') or 'client'

local METADATA <const> = {
    service = SERVICE, ---@type string<'server' | 'client'>
    env = ENV, ---@type string<'lgc_logs'>
    version = GRM(ENV, 'version'), ---@type string
    author = GRM(ENV, 'author'), ---@type string<'Atoshi'>
    description = GRM(ENV, 'description'), ---@type string
    repository = GRM(ENV, 'repository'), ---@type string<'https://github.com/atoshit/lgc_logs'>
    gameBuild = GetGameBuildNumber() ~= 0 or GetConvarInt('sv_enforceGameBuild', 0), ---@type number
    gameName = GetConvar('sv_projectName', 'Logic Logs'), ---@type string
    locales = {}
}

---@class Lgc
---@field service string<'server' | 'client'>
---@field env string<'lgc_logs'>
---@field version string
---@field author string<'Atoshi'>
---@field description string
---@field repository string<'https://github.com/atoshit/lgc_logs'>
---@field gameBuild number
---@field gameName string
---@field locale string
local lgc = {}

setmetatable(lgc, {
    __index = METADATA,

    __newindex = function(t, k, v)
        if type(v) == "function" then
            exports(k, v)
            --print('^2[lgc:init] ^7Exporting function: ^5' .. k .. '^7')
        elseif type(v) == "table" then
            local mt = getmetatable(v) or {}
            mt.__newindex = function(t2, k2, v2)
                if type(v2) == "function" then
                    exports(k2, v2)
                    --print('^2[lgc:init] ^7Exporting function: ^5' .. k2 .. '^7')
                end
                rawset(t2, k2, v2)
            end
            setmetatable(v, mt)
        end
        rawset(t, k, v)
    end
})

_ENV.lgc = lgc

---@param resource string Resource name
---@return boolean
local function isResourceActive(resource)
    return GetResourceState(resource) == 'started'
end

lgc.isResourceActive = isResourceActive

if SERVICE == 'server' then
    print('^2[lgc:init] ^7Resource loaded successfully !')
    print('^2[lgc:init] ^7Version: ^5' .. lgc.version)
    print('^2[lgc:init] ^7Author: ^5' .. lgc.author)
    print('^2[lgc:init] ^7Repository: ^5' .. lgc.repository)
    print('^2[lgc:init] ^7Game Build: ^5' .. lgc.gameBuild)
    print('^2[lgc:init] ^7Game Name: ^5' .. lgc.gameName)

    if isResourceActive('screenshot-basic') then
        lgc.screenshot = true
        print('^2[lgc:init] ^7' .. '^5screenshot-basic^7' .. ' found, logs will be sent to the screenshot webhook.')
    else
        print('^2[lgc:init] ^7' .. '^5screenshot-basic^7' .. ' not found, logs will not be sent to the screenshot webhook.')
    end
end