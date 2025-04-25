---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

local GRM <const> = GetResourceMetadata

local ENV <const> = GetCurrentResourceName()
local SERVICE <const> = (IsDuplicityVersion() and 'server') or 'client'

local METADATA <const> = {
    service = SERVICE,
    env = ENV,
    version = GRM(ENV, 'version'),
    author = GRM(ENV, 'author'),
    description = GRM(ENV, 'description'),
    repository = GRM(ENV, 'repository'),
    gameBuild = GetGameBuildNumber() ~= 0 or GetConvar('sv_enforceGameBuild', 'Unknown'),
    gameName = GetConvar('sv_projectName', 'Unknown'),
    locale = GetConvar('locale', 'en-US'),
}

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
    print('^2[lgc] ^7Resource loaded successfully !')
    print('^2[lgc] ^7Version: ^5' .. lgc.version)
    print('^2[lgc] ^7Author: ^5' .. lgc.author)
    --print('^2[lgc] ^7Description: ^5' .. lgc.description)
    print('^2[lgc] ^7Repository: ^5' .. lgc.repository)
    print('^2[lgc] ^7Game Build: ^5' .. lgc.gameBuild)
    print('^2[lgc] ^7Game Name: ^5' .. lgc.gameName)
    print('^2[lgc] ^7Locale: ^5' .. lgc.locale .. '^7')
end