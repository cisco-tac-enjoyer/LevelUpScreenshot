local ADDON_NAME = ...

local PREFIX = "|cffffd100LevelUpScreenshot:|r "
local MIN_DELAY, MAX_DELAY = 0.2, 5
local SAFETY_SECONDS = 5

local DEFAULTS = {
  enabled = true,
  delay = 0.2,
  format = "png",
  restoreFormat = nil,
  pendingRestore = false,
}

local db
local shotTimer, safetyTimer

local function ChatFrame()
  return SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME
end

local function Print(msg)
  ChatFrame():AddMessage(PREFIX .. msg)
end

local function GetFormat()
  if C_CVar and C_CVar.GetCVar then
    return C_CVar.GetCVar("screenshotFormat")
  end
  return GetCVar("screenshotFormat")
end

local function SetFormat(value)
  if C_CVar and C_CVar.SetCVar then
    C_CVar.SetCVar("screenshotFormat", value)
  else
    SetCVar("screenshotFormat", value)
  end
end

local function Normalize(fmt)
  fmt = string.lower(tostring(fmt or "jpg"))
  if fmt == "jpeg" then
    return "jpg"
  end
  return fmt
end

local function CancelTimer(timer)
  if timer then
    timer:Cancel()
  end
end

local function RestoreFormat()
  CancelTimer(safetyTimer)
  safetyTimer = nil
  if not db.pendingRestore then
    return
  end
  if db.restoreFormat then
    SetFormat(db.restoreFormat)
  end
  db.restoreFormat = nil
  db.pendingRestore = false
end

local function NormalFormat()
  if db.pendingRestore and db.restoreFormat then
    return db.restoreFormat
  end
  return GetFormat()
end

local function CheckConflict()
  local normal = Normalize(NormalFormat())
  if normal == db.format then
    Print(string.format(
      "Your normal screenshots also use %s. Pick a different level-up format with /lus format, or change your normal format with /console screenshotFormat jpg.",
      string.upper(normal)))
  end
end

local function TakeShot()
  shotTimer = nil
  RestoreFormat()
  db.restoreFormat = GetFormat()
  db.pendingRestore = true
  SetFormat(db.format)
  Screenshot()
  safetyTimer = C_Timer.NewTimer(SAFETY_SECONDS, RestoreFormat)
end

local function OnLevel(level)
  ChatFrame():AddMessage(string.format("|cffffd100%s reached level %d!|r", UnitName("player"), level))
  CancelTimer(shotTimer)
  shotTimer = C_Timer.NewTimer(db.delay, TakeShot)
end

local function ShowStatus()
  Print(string.format("%s, delay %.1f s, level-up format %s, normal format %s.",
    db.enabled and "|cff00ff00enabled|r" or "|cffff0000disabled|r",
    db.delay, string.upper(db.format), string.upper(Normalize(NormalFormat()))))
end

local function ShowHelp()
  Print("Commands:")
  Print("/lus - show status")
  Print("/lus help - list all commands")
  Print("/lus test - run the level-up flow now with your current level")
  Print("/lus on | off - enable or disable")
  Print("/lus delay <seconds> - set the delay (0.2 to 5, default 0.2)")
  Print("/lus format png|jpg|tga - set the level-up screenshot format")
  Print("/lus reset - restore the defaults")
end

local function HandleSlash(input)
  local cmd, arg = string.match(input or "", "^%s*(%S*)%s*(.-)%s*$")
  cmd = string.lower(cmd or "")
  arg = string.lower(arg or "")

  if cmd == "" then
    ShowStatus()
  elseif cmd == "help" then
    ShowHelp()
  elseif cmd == "test" then
    OnLevel(UnitLevel("player"))
  elseif cmd == "on" then
    db.enabled = true
    Print("Enabled.")
  elseif cmd == "off" then
    db.enabled = false
    Print("Disabled.")
  elseif cmd == "delay" then
    local seconds = tonumber((string.gsub(arg, ",", ".")))
    if not seconds or seconds < MIN_DELAY or seconds > MAX_DELAY then
      Print("The delay must be a number from 0.2 to 5 seconds.")
      return
    end
    db.delay = seconds
    Print(string.format("Delay set to %.1f s.", seconds))
  elseif cmd == "format" then
    local fmt = Normalize(arg)
    if fmt ~= "png" and fmt ~= "jpg" and fmt ~= "tga" then
      Print("Usage: /lus format png|jpg|tga")
      return
    end
    if fmt == "tga" and IsMacClient and IsMacClient() then
      Print("TGA screenshots are not supported on Mac. Use png or jpg.")
      return
    end
    db.format = fmt
    Print("Level-up format set to " .. string.upper(fmt) .. ".")
    CheckConflict()
  elseif cmd == "reset" then
    db.enabled = DEFAULTS.enabled
    db.delay = DEFAULTS.delay
    db.format = DEFAULTS.format
    Print("Defaults restored (enabled, 0.2 s, PNG).")
    CheckConflict()
  else
    Print("Unknown command. Type /lus help for a list of commands.")
  end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_LEVEL_UP")
frame:RegisterEvent("SCREENSHOT_SUCCEEDED")
frame:RegisterEvent("SCREENSHOT_FAILED")

frame:SetScript("OnEvent", function(_, event, arg1)
  if event == "ADDON_LOADED" then
    if arg1 ~= ADDON_NAME then
      return
    end
    LevelUpScreenshotDB = LevelUpScreenshotDB or {}
    db = LevelUpScreenshotDB
    for key, value in pairs(DEFAULTS) do
      if db[key] == nil then
        db[key] = value
      end
    end
    frame:UnregisterEvent("ADDON_LOADED")
  elseif event == "PLAYER_LOGIN" then
    if db.pendingRestore then
      RestoreFormat()
      Print("Restored your normal screenshot format after an interrupted screenshot.")
    end
    CheckConflict()
  elseif event == "PLAYER_LEVEL_UP" then
    if db.enabled then
      OnLevel(arg1)
    end
  elseif event == "SCREENSHOT_SUCCEEDED" or event == "SCREENSHOT_FAILED" then
    RestoreFormat()
  end
end)

SLASH_LUS1 = "/lus"
SlashCmdList.LUS = HandleSlash
