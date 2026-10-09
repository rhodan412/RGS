local RGS = LibStub("AceAddon-3.0"):GetAddon("RGS")
local LDB = LibStub("LibDataBroker-1.1")

RGS.dataBroker = LDB:NewDataObject("RGS", {
    type = "launcher",
    icon = "Interface\\AddOns\\RGS\\RGSicon.tga",
    OnClick = function(_, button)
        if button ~= "LeftButton" and button ~= "RightButton" then return end
        if Settings and Settings.OpenToCategory then
            Settings.OpenToCategory(RGS.optionsCategory or "Rhodan's Graphical Settings")
        elseif InterfaceOptionsFrame_OpenToCategory then
            InterfaceOptionsFrame_OpenToCategory(RGS.optionsCategory or "Rhodan's Graphical Settings")
        end
    end,
    OnTooltipShow = function(tooltip)
        if not tooltip or not tooltip.AddLine then return end
        tooltip:AddLine("RGS - Rhodan's Graphical Settings")
        tooltip:AddLine("Left or right click to open settings.")
    end,
})
