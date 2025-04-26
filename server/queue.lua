---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

---@class discordQueue
lgc.discordQueue = {
    queue = {},
    processing = false,
    interval = lgc.adjustments.discordQueue.interval
}

local function processQueue()
    lgc.debug('Processing queue...', 'debug')
    
    if lgc.discordQueue.processing then
        lgc.debug('Queue is already processing', 'debug')
        return
    end
    
    if #lgc.discordQueue.queue == 0 then
        lgc.debug('Queue is empty', 'debug')
        return
    end
    
    lgc.discordQueue.processing = true
    local item = table.remove(lgc.discordQueue.queue, 1)
    
    lgc.debug('Processing item: ' .. json.encode(item), 'debug')
    
    if item.payload.embeds then

        for i = 1, #item.payload.embeds do
            local embed = item.payload.embeds[i]

            if embed.description and #embed.description > 4096 then
                embed.description = embed.description:sub(1, 4093) .. "..."
            end

            if embed.title and #embed.title > 256 then
                embed.title = embed.title:sub(1, 253) .. "..."
            end

            if embed.color and type(embed.color) ~= "number" then
                embed.color = 7506394
            end
        end
    end

    if type(item.webhook) ~= "string" then
        error('Webhook must be a string (webhook expected, got ' .. type(item.webhook) .. ')')
        return
    end

    local jsonPayload = json.encode(item.payload)
    if type(jsonPayload) ~= "string" then
        error('Failed to encode payload to JSON (jsonPayload expected, got ' .. type(jsonPayload) .. ')')
        return
    end

    lgc.debug('Sending payload: ' .. jsonPayload .. '', 'debug')

    local function callback(err, text, headers)
        if err ~= 204 and err ~= 200 then
            error('Failed to send Discord log: ' .. tostring(err) .. ' (response: ' .. tostring(text or "No response text") .. ')')
            if item.retries < lgc.adjustments.discordQueue.retries then
                item.retries = item.retries + 1
                SetTimeout(item.retries * lgc.adjustments.discordQueue.interval, function()
                    lgc.discordQueue.queue[#lgc.discordQueue.queue + 1] = item
                end)
            end
        else
            lgc.debug('Discord log sent successfully', 'info')
        end
        
        SetTimeout(lgc.discordQueue.interval, function()
            lgc.discordQueue.processing = false
            lgc.discordQueue.processQueue()
        end)
    end

    PerformHttpRequest(
        tostring(item.webhook), 
        callback,
        'POST', 
        jsonPayload, 
        { ['Content-Type'] = 'application/json' } 
    )
end

lgc.discordQueue.processQueue = processQueue