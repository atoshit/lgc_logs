---@author Atoshi
-- Created at 2025-04-25
-- Copyright (c) Logic. Studios - All Rights Reserved

---@param str string
---@return string
local function getLocale(str)
    local locale = lgc.locales[lgc.lang]

    if not locale then 
        lgc.debug('No locale found for :' .. lgc.lang, 'warn')
        return str 
    end

    return locale[str] ~= nil and locale[str] or lgc.debug('No string matching "' .. str .. '" was found in the locale file for "' .. lgc.lang .. '"', 'warn')
end

lgc.locale = getLocale
