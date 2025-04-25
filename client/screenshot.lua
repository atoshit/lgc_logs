---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

---@param webhook string Discord webhook URL
---@param options table Message options
---@param priority? number Priority of the message (1-5)
local function sendScreenshot(webhook, options, priority)
    if not webhook or not options then return end

    exports['screenshot-basic']:requestScreenshotUpload(webhook, 'files[]', function(data)
        local resp = json.decode(data)
        if resp and resp.attachments and resp.attachments[1] then
            if not options.embed then
                options.embed = {}
            end
            options.embed.image = resp.attachments[1].url

            TriggerServerEvent('lgc_logs:screenshot', webhook, options, priority)
        else
            lgc.debug('Failed to upload screenshot', 'warn')
        end
    end)
end

RegisterNetEvent('lgc_logs:requestScreenshot', function(webhook, options, priority)
    if lgc.screenshot then
        sendScreenshot(webhook, options, priority)
    end
end) 
