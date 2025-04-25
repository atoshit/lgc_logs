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
    gameName = GetConvar('sv_projectName', 'Unknown'), ---@type string
    lang = GetConvar('locale', 'en-US'), ---@type string,
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
local lgc = setmetatable(METADATA, {
    _newindex = function(self, name, value)
        rawset(self, name, value)

        if type(value) == 'function' then
            exports(name, value)
        end
    end
})

_ENV.lgc = lgc

if SERVICE == 'server' then
    print('^2[lgc:init] ^7Resource loaded successfully !')
    print('^2[lgc:init] ^7Version: ^5' .. lgc.version)
    print('^2[lgc:init] ^7Author: ^5' .. lgc.author)
    print('^2[lgc:init] ^7Repository: ^5' .. lgc.repository)
    print('^2[lgc:init] ^7Game Build: ^5' .. lgc.gameBuild)
    print('^2[lgc:init] ^7Game Name: ^5' .. lgc.gameName)
    print('^2[lgc:init] ^7Language: ^5' .. lgc.lang .. '^7')
end