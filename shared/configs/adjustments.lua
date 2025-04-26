---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

lgc.adjustments = {
    debugLevel = 4, -- 1 = info, 2 = warn, 3 = fatal, 4 = debug / false to disable debug logs
    serverLogo = 'https://png.pngtree.com/png-clipart/20190516/original/pngtree-log-file-format-icon-design-png-image_4307740.jpg',
    locale = 'FR',

    discordQueue = {
        interval = 500, -- 1 second
        retries = 3, -- 3 retries
    },

    logs = {
        playerJoin = false,
        playerLeave = true,
        death = true,
        shot = true,
        command = true,  
        chatMessage = true,
        resources = true, 
        explosion = true,
        vehicle = true,
    },
}