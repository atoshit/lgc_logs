---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

---@class discordLogs
lgc.discordLogs = {}

---@param webhook string Webhook URL
---@param options table Message options
---@param priority? number Priority of the message (1-5)
local function sendLogs(webhook, options, priority)
    if not webhook then return end
    
    if type(options) ~= "table" then
        error('Options must be a table (table expected, got ' .. type(options) .. ')')
        return
    end

    local payload = {
        username = options.username or lgc.gameName,
        avatar_url = options.avatar_url,
        content = options.content,
        tts = options.tts or false,
    }

    if not payload.content and not options.embed then
        error('Message must have either content or embed (content or embed expected, got ' .. type(options.content) .. ' and ' .. type(options.embed) .. ')')
        return
    end

    if options.embed then
        if type(options.embed) ~= "table" then
            error('Embed must be a table (embed expected, got ' .. type(options.embed) .. ')')
            return
        end

        local image = options.embed.image and { url = options.embed.image }
        local thumbnail = options.embed.thumbnail and { url = options.embed.thumbnail }

        payload.embeds = {
            {
                title = options.embed.title,
                description = options.embed.description,
                url = options.embed.url,
                timestamp = options.embed.timestamp or os.date("!%Y-%m-%dT%H:%M:%SZ"),
                color = tonumber(options.embed.color) or 7506394,
                footer = options.embed.footer,
                image = image, 
                thumbnail = thumbnail, 
                author = options.embed.author,
                fields = options.embed.fields
            }
        }
    end

    if payload.content and #payload.content > 2000 then
        payload.content = payload.content:sub(1, 1997) .. "..."
    end

    local queueItem = {
        webhook = webhook,
        payload = payload,
        priority = tonumber(priority) or 3,
        retries = 0,
        timestamp = os.time()
    }

    lgc.discordQueue.queue[#lgc.discordQueue.queue + 1] = queueItem
    lgc.discordQueue.processQueue()
end

lgc.discordLogs.send = sendLogs