--[[ 

RGSMinimap.lua
Code for the creation of broker, minimap, icons, textures and click events

]]


---------------------------
-- 1. Declarations
---------------------------

RGS = RGS or {}  -- Initialize the RGS table if it's not already initialized

-- Assuming RGS is your main addon table
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")


---------------------------
-- 2. Data Broker
---------------------------

-- Create a Data Broker object
RGS.dataBroker = ldb:NewDataObject("RGS", {
    type = "launcher",
    icon = "Interface\\Addons\\RGS\\RGSicon.tga",
    OnClick = function(_, button)
		if button == "RightButton" or "LeftButton" then
			-- Open the add-on's configuration window
			InterfaceOptionsFrame_OpenToCategory("Rhodan's Graphical Settings")
			InterfaceOptionsFrame_OpenToCategory("Rhodan's Graphical Settings")  -- Call twice to actually open the page
        end
    end,
    OnTooltipShow = function(tooltip)
        if not tooltip or not tooltip.AddLine then return end
        tooltip:AddLine("RGS - Rhodan's Graphical Settings")
        tooltip:AddLine("Left/Right click for Configuration.")
    end,
})


---------------------------
-- 3. Minimap Button
---------------------------

-- Blocking the Minimap button for now until have time to set an option to disable having it
-- -- Create the minimap button frame
-- RGS.MinimapButton = CreateFrame("Button", "MyMinimapButton", Minimap)
-- RGS.MinimapButton:SetSize(25, 25)  -- Set the size of the frame


-- -- Set up the texture for the button
-- RGS.MinimapButton:SetNormalTexture("Interface\\Addons\\RGS\\RGSicon")
-- RGS.MinimapButton:SetHighlightTexture("Interface\\Addons\\RGS\\RGSicon")
-- RGS.MinimapButton:SetPushedTexture("Interface\\Addons\\RGS\\RGSicon")


-- -- Set the position of the minimap button
-- RGS.MinimapButton:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 0, 0)


-- -- OnClick handler
-- RGS.MinimapButton:SetScript("OnClick", function()
	-- InterfaceOptionsFrame_OpenToCategory("Rhodan's Graphical Settings")
	-- InterfaceOptionsFrame_OpenToCategory("Rhodan's Graphical Settings")  -- Call twice to actually open the page
-- end)


-- -- Assuming MinimapButton is your minimap button
-- RGS.MinimapButton:SetMovable(true)
-- RGS.MinimapButton:EnableMouse(true)

-- RGS.MinimapButton:SetScript("OnDragStart", function(self)
    -- self:StartMoving()
-- end)

-- RGS.MinimapButton:SetScript("OnDragStop", function(self)
    -- self:StopMovingOrSizing()
-- end)

-- RGS.MinimapButton:RegisterForDrag("LeftButton")

-- -- Tooltip scripts
-- RGS.MinimapButton:SetScript("OnEnter", function(self)
    -- GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    -- GameTooltip:SetText("RGS - Rhodan's Graphical Settings", 1, 1, 1)
    -- GameTooltip:AddLine("Left-click for configuration.", 0.8, 0.8, 0.8, true)
    -- GameTooltip:Show()
-- end)