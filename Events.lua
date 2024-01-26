--[[ 

Events.lua

]]

local RGS = LibStub("AceAddon-3.0"):GetAddon("RGS")

RGS = RGS or {}

-- Create an event frame
local Frame = CreateFrame("Frame")

-- Register events to the frame
-- Define a list of events to register
local eventsToRegister = {
	"ADDON_LOADED",
	"CVAR_UPDATE",
	"GROUP_ROSTER_UPDATE",
	"PLAYER_ENTERING_WORLD",
	"PLAYER_LOGIN"
}


-- On Event Handler
local function HandleEvents(frame, event, ...)
    local handlers = {
        ADDON_LOADED = RGS.handlePlayerLogin,
        CVAR_UPDATE = RGS.handleCVARupdate,
        PLAYER_LOGIN = RGS.handlePlayerLogin,
        GROUP_ROSTER_UPDATE = RGS.handleGroupRosterUpdate,
        PLAYER_ENTERING_WORLD = RGS.handlePlayerEntersWorld
    }
    
    if handlers[event] then
        handlers[event](...)
    end
end


-- Handling PLAYER_LOGIN Event
function RGS.handlePlayerLogin()
	-- Initialize other components of your AddOn
    if addonName == "RGS" then
        RGS:OnInitialize()
    end
end


-- Handling CVAR_UPDATE Event
function RGS.handleCVARupdate()
	-- Handle the Updates to the addon's configuration
end


-- Handling GROUP_ROSTER_UPDATE Event
function RGS.handleGroupRosterUpdate()
    RGS:UpdateGraphicsSettingsBasedOnGroupStatus()
end


-- Handling PLAYER_ENTERING_WORLD Event
function RGS.handlePlayerEntersWorld()
	-- Initialize other components of your AddOn
    if addonName == "RGS" then
        RGS:OnInitialize()
    end
	RGS.handleGroupRosterUpdate()
end

-- Set the event handler
Frame:SetScript("OnEvent", HandleEvents)


-- Loop through the list and register each event
for _, eventName in ipairs(eventsToRegister) do
    Frame:RegisterEvent(eventName)
end


-- Define a function to apply settings
function RGS.applySettings(profileSettings)
    for setting, value in pairs(profileSettings) do
        SetCVar(setting, value)
    end
end