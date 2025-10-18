local i18n = {}

i18n.fallback = "en"
i18n.current  = "en"
i18n._cache   = {}

local function safe_require(modname)
    local ok, response = pcall(require, modname)
    if ok then return response end
    return nil, response
end

function i18n.load(lang)
    if i18n._cache[lang] then
        return i18n._cache[lang]
    end

    local modname = "locales." .. lang
    local tbl, err = safe_require(modname)
    if not tbl then
        return nil, ("[i18n] Locale '%s' not found: %s"):format(lang, tostring(err))
    end

    if type(tbl) ~= "table" then
        return nil, ("[i18n] Locale '%s' must return a table, got %s"):format(lang, type(tbl))
    end

    i18n._cache[lang] = tbl
    return tbl
end

function i18n.setLocale(lang)
    local tbl, err = i18n.load(lang)
    if not tbl then
        return nil, err
    end
    i18n.current = lang
    return true
end

-- hot reload for debug mode
function i18n.reload(lang)
    local modname = "locales." .. lang
    package.loaded[modname] = nil
    i18n._cache[lang] = nil
    return i18n.load(lang) ~= nil
end

-- deep get, for example ("menu.file.open")
local function deep_get(tbl, dotted_key)
  local node = tbl
  for part in dotted_key:gmatch("[^%.]+") do
    if type(node) ~= "table" then return nil end
    node = node[part]
    if node == nil then return nil end
  end
  return node
end

-- "My name is {name}" | vars = { name = "Yauheni" }
local function interpolate(str, vars)
  if type(str) ~= "string" or type(vars) ~= "table" then
    return str
  end
  return (str:gsub("{(.-)}", function(k)
    local v = vars[k]
    if v == nil then return "{" .. k .. "}" end
    return tostring(v)
  end))
end

function i18n.get(key, lang, opts)
  lang = lang or i18n.current
  opts = opts or {}

  -- get from current lang
  local lang_tbl = i18n.load(lang)
  if lang_tbl then
    local v = deep_get(lang_tbl, key)
    if v ~= nil then return v end
  end

  -- fallback
  if i18n.fallback and i18n.fallback ~= lang then
    local fb_tbl = i18n.load(i18n.fallback)
    if fb_tbl then
      local v = deep_get(fb_tbl, key)
      if v ~= nil then return v end
    end
  end

  -- default
  if opts.default ~= nil then
    return opts.default
  end

  return nil
end

function i18n.t(key, vars, lang, opts)
  local val = i18n.get(key, lang, opts)
  if val == nil then
    -- return key if locale was not found
    return key
  end
  if type(val) == "string" then
    return interpolate(val, vars)
  end
  return val
end

return i18n