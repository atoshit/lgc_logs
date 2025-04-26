---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

local isScreenshotAvailable = GetResourceState('screenshot-basic') == 'started'

---@param webhook string Discord webhook URL
---@param options table Message options
---@param priority? number Priority of the message (1-5)
local function sendScreenshot(webhook, options, priority)
    if not webhook or not options then return end
    
    if not isScreenshotAvailable then
        lgc.debug('screenshot-basic is not available', 'error')
        return
    end

    exports['screenshot-basic']:requestScreenshotUpload(webhook, 'files[]', function(data)
        local resp = json.decode(data)
        if resp and resp.attachments and resp.attachments[1] then
            -- Modifier directement l'embed existant
            if options.embed then
                -- Ajouter le screenshot à l'embed existant
                options.embed.image = { url = resp.attachments[1].url }
            else
                -- Créer un nouvel embed si nécessaire
                options.embed = {
                    title = "Screenshot",
                    color = 7506394,
                    timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
                    image = { url = resp.attachments[1].url }
                }
            end

            -- Debug du payload
            lgc.debug('Screenshot payload: ' .. json.encode(options), 'info')

            -- Envoyer l'embed mis à jour
            TriggerServerEvent('lgc_logs:screenshot', webhook, options, priority)
        else
            lgc.debug('Failed to upload screenshot', 'warn')
        end
    end)
end

RegisterNetEvent('lgc_logs:requestScreenshot', function(webhook, options, priority)
    sendScreenshot(webhook, options, priority)
end)

RegisterCommand('testbridge', function()
    TriggerServerEvent('lgc_logs:testbridge')
end)




