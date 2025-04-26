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
    -- Debug du webhook
    lgc.debug('Attempting to send log to webhook: ' .. tostring(webhook), 'info')
    
    if not webhook then 
        lgc.debug('No webhook provided', 'error')
        return 
    end
    
    if type(options) ~= "table" then
        lgc.debug('Invalid options type: ' .. type(options), 'error')
        return
    end

    -- Debug des options
    lgc.debug('Log options: ' .. json.encode(options), 'info')

    local payload = {
        username = options.username or lgc.gameName,
        avatar_url = options.avatar_url,
        content = options.content,
        tts = options.tts or false,
    }

    -- Traiter l'embed
    if options.embed then
        payload.embeds = {options.embed} -- Utiliser directement l'embed
    end

    if #payload.embeds == 0 and not payload.content then
        lgc.debug('No content or embeds provided', 'error')
        return
    end

    -- Debug du payload final
    lgc.debug('Final payload: ' .. json.encode(payload), 'info')

    -- Envoyer la demande de screenshot si nécessaire
    if playerId and GetResourceState('screenshot-basic') == 'started' then
        lgc.debug('Requesting screenshot from player: ' .. playerId, 'info')
        TriggerClientEvent('lgc_logs:requestScreenshot', playerId, webhook, options, priority)
        return -- On attend le retour du screenshot avant d'envoyer
    end

    local queueItem = {
        webhook = webhook,
        payload = payload,
        priority = tonumber(priority) or 3,
        retries = 0,
        timestamp = os.time()
    }

    -- Debug de l'ajout à la queue
    lgc.debug('Adding to queue with priority: ' .. queueItem.priority, 'info')
    
    lgc.discordQueue.queue[#lgc.discordQueue.queue + 1] = queueItem
    
    -- Debug du processus de queue
    lgc.debug('Queue length: ' .. #lgc.discordQueue.queue, 'info')
    lgc.debug('Triggering queue process', 'info')
    
    lgc.discordQueue.processQueue()
end

RegisterNetEvent('lgc_logs:screenshot', function(webhook, options, priority)
    local source = source
    if not webhook or not options then return end

    sendLogs(webhook, options, priority)
end)

lgc.discordLogs.send = sendLogs