local RGS = LibStub("AceAddon-3.0"):GetAddon("RGS")

function RGS:OnEnable()
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "RefreshGraphicsProfile")
    self:RegisterEvent("GROUP_ROSTER_UPDATE", "RefreshGraphicsProfile")
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "RefreshGraphicsProfile")
    self:RegisterEvent("CVAR_UPDATE", "CVarChanged")
    if C_Scenario and C_Scenario.IsInScenario then
        self:RegisterEvent("SCENARIO_UPDATE", "RefreshGraphicsProfile")
    end
end

function RGS:CVarChanged(_, name)
    if name and name:lower() == "raidsettingsenabled" then
        self:UpdateGraphicsSettingsBasedOnGroupStatus(true)
    end
end

function RGS:RefreshGraphicsProfile()
    self:UpdateGraphicsSettingsBasedOnGroupStatus()
end
