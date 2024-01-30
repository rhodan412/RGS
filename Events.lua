--[[ 

Events.lua

]]

---------------------------
-- 1. Declarations
---------------------------

local RGS = LibStub("AceAddon-3.0"):GetAddon("RGS")
RGS = RGS or {}

---------------------------
-- 2. Register Events
---------------------------

-- Create an event frame
local Frame = CreateFrame("Frame")

-- Register events to the frame
-- Define a list of events to register
local eventsToRegister = {
    "ADDON_LOADED",
    "CVAR_UPDATE",
    "GROUP_ROSTER_UPDATE",
    "PLAYER_ENTERING_WORLD",
    "PLAYER_LOGIN",
    "SCENARIO_UPDATE",
    "ZONE_CHANGED_NEW_AREA"
}

-- On Event Handler
local function HandleEvents(frame, event, ...)
    local handlers = {
        ADDON_LOADED = RGS.handlePlayerLogin,
        CVAR_UPDATE = RGS.handleCVARupdate,
        PLAYER_LOGIN = RGS.handlePlayerLogin,
        GROUP_ROSTER_UPDATE = RGS.handleGroupRosterUpdate,
        PLAYER_ENTERING_WORLD = RGS.handlePlayerEntersWorld,
        ZONE_CHANGED_NEW_AREA = RGS.handlePlayerEntersWorld,
        SCENARIO_UPDATE = RGS.handleScenarioUpdate
    }
    
    if handlers[event] then
        handlers[event](RGS, ...)
    end
end

---------------------------
-- 3. Event Functions
---------------------------

-- Handling PLAYER_LOGIN Event
function RGS.handlePlayerLogin(self, addonName)
    if addonName == "RGS" then
        self:OnInitialize()
    end
end

-- Handling CVAR_UPDATE Event
function RGS.handleCVARupdate(self)
    -- Handle the Updates to the addon's configuration
end

-- Handling GROUP_ROSTER_UPDATE Event
function RGS.handleGroupRosterUpdate(self)
    self:UpdateGraphicsSettingsBasedOnGroupStatus()
end

-- Handling PLAYER_ENTERING_WORLD Event
function RGS.handlePlayerEntersWorld(self)
    local isInScenario = C_Scenario.IsInScenario()
    self:UpdateGraphicsSettingsBasedOnGroupStatus(isInScenario)
end

-- HANDLE SCENARIO_UPDATE
function RGS:handleScenarioUpdate()
    local isInScenario = C_Scenario.IsInScenario()
    self:UpdateGraphicsSettingsBasedOnGroupStatus(isInScenario)
end

---------------------------
-- 4. Finalization
---------------------------

-- Set the event handler
Frame:SetScript("OnEvent", HandleEvents)

-- Loop through the list and register each event
for _, eventName in ipairs(eventsToRegister) do
    Frame:RegisterEvent(eventName)
end

-- Define a function to apply settings
function RGS.applySettings(self, profileSettings)
    for setting, value in pairs(profileSettings) do
        SetCVar(setting, value)
    end
end
