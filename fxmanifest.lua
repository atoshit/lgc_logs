---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

-- Version & Game
fx_version 'cerulean'
game 'gta5'

-- Lua 5.4 Version & Experimental FV2 OAL
lua54 'yes'
use_experimental_fxv2_oal 'yes'

-- Metadata
author 'Atoshi'
description 'Advanced logging system for FiveM. Allows real-time tracking of player actions (commands, deaths, shots, connections, etc.) with transmission to Discord webhooks. Ideal for moderation and server management.'
version '0.0.1'
repository 'https://github.com/atoshit/lgc_logs'

-- Shared files
shared_scripts {
    'shared/init.lua',
    'locales/*.lua',
    'shared/configs/*.lua',
    'shared/functions/*.lua'
}

-- Server files
server_scripts {
    'server/version.lua',
    'server/queue.lua',
    'server/logs.lua',
    'server/bridges/esx.lua',
    'server/bridges/qbcore.lua',
    'server/event_handler.lua'
}

-- Client files
client_scripts {
    'client/screenshot.lua'
}