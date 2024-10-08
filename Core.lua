--[[ 

Core.lua
Handles bulk of code to load settings from current (via button) and apply specific settings to graphics on specific group-size events

]]


---------------------------
-- 1. Global Declarations
---------------------------

local AceAddon = LibStub("AceAddon-3.0")
local RGS = AceAddon:NewAddon("RGS", "AceConsole-3.0", "AceEvent-3.0")

-- Define your abbreviations here
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")
local ADBO = LibStub("AceDBOptions-3.0") -- If you're using AceDBOptions-3.0

RGS = RGS or {}
RGS.db = RGS.db or {}
RGS.db.profile = RGS.db.profile or {}

---------------------------
-- 2. Initialization
---------------------------

-- Function called when addon is loaded
function RGS:OnInitialize()
    if self.isInitialized then return end
    self.isInitialized = true

    -- Query the current graphics settings from CVars
    local currentShadowQuality = GetCVar("graphicsShadowQuality")
    local currentLiquidDetail = GetCVar("graphicsLiquidDetail")
    local currentParticleDensity = GetCVar("graphicsParticleDensity")
    local currentSSAOSetting = GetCVar("graphicsSSAO")
    local currentDepthEffects = GetCVar("graphicsDepthEffects")
    local currentComputeEffects = GetCVar("graphicsComputeEffects")
    local currentTextureResolution = GetCVar("graphicsTextureResolution")
    local currentSpellDensity = GetCVar("graphicsSpellDensity")
    local currentProjectedTextures = GetCVar("graphicsProjectedTextures")
    local currentViewDistance = GetCVar("graphicsViewDistance")
    local currentEnvironmentDetail = GetCVar("graphicsEnvironmentDetail")
    local currentGroundClutter = GetCVar("graphicsGroundClutter")

    -- Initialize the database with a structure for default profiles
    self.db = LibStub("AceDB-3.0"):New("RGSDB", {}, true)

    -- Check if the profiles are already set in the DB, otherwise set defaults
    if not self.db.profile.solo or not next(self.db.profile.solo) then
        -- Default settings for each profile if not already in DB
        local defaultProfiles = {
            solo = {
                spellDensity = 0,
                particleDensity = 3,
                projectedTextures = 1,
                environmentDetail = 7,
                depthEffects = 3,
                textureResolution = 2,
                groundClutter = 7,
                SSAOSetting = 3,
                viewDistance = 7,
                shadowQuality = 3,
                computeEffects = 2,
                liquidDetail = 2,
				textureFilteringMode = 5,
				shadowRT = 0,
				sunShafts = 0,
            },
            scenario = {
                spellDensity = 0,
                particleDensity = 2,
                projectedTextures = 1,
                environmentDetail = 4,
                depthEffects = 3,
                textureResolution = 2,
                groundClutter = 5,
                SSAOSetting = 2,
                viewDistance = 4,
                shadowQuality = 1,
                computeEffects = 2,
                liquidDetail = 1,
				textureFilteringMode = 5,
				shadowRT = 0,
				sunShafts = 0,
            },
            group = {
                spellDensity = 0,
                particleDensity = 2,
                projectedTextures = 1,
                environmentDetail = 4,
                depthEffects = 3,
                textureResolution = 2,
                groundClutter = 5,
                SSAOSetting = 3,
                viewDistance = 5,
                shadowQuality = 2,
                computeEffects = 2,
                liquidDetail = 2,
				textureFilteringMode = 5,
				shadowRT = 0,
				sunShafts = 0,
            },
            raid = {
                spellDensity = 0,
                particleDensity = 1,
                projectedTextures = 1,
                environmentDetail = 4,
                depthEffects = 1,
                textureResolution = 2,
                groundClutter = 3,
                SSAOSetting = 1,
                viewDistance = 3,
                shadowQuality = 0,
                computeEffects = 1,
                liquidDetail = 1,
				textureFilteringMode = 5,
				shadowRT = 0,
				sunShafts = 0,
            },
        }

        -- Loop through the default profile structure to set defaults if not present
        for profileType, settings in pairs(defaultProfiles) do
            if not self.db.profile[profileType] or not next(self.db.profile[profileType]) then
                self.db.profile[profileType] = settings
            end
        end
    end
    --}, true) -- true for a default profile

    -- Register the main category as 'Solo' directly under the addon name
    if not self.optionsFrame then
        self.optionsFrame = {}
        -- Make sure "self.options" refers to the Solo options structure
        AC:RegisterOptionsTable("Rhodan's Graphical Settings", self.options)
        -- The main category displayed when you click the addon name is "Solo"
        self.optionsFrame.general = ACD:AddToBlizOptions("Rhodan's Graphical Settings", nil, nil, "solo")
    end

    -- Register 'Group' and 'Raid' as sub-categories under the 'Solo' main category
    AC:RegisterOptionsTable("Rhodan's Graphical Settings - Scenario", self.options.args.scenario)
    self.optionsFrame.scenario = ACD:AddToBlizOptions("Rhodan's Graphical Settings - Scenario", "Scenario", "Rhodan's Graphical Settings")

    -- Make sure "self.options.args.group" and "self.options.args.raid" refer to the correct group and raid options structures
    AC:RegisterOptionsTable("Rhodan's Graphical Settings - Group", self.options.args.group)
    self.optionsFrame.group = ACD:AddToBlizOptions("Rhodan's Graphical Settings - Group", "Group", "Rhodan's Graphical Settings")

    AC:RegisterOptionsTable("Rhodan's Graphical Settings - Raid", self.options.args.raid)
    self.optionsFrame.raid = ACD:AddToBlizOptions("Rhodan's Graphical Settings - Raid", "Raid", "Rhodan's Graphical Settings")

    -- Register 'Profiles' as a sub-category under the 'Solo' main category
    -- Make sure "self.db" is correctly initialized with profile settings
    if not self.profilesFrame then
        local profiles = ADBO:GetOptionsTable(self.db)
        AC:RegisterOptionsTable("Rhodan's Graphical Settings - Profiles", profiles)
        self.profilesFrame = ACD:AddToBlizOptions("Rhodan's Graphical Settings - Profiles", "Profiles", "Rhodan's Graphical Settings")
    end
end



---------------------------
-- 3. Buttons
---------------------------

-- Function that will push current graphic settings into specific profile
function RGS:UpdateProfileWithCurrentSettings(profileType)
    local profile = self.db.profile[profileType]
    if not profile then return end

    profile.shadowQuality = tonumber(GetCVar("graphicsShadowQuality"))
    profile.liquidDetail = tonumber(GetCVar("graphicsLiquidDetail"))
    profile.particleDensity = tonumber(GetCVar("graphicsParticleDensity"))
    profile.SSAOSetting = tonumber(GetCVar("graphicsSSAO"))
    profile.depthEffects = tonumber(GetCVar("graphicsDepthEffects"))
    profile.computeEffects = tonumber(GetCVar("graphicsComputeEffects"))
    profile.textureResolution = tonumber(GetCVar("graphicsTextureResolution"))
    profile.spellDensity = tonumber(GetCVar("graphicsSpellDensity"))
    profile.projectedTextures = tonumber(GetCVar("graphicsProjectedTextures"))
    profile.viewDistance = tonumber(GetCVar("graphicsViewDistance"))
    profile.environmentDetail = tonumber(GetCVar("graphicsEnvironmentDetail"))
    profile.groundClutter = tonumber(GetCVar("graphicsGroundClutter"))
	profile.textureFilteringMode = tonumber(GetCVar("textureFilteringMode"))
	profile.shadowRT = tonumber(GetCVar("shadowRT"))
	profile.sunShafts = tonumber(GetCVar("sunShafts"))

    print(profileType .. " profile updated with current settings.")
end



-----------------------------------
-- 4. Functions to Apply Settings
-----------------------------------


-- This function applies a given profile's settings to the game.
function RGS:ApplyProfileSettings(profile)
    local baseDelay = 0.5 -- base delay in seconds, make sure this is defined within the function scope
    local heavyCVarDelayMultiplier = 3 -- apply a longer delay for heavy CVars like graphicsTextureResolution
    local cvars = {

    {"graphicsShadowQuality", profile.shadowQuality},
    {"graphicsLiquidDetail", profile.liquidDetail},
    {"graphicsParticleDensity", profile.particleDensity},
    {"graphicsSSAO", profile.SSAOSetting},
    {"graphicsDepthEffects", profile.depthEffects},
    {"graphicsComputeEffects", profile.computeEffects},
    {"graphicsSpellDensity", profile.spellDensity},
    {"graphicsProjectedTextures", profile.projectedTextures},
    {"graphicsViewDistance", profile.viewDistance},
    {"graphicsEnvironmentDetail", profile.environmentDetail},
    {"graphicsGroundClutter", profile.groundClutter},
	{"textureFilteringMode", profile.textureFilteringMode},
	{"shadowRT", profile.shadowRT},
	{"sunShafts", profile.sunShafts},

	-- graphicsTextureResolution will have a longer delay
	{"graphicsTextureResolution", profile.textureResolution},

    }

    for i, cvar in ipairs(cvars) do
        local delayMultiplier = cvar[3] or 1 -- default multiplier is 1 unless specified
        C_Timer.After(baseDelay * (i-1) * delayMultiplier, function()
            --print("Applying " .. cvar[1] .. " with value: " .. tostring(cvar[2])) -- Debug message
            SetCVar(cvar[1], cvar[2])
        end)
    end
end


-- This function determines the current group status and applies the appropriate settings.
-- Added a new parameter 'isInScenario' to explicitly handle scenario updates.
function RGS:UpdateGraphicsSettingsBasedOnGroupStatus(isInScenario)
    local size = GetNumGroupMembers()

    -- Check for raid group (more than 5 members) first
    if size > 5 then
        self:ApplyProfileSettings(self.db.profile.raid)
    -- Next, check for scenario update
    elseif isInScenario then
        self:ApplyProfileSettings(self.db.profile.scenario)
    -- Check for solo or group (5 or fewer members)
    elseif size == 0 then
        self:ApplyProfileSettings(self.db.profile.solo)
    else
        self:ApplyProfileSettings(self.db.profile.group)
    end
end
