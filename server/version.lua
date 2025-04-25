---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

---@param repository string
local function checkVersion(repository)
    local currentVersion = lgc.version
    
    if currentVersion then
        currentVersion = currentVersion:match('^%d+%.%d+%.%d+')
    end

    if not currentVersion then
        return
    end

    SetTimeout(1000, function()
        PerformHttpRequest(('https://api.github.com/repos/%s/releases/latest'):format(repository), function(status, response)
            if status ~= 200 then return end

            response = json.decode(response)

            if response.prerelease then return end

            local latestVersion = response.tag_name:match('^%d+%.%d+%.%d+')

            if not latestVersion or latestVersion == currentVersion then return end

            local cv = { string.strsplit('.', currentVersion) }
            local lv = { string.strsplit('.', latestVersion) }

            for i = 1, #cv do
                local current, minimum = tonumber(cv[i]), tonumber(lv[i])

                if current ~= minimum then
                    if current < minimum then
                        lgc.debug('New version available: ' .. latestVersion, 'warn')
                    else
                        break
                    end
                end
            end
        end)
    end)
end

checkVersion('atoshit/lgc_logs')

lgc.checkVersion = checkVersion