-- RGS stores client CVar values. Blizzard displays its 0-9 quality sliders as 1-10.
local RGS = LibStub("AceAddon-3.0"):NewAddon("RGS", "AceConsole-3.0", "AceEvent-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

-- Each entry is {saved key, base CVar, raid CVar (if Blizzard has a second bank)}.
RGS.settings = {
    { "graphicsQuality", "graphicsQuality", "raidGraphicsQuality" },
    { "shadowQuality", "graphicsShadowQuality", "raidGraphicsShadowQuality" },
    { "liquidDetail", "graphicsLiquidDetail", "raidGraphicsLiquidDetail" },
    { "particleDensity", "graphicsParticleDensity", "raidGraphicsParticleDensity" },
    { "SSAOSetting", "graphicsSSAO", "raidGraphicsSSAO" },
    { "depthEffects", "graphicsDepthEffects", "raidGraphicsDepthEffects" },
    { "computeEffects", "graphicsComputeEffects", "raidGraphicsComputeEffects" },
    { "outlineMode", "graphicsOutlineMode", "raidGraphicsOutlineMode" },
    { "textureResolution", "graphicsTextureResolution", "raidGraphicsTextureResolution" },
    { "spellDensity", "graphicsSpellDensity", "raidGraphicsSpellDensity" },
    { "projectedTextures", "graphicsProjectedTextures", "raidGraphicsProjectedTextures" },
    { "viewDistance", "graphicsViewDistance", "raidGraphicsViewDistance" },
    { "environmentDetail", "graphicsEnvironmentDetail", "raidGraphicsEnvironmentDetail" },
    { "groundClutter", "graphicsGroundClutter", "raidGraphicsGroundClutter" },
    { "textureFilteringMode", "textureFilteringMode" },
    { "shadowRT", "shadowrt" },
    { "sunShafts", "sunShafts" },
    { "resampleQuality", "ResampleQuality" },
    { "vrsMode", "vrsValar" },
    { "resampleSharpness", "ResampleSharpness" },
    { "contrast", "Contrast" },
    { "brightness", "Brightness" },
    { "gamma", "Gamma" },
    { "useMaxFPS", "useMaxFPS" },
    { "maxFPS", "maxFPS" },
    { "useMaxFPSBk", "useMaxFPSBk" },
    { "maxFPSBk", "maxFPSBk" },
    { "useTargetFPS", "useTargetFPS" },
    { "targetFPS", "targetFPS" },
}

local defaults = {
    solo = { spellDensity = 0, particleDensity = 3, projectedTextures = 1, environmentDetail = 7,
        depthEffects = 3, textureResolution = 2, groundClutter = 7, SSAOSetting = 3,
        viewDistance = 7, shadowQuality = 3, computeEffects = 2, liquidDetail = 2,
        textureFilteringMode = 5, shadowRT = 0, sunShafts = 0 },
    scenario = { spellDensity = 0, particleDensity = 2, projectedTextures = 1, environmentDetail = 4,
        depthEffects = 3, textureResolution = 2, groundClutter = 5, SSAOSetting = 2,
        viewDistance = 4, shadowQuality = 1, computeEffects = 2, liquidDetail = 1,
        textureFilteringMode = 5, shadowRT = 0, sunShafts = 0 },
    group = { spellDensity = 0, particleDensity = 2, projectedTextures = 1, environmentDetail = 4,
        depthEffects = 3, textureResolution = 2, groundClutter = 5, SSAOSetting = 3,
        viewDistance = 5, shadowQuality = 2, computeEffects = 2, liquidDetail = 2,
        textureFilteringMode = 5, shadowRT = 0, sunShafts = 0 },
    raid = { spellDensity = 0, particleDensity = 1, projectedTextures = 1, environmentDetail = 4,
        depthEffects = 1, textureResolution = 2, groundClutter = 3, SSAOSetting = 1,
        viewDistance = 3, shadowQuality = 0, computeEffects = 1, liquidDetail = 1,
        textureFilteringMode = 5, shadowRT = 0, sunShafts = 0 },
}

function RGS:GetCVarNumber(name)
    if not name then return nil end
    local value = GetCVar(name)
    if value == nil or value == "" then return nil end
    return tonumber(value)
end

function RGS:IsSettingAvailable(setting)
    return self:GetCVarNumber(setting[2]) ~= nil
end

function RGS:UseRaidBank(profileType)
    return profileType == "raid" and self:GetCVarNumber("RAIDsettingsEnabled") == 1
end

function RGS:GetSettingCVar(setting, profileType)
    if self:UseRaidBank(profileType) and setting[3] and self:GetCVarNumber(setting[3]) ~= nil then
        return setting[3]
    end
    return setting[2]
end

function RGS:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("RGSDB", { profile = defaults }, true)
    self.db.RegisterCallback(self, "OnProfileChanged", "ProfileChanged")
    self.db.RegisterCallback(self, "OnProfileCopied", "ProfileChanged")
    self.db.RegisterCallback(self, "OnProfileReset", "ProfileChanged")

    AceConfig:RegisterOptionsTable("RGS", self.options)
    local _, categoryID = AceConfigDialog:AddToBlizOptions("RGS", "Rhodan's Graphical Settings", nil, "solo")
    self.optionsCategory = categoryID
    for _, name in ipairs({ "scenario", "group", "raid" }) do
        AceConfigDialog:AddToBlizOptions("RGS", name:sub(1, 1):upper() .. name:sub(2), "Rhodan's Graphical Settings", name)
    end
    AceConfig:RegisterOptionsTable("RGS Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db))
    AceConfigDialog:AddToBlizOptions("RGS Profiles", "Profiles", "Rhodan's Graphical Settings")
end

function RGS:ProfileChanged()
    self.activeProfileType = nil
    self:UpdateGraphicsSettingsBasedOnGroupStatus(true)
end

function RGS:UpdateProfileWithCurrentSettings(profileType)
    local profile = self.db and self.db.profile[profileType]
    if not profile then return end
    local count = 0
    for _, setting in ipairs(self.settings) do
        local value = self:GetCVarNumber(self:GetSettingCVar(setting, profileType))
        if value ~= nil then
            profile[setting[1]] = value
            count = count + 1
        end
    end
    if count == 0 then
        self:Print("No supported graphics settings were available to capture on this client.")
        return
    end
    self:Print(profileType .. " profile captured " .. count .. " current graphics settings" ..
        (self:UseRaidBank(profileType) and " from Blizzard's Raid and Battleground tab." or " from Blizzard's Base tab and Advanced settings."))
    LibStub("AceConfigRegistry-3.0"):NotifyChange("RGS")
end

function RGS:ApplyProfileSettings(profileType)
    local profile = self.db and self.db.profile[profileType]
    if not profile then return end
    for _, setting in ipairs(self.settings) do
        local name = self:GetSettingCVar(setting, profileType)
        local value = profile[setting[1]]
        if value ~= nil and self:GetCVarNumber(name) ~= nil and self:GetCVarNumber(name) ~= value then
            SetCVar(name, tostring(value))
        end
    end
end

function RGS:GetCurrentProfileType()
    local inInstance, instanceType = IsInInstance()
    if inInstance then
        if instanceType == "raid" or instanceType == "pvp" or instanceType == "arena" then return "raid" end
        if instanceType == "scenario" then return "scenario" end
        if instanceType == "party" then return "group" end
    end
    if C_Scenario and C_Scenario.IsInScenario and C_Scenario.IsInScenario() then return "scenario" end
    if IsInRaid and IsInRaid() then return "raid" end
    if GetNumGroupMembers() > 0 then return "group" end
    return "solo"
end

function RGS:UpdateGraphicsSettingsBasedOnGroupStatus(force)
    if not self.db then return end
    local profileType = self:GetCurrentProfileType()
    if force or self.activeProfileType ~= profileType then
        self.activeProfileType = profileType
        self:ApplyProfileSettings(profileType)
    end
end
