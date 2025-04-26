---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

---@class discordLogs
lgc.discordLogs = {}

---@param webhook string Webhook URL
---@param options table Message options
---@param priority? number Priority of the message (1-5)
---@param playerId? number Player server ID for screenshot
local function sendLogs(webhook, options, priority, playerId)
    lgc.debug('Attempting to send log to webhook: ' .. tostring(webhook), 'debug')
    
    if not webhook then 
        error('No webhook provided')
        return 
    end
    
    if type(options) ~= "table" then
        error('Invalid options type: ' .. type(options))
        return
    end

    lgc.debug('Log options: ' .. json.encode(options), 'debug')

    local payload = {
        username = options.username or lgc.gameName,
        avatar_url = options.avatar_url,
        content = options.content,
        tts = options.tts or false,
    }

    if options.embed then
        payload.embeds = {options.embed} 
    end

    if #payload.embeds == 0 and not payload.content then
        error('No content or embeds provided')
        return
    end

    lgc.debug('Final payload: ' .. json.encode(payload), 'debug')

    if playerId and tonumber(playerId) > 0 then
        if lgc.screenshot then
            lgc.debug('Requesting screenshot from player: ' .. playerId, 'debug')

            Wait(100)
            TriggerClientEvent('lgc_logs:requestScreenshot', playerId, webhook, options, priority)
            
            SetTimeout(5000, function()
                lgc.debug('Screenshot timeout, sending log without screenshot', 'warn')
            end)
            return
        else
            lgc.debug('screenshot-basic is not available, sending log without screenshot', 'warn')
        end
    end

    local queueItem = {
        webhook = webhook,
        payload = payload,
        priority = tonumber(priority) or 3,
        retries = 0,
        timestamp = os.time()
    }

    lgc.debug('Adding to queue with priority: ' .. queueItem.priority, 'debug')
    
    lgc.discordQueue.queue[#lgc.discordQueue.queue + 1] = queueItem
    
    lgc.debug('Queue length: ' .. #lgc.discordQueue.queue, 'debug')
    lgc.debug('Triggering queue process', 'debug')
    
    lgc.discordQueue.processQueue()
end

RegisterNetEvent('lgc_logs:screenshot', function(webhook, options, priority)
    local source = source
    if not webhook or not options then return end

    sendLogs(webhook, options, priority)
end)

RegisterNetEvent('lgc_logs:screenshotFailed', function(webhook, options, priority)
    local source = source
    lgc.debug('Screenshot failed from player: ' .. source .. ', sending log without screenshot', 'warn')
    sendLogs(webhook, options, priority)
end)

lgc.discordLogs.send = sendLogs