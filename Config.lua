--[[ 

Config.lua

]]


---------------------------
-- 1. Declarations
---------------------------

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local RGS = LibStub("AceAddon-3.0"):GetAddon("RGS")

RGS = RGS or {}


---------------------------
-- 2. Options Table
---------------------------

-- Inside your options table
RGS.options = {
    name = "Rhodan's Graphical Automation Settings",
    type = "group",
    args = {
        solo = {
            name = "Solo",
            type = "group",
            args = {
				updateSettingsButton = {
					type = "execute",
					name = "Update Settings",
					desc = "Update this profile with the current in-game graphics settings.",
					order = 1,  -- Adjust the order to place the button correctly in the list
					func = function() RGS:UpdateProfileWithCurrentSettings("solo") end,
				},
                shadowQuality = {
                    type = "select",
                    name = "Shadow Quality",
					desc = "Controls both the method and quality of shadows. Decreasing this may greatly improve performance.\n\n" ..
						   "Ultra High: High-resolution environment and unit soft shadows, very far distance.\n\n" ..
						   "High: High-resolution environment and unit soft shadows, far distance.\n\n" ..
						   "Good: Low-resolution environment and unit shadows, medium distance.\n\n" ..
						   "Fair: Low-resolution environment, close distance unit shadows.\n\n" ..
						   "Low: Blob shadows.\n\n" ..
						   "Off: No shadows.",
					order = 2,
					values = {
						[5] = "Ultra-High",
						[4] = "Ultra",
						[3] = "High",
						[2] = "Good",
						[1] = "Fair",
						[0] = "Low"
					},
                    get = function(info) return RGS.db.profile.solo.shadowQuality end,
					set = function(info, value)
						RGS.db.profile.solo.shadowQuality = value						
					end,
                },
                liquidDetail = {
                    type = "select",
                    name = "Liquid Detail",
					desc = "Controls the rendering quality of liquids. Decreasing this may improve performance.\n\n" ..
						   "Ultra-High: Maximum map liquid textures, procedural ripples, and full reflection.\n\n" ..
						   "High: Normal map liquid textures, procedural ripples, and screen-based reflection.\n\n" ..
						   "Good: Normal map liquid textures, and texture-based ripples and sky reflection.\n\n" ..
						   "Fair: Normal map liquid textures, no reflection, and sky reflection.\n\n" ..
						   "Low: Animated liquid textures, texture-based ripples, and no reflection.",
					order = 3,
					values = {
						[3] = "High",
						[2] = "Good",
						[1] = "Fair",
						[1] = "Low"
					},
                    get = function(info) return RGS.db.profile.solo.liquidDetail end,
					set = function(info, value)
						RGS.db.profile.solo.liquidDetail = value						
					end,
                },
                particleDensity = {
                    type = "select",
                    name = "Particle Density",
					desc = "Controls the number of particles used in effects caused by spells, fires, etc. Decrease to improve performance.",
					order = 4,
					values = {
						[5] = "Ultra",
						[4] = "High",
						[3] = "Good",
						[2] = "Fair",
						[1] = "Low",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.solo.particleDensity end,
					set = function(info, value)
						RGS.db.profile.solo.particleDensity = value						
					end,
                },
                SSAOSetting = {
                    type = "select",
                    name = "SSAO",
					desc = "Controls the rendering quality of the advanced lighting effects. Decreasing this may greatly improve performance.",
					order = 5,
					values = {
						[4] = "Ultra",
						[3] = "High",
						[2] = "Good",
						[1] = "Low",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.solo.SSAOSetting end,
					set = function(info, value)
						RGS.db.profile.solo.SSAOSetting = value						
					end,
                },
                depthEffects = {
                    type = "select",
                    name = "Depth Effects",
					desc = "Controls the rendering of depth-based particle effects. Decreasing this may improve performance.\n\n" ..
						   "High: Particle depth fading and full-resolution refraction. Depth-based sunshafts and glare with improved sampling.\n\n" ..
						   "Good: Particle depth fading and low-resolution refraction. Depth-based sunshafts and glare.\n\n" ..
						   "Fair: Particle depth fading and no glare. Traditional sunshafts and refraction.\n\n" ..
						   "Low: No particle depth fading or glare. Depth-based sunshafts and traditional refraction.",
					order = 6,
					values = {
						[3] = "High",
						[2] = "Good",
						[1] = "Low",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.solo.depthEffects end,
					set = function(info, value)
						RGS.db.profile.solo.depthEffects = value						
					end,
                },
                computeEffects = {
                    type = "select",
                    name = "Compute Effects",
					desc = "Controls the quality of Compute-based effects such as Volumetric Fog and some particle effects. " ..
						   "Compute-based effects may be more expensive for older graphics cards.\n\n" ..
						   "Disabled: Volume fog disabled, compute-based particle collision disabled.\n\n" ..
						   "Low: Low resolution, single pass volume fog with reduced placements.\n\n" ..
						   "Good: Medium-resolution volume fog.\n\n" ..
						   "High: High-resolution volume fog.\n\n" ..
						   "Ultra: Ultra-resolution volume fog with additional placements.",
					order = 7,
					values = {
						[4] = "Ultra",
						[3] = "High",
						[2] = "Good",
						[1] = "Low",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.solo.computeEffects end,
					set = function(info, value)
						RGS.db.profile.solo.computeEffects = value
					end,
                },
                textureResolution = {
                    type = "select",
                    name = "Texture Resolution",
					desc = "Controls the level of all texture detail. Decreasing this may slightly improve performance.\n\n" ..
						   "High: High-resolution environment textures, high-detail terrain blending, and high-resolution character textures.\n\n" ..
						   "Fair: Medium-resolution environment textures, low-detail terrain blending, and low-resolution character textures.\n\n" ..
						   "Low: Low-resolution environment textures, very low-detail terrain blending, and low-resolution character textures.\n\n" ..
							"|cffff0000Modifying setting from base/current increases momentarily the lag on graphic setting change.|r",
					order = 8,
					values = {
						[2] = "High",
						[1] = "Fair",
						[0] = "Low"
					},
                    get = function(info) return RGS.db.profile.solo.textureResolution end,
					set = function(info, value)
						RGS.db.profile.solo.textureResolution = value
					end,
                },
                spellDensity = {
                    type = "select",
                    name = "Spell Density",
					desc = "Controls visibility of non-essential spells. Helps manage visual clutter and performance during combat.\n\n" ..
						   "Essential: Only show essential spells. Your own spells are always shown.\n\n" ..
						   "Some: Reduce non-essential spells shown by around 75%.\n\n" ..
						   "Half: Reduce non-essential spells shown by around 50%.\n\n" ..
						   "Most: Reduce non-essential spells shown based on framerate. If you are above your desired framerate, everything will be shown.\n\n" ..
						   "Everything: Always show all spells.",
					order = 9,
					values = {
						[0] = "Essential",
						[1] = "Some",
						[2] = "Half",
						[3] = "Most",
						[4] = "Dynamic",
						[5] = "Everything"
					},
                    get = function(info) return RGS.db.profile.solo.spellDensity end,
					set = function(info, value)
						RGS.db.profile.solo.spellDensity = value						
					end,
                },
                projectedTextures = {
                    type = "select",
                    name = "Projected Textures",
					desc = "Enables the projecting of textures to the environment. Disabling this may improve performance.",
					order = 10,
					values = {
						[1] = "Enabled",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.solo.projectedTextures end,
					set = function(info, value)
						RGS.db.profile.solo.projectedTextures = value						
					end,
                },
                viewDistance = {
                    type = "range",
                    name = "View Distance",
					desc = "View distance controls how far you can see. Larger view distances require more memory and a faster processor.",
					order = 11,
                    min = 1,
                    max = 10,
                    step = 1,
                    get = function(info) return RGS.db.profile.solo.viewDistance end,
					set = function(info, value)
						RGS.db.profile.solo.viewDistance = value						
					end,
                },
                environmentDetail = {
                    type = "range",
                    name = "Environment Detail",
					desc = "Controls how far you can see objects. Decrease to improve performance.",
					order = 12,
                    min = 1,
                    max = 10,
                    step = 1,
                    get = function(info) return RGS.db.profile.solo.environmentDetail end,
					set = function(info, value)
						RGS.db.profile.solo.environmentDetail = value						
					end,
                },
                groundClutter = {
                    type = "range",
                    name = "Ground Clutter",
					desc = "Controls the density and the distance at which ground clutter items, like grass and foilage, are placed. Decrease to improve performance.",
					order = 13,
                    min = 1,
                    max = 10,
                    step = 1,
                    get = function(info) return RGS.db.profile.solo.groundClutter end,
					set = function(info, value)
						RGS.db.profile.solo.groundClutter = value						
					end,
                },
            },
        },
        scenario = {
            name = "Scenario",
            type = "group",
            args = {
				updateSettingsButton = {
					type = "execute",
					name = "Update Settings",
					desc = "Update this profile with the current in-game graphics settings.",
					order = 1,  -- Adjust the order to place the button correctly in the list
					func = function() RGS:UpdateProfileWithCurrentSettings("scenario") end,
				},
                shadowQuality = {
                    type = "select",
                    name = "Shadow Quality",
					desc = "Controls both the method and quality of shadows. Decreasing this may greatly improve performance.\n\n" ..
						   "Ultra High: High-resolution environment and unit soft shadows, very far distance.\n\n" ..
						   "High: High-resolution environment and unit soft shadows, far distance.\n\n" ..
						   "Good: Low-resolution environment and unit shadows, medium distance.\n\n" ..
						   "Fair: Low-resolution environment, close distance unit shadows.\n\n" ..
						   "Low: Blob shadows.\n\n" ..
						   "Off: No shadows.",
					order = 2,
					values = {
						[5] = "Ultra-High",
						[4] = "Ultra",
						[3] = "High",
						[2] = "Good",
						[1] = "Fair",
						[0] = "Low"
					},
                    get = function(info) return RGS.db.profile.scenario.shadowQuality end,
					set = function(info, value)
						RGS.db.profile.scenario.shadowQuality = value						
					end,
                },
                liquidDetail = {
                    type = "select",
                    name = "Liquid Detail",
					desc = "Controls the rendering quality of liquids. Decreasing this may improve performance.\n\n" ..
						   "Ultra-High: Maximum map liquid textures, procedural ripples, and full reflection.\n\n" ..
						   "High: Normal map liquid textures, procedural ripples, and screen-based reflection.\n\n" ..
						   "Good: Normal map liquid textures, and texture-based ripples and sky reflection.\n\n" ..
						   "Fair: Normal map liquid textures, no reflection, and sky reflection.\n\n" ..
						   "Low: Animated liquid textures, texture-based ripples, and no reflection.",
					order = 3,
					values = {
						[3] = "High",
						[2] = "Good",
						[1] = "Fair",
						[1] = "Low"
					},
                    get = function(info) return RGS.db.profile.scenario.liquidDetail end,
					set = function(info, value)
						RGS.db.profile.scenario.liquidDetail = value						
					end,
                },
                particleDensity = {
                    type = "select",
                    name = "Particle Density",
					desc = "Controls the number of particles used in effects caused by spells, fires, etc. Decrease to improve performance.",
					order = 4,
					values = {
						[5] = "Ultra",
						[4] = "High",
						[3] = "Good",
						[2] = "Fair",
						[1] = "Low",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.scenario.particleDensity end,
					set = function(info, value)
						RGS.db.profile.scenario.particleDensity = value						
					end,
                },
                SSAOSetting = {
                    type = "select",
                    name = "SSAO",
					desc = "Controls the rendering quality of the advanced lighting effects. Decreasing this may greatly improve performance.",
					order = 5,
					values = {
						[4] = "Ultra",
						[3] = "High",
						[2] = "Good",
						[1] = "Low",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.scenario.SSAOSetting end,
					set = function(info, value)
						RGS.db.profile.scenario.SSAOSetting = value						
					end,
                },
                depthEffects = {
                    type = "select",
                    name = "Depth Effects",
					desc = "Controls the rendering of depth-based particle effects. Decreasing this may improve performance.\n\n" ..
						   "High: Particle depth fading and full-resolution refraction. Depth-based sunshafts and glare with improved sampling.\n\n" ..
						   "Good: Particle depth fading and low-resolution refraction. Depth-based sunshafts and glare.\n\n" ..
						   "Fair: Particle depth fading and no glare. Traditional sunshafts and refraction.\n\n" ..
						   "Low: No particle depth fading or glare. Depth-based sunshafts and traditional refraction.",
					order = 6,
					values = {
						[3] = "High",
						[2] = "Good",
						[1] = "Low",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.scenario.depthEffects end,
					set = function(info, value)
						RGS.db.profile.scenario.depthEffects = value						
					end,
                },
                computeEffects = {
                    type = "select",
                    name = "Compute Effects",
					desc = "Controls the quality of Compute-based effects such as Volumetric Fog and some particle effects. " ..
						   "Compute-based effects may be more expensive for older graphics cards.\n\n" ..
						   "Disabled: Volume fog disabled, compute-based particle collision disabled.\n\n" ..
						   "Low: Low resolution, single pass volume fog with reduced placements.\n\n" ..
						   "Good: Medium-resolution volume fog.\n\n" ..
						   "High: High-resolution volume fog.\n\n" ..
						   "Ultra: Ultra-resolution volume fog with additional placements.",
					order = 7,
					values = {
						[4] = "Ultra",
						[3] = "High",
						[2] = "Good",
						[1] = "Low",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.scenario.computeEffects end,
					set = function(info, value)
						RGS.db.profile.scenario.computeEffects = value
					end,
                },
                textureResolution = {
                    type = "select",
                    name = "Texture Resolution",
					desc = "Controls the level of all texture detail. Decreasing this may slightly improve performance.\n\n" ..
						   "High: High-resolution environment textures, high-detail terrain blending, and high-resolution character textures.\n\n" ..
						   "Fair: Medium-resolution environment textures, low-detail terrain blending, and low-resolution character textures.\n\n" ..
						   "Low: Low-resolution environment textures, very low-detail terrain blending, and low-resolution character textures.\n\n" ..
							"|cffff0000Modifying setting from base/current increases momentarily the lag on graphic setting change.|r",
					order = 8,
					values = {
						[2] = "High",
						[1] = "Fair",
						[0] = "Low"
					},
                    get = function(info) return RGS.db.profile.scenario.textureResolution end,
					set = function(info, value)
						RGS.db.profile.scenario.textureResolution = value
					end,
                },
                spellDensity = {
                    type = "select",
                    name = "Spell Density",
					desc = "Controls visibility of non-essential spells. Helps manage visual clutter and performance during combat.\n\n" ..
						   "Essential: Only show essential spells. Your own spells are always shown.\n\n" ..
						   "Some: Reduce non-essential spells shown by around 75%.\n\n" ..
						   "Half: Reduce non-essential spells shown by around 50%.\n\n" ..
						   "Most: Reduce non-essential spells shown based on framerate. If you are above your desired framerate, everything will be shown.\n\n" ..
						   "Everything: Always show all spells.",
					order = 9,
					values = {
						[0] = "Essential",
						[1] = "Some",
						[2] = "Half",
						[3] = "Most",
						[4] = "Dynamic",
						[5] = "Everything"
					},
                    get = function(info) return RGS.db.profile.scenario.spellDensity end,
					set = function(info, value)
						RGS.db.profile.scenario.spellDensity = value						
					end,
                },
                projectedTextures = {
                    type = "select",
                    name = "Projected Textures",
					desc = "Enables the projecting of textures to the environment. Disabling this may improve performance.",
					order = 10,
					values = {
						[1] = "Enabled",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.scenario.projectedTextures end,
					set = function(info, value)
						RGS.db.profile.scenario.projectedTextures = value						
					end,
                },
                viewDistance = {
                    type = "range",
                    name = "View Distance",
					desc = "View distance controls how far you can see. Larger view distances require more memory and a faster processor.",
					order = 11,
                    min = 1,
                    max = 10,
                    step = 1,
                    get = function(info) return RGS.db.profile.scenario.viewDistance end,
					set = function(info, value)
						RGS.db.profile.scenario.viewDistance = value						
					end,
                },
                environmentDetail = {
                    type = "range",
                    name = "Environment Detail",
					desc = "Controls how far you can see objects. Decrease to improve performance.",
					order = 12,
                    min = 1,
                    max = 10,
                    step = 1,
                    get = function(info) return RGS.db.profile.scenario.environmentDetail end,
					set = function(info, value)
						RGS.db.profile.scenario.environmentDetail = value						
					end,
                },
                groundClutter = {
                    type = "range",
                    name = "Ground Clutter",
					desc = "Controls the density and the distance at which ground clutter items, like grass and foilage, are placed. Decrease to improve performance.",
					order = 13,
                    min = 1,
                    max = 10,
                    step = 1,
                    get = function(info) return RGS.db.profile.scenario.groundClutter end,
					set = function(info, value)
						RGS.db.profile.scenario.groundClutter = value						
					end,
                },
            },
        },
        group = {
            name = "Group",
            type = "group",
			order = 2,
            args = {
				updateSettingsButton = {
					type = "execute",
					name = "Update Settings",
					desc = "Update this profile with the current in-game graphics settings.",
					order = 1,  -- Adjust the order to place the button correctly in the list
					func = function() RGS:UpdateProfileWithCurrentSettings("group") end,
				},
                shadowQuality = {
                    type = "select",
                    name = "Shadow Quality",
					desc = "Controls both the method and quality of shadows. Decreasing this may greatly improve performance.\n\n" ..
						   "Ultra High: High-resolution environment and unit soft shadows, very far distance.\n\n" ..
						   "High: High-resolution environment and unit soft shadows, far distance.\n\n" ..
						   "Good: Low-resolution environment and unit shadows, medium distance.\n\n" ..
						   "Fair: Low-resolution environment, close distance unit shadows.\n\n" ..
						   "Low: Blob shadows.\n\n" ..
						   "Off: No shadows.",
					order = 2,
					values = {
						[5] = "Ultra-High",
						[4] = "Ultra",
						[3] = "High",
						[2] = "Good",
						[1] = "Fair",
						[0] = "Low"
					},
                    get = function(info) return RGS.db.profile.group.shadowQuality end,
					set = function(info, value)
						RGS.db.profile.group.shadowQuality = value						
					end,
                },
                liquidDetail = {
                    type = "select",
                    name = "Liquid Detail",
					desc = "Controls the rendering quality of liquids. Decreasing this may improve performance.\n\n" ..
						   "Ultra-High: Maximum map liquid textures, procedural ripples, and full reflection.\n\n" ..
						   "High: Normal map liquid textures, procedural ripples, and screen-based reflection.\n\n" ..
						   "Good: Normal map liquid textures, and texture-based ripples and sky reflection.\n\n" ..
						   "Fair: Normal map liquid textures, no reflection, and sky reflection.\n\n" ..
						   "Low: Animated liquid textures, texture-based ripples, and no reflection.",
					order = 3,
					values = {
						[3] = "High",
						[2] = "Good",
						[1] = "Fair",
						[1] = "Low"
					},
                    get = function(info) return RGS.db.profile.group.liquidDetail end,
					set = function(info, value)
						RGS.db.profile.group.liquidDetail = value						
					end,
                },
                particleDensity = {
                    type = "select",
                    name = "Particle Density",
					desc = "Controls the number of particles used in effects caused by spells, fires, etc. Decrease to improve performance.",
					order = 4,
					values = {
						[5] = "Ultra",
						[4] = "High",
						[3] = "Good",
						[2] = "Fair",
						[1] = "Low",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.group.particleDensity end,
					set = function(info, value)
						RGS.db.profile.group.particleDensity = value						
					end,
                },
                SSAOSetting = {
                    type = "select",
                    name = "SSAO",
					desc = "Controls the rendering quality of the advanced lighting effects. Decreasing this may greatly improve performance.",
					order = 5,
					values = {
						[4] = "Ultra",
						[3] = "High",
						[2] = "Good",
						[1] = "Low",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.group.SSAOSetting end,
					set = function(info, value)
						RGS.db.profile.group.SSAOSetting = value						
					end,
                },
                depthEffects = {
                    type = "select",
                    name = "Depth Effects",
					desc = "Controls the rendering of depth-based particle effects. Decreasing this may improve performance.\n\n" ..
						   "High: Particle depth fading and full-resolution refraction. Depth-based sunshafts and glare with improved sampling.\n\n" ..
						   "Good: Particle depth fading and low-resolution refraction. Depth-based sunshafts and glare.\n\n" ..
						   "Fair: Particle depth fading and no glare. Traditional sunshafts and refraction.\n\n" ..
						   "Low: No particle depth fading or glare. Depth-based sunshafts and traditional refraction.",
					order = 6,
					values = {
						[3] = "High",
						[2] = "Good",
						[1] = "Low",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.group.depthEffects end,
					set = function(info, value)
						RGS.db.profile.group.depthEffects = value						
					end,
                },
                computeEffects = {
                    type = "select",
                    name = "Compute Effects",
					desc = "Controls the quality of Compute-based effects such as Volumetric Fog and some particle effects. " ..
						   "Compute-based effects may be more expensive for older graphics cards.\n\n" ..
						   "Disabled: Volume fog disabled, compute-based particle collision disabled.\n\n" ..
						   "Low: Low resolution, single pass volume fog with reduced placements.\n\n" ..
						   "Good: Medium-resolution volume fog.\n\n" ..
						   "High: High-resolution volume fog.\n\n" ..
						   "Ultra: Ultra-resolution volume fog with additional placements.",
					order = 7,
					values = {
						[4] = "Ultra",
						[3] = "High",
						[2] = "Good",
						[1] = "Low",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.group.computeEffects end,
					set = function(info, value)
						RGS.db.profile.group.computeEffects = value						
					end,
                },
                textureResolution = {
                    type = "select",
                    name = "Texture Resolution",
					desc = "Controls the level of all texture detail. Decreasing this may slightly improve performance.\n\n" ..
						   "High: High-resolution environment textures, high-detail terrain blending, and high-resolution character textures.\n\n" ..
						   "Fair: Medium-resolution environment textures, low-detail terrain blending, and low-resolution character textures.\n\n" ..
						   "Low: Low-resolution environment textures, very low-detail terrain blending, and low-resolution character textures.\n\n" ..
							"|cffff0000Modifying setting from base/current increases momentarily the lag on graphic setting change.|r",
					order = 8,
					values = {
						[2] = "High",
						[1] = "Fair",
						[0] = "Low"
					},
                    get = function(info) return RGS.db.profile.group.textureResolution end,
					set = function(info, value)
						RGS.db.profile.group.textureResolution = value						
					end,
                },
                spellDensity = {
                    type = "select",
                    name = "Spell Density",
					desc = "Controls visibility of non-essential spells. Helps manage visual clutter and performance during combat.\n\n" ..
						   "Essential: Only show essential spells. Your own spells are always shown.\n\n" ..
						   "Some: Reduce non-essential spells shown by around 75%.\n\n" ..
						   "Half: Reduce non-essential spells shown by around 50%.\n\n" ..
						   "Most: Reduce non-essential spells shown based on framerate. If you are above your desired framerate, everything will be shown.\n\n" ..
						   "Everything: Always show all spells.",
					order = 9,
					values = {
						[0] = "Essential",
						[1] = "Some",
						[2] = "Half",
						[3] = "Most",
						[4] = "Dynamic",
						[5] = "Everything"
					},
                    get = function(info) return RGS.db.profile.group.spellDensity end,
					set = function(info, value)
						RGS.db.profile.group.spellDensity = value						
					end,
                },
                projectedTextures = {
                    type = "select",
                    name = "Projected Textures",
					desc = "Enables the projecting of textures to the environment. Disabling this may improve performance.",
					order = 10,
					values = {
						[1] = "Enabled",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.group.projectedTextures end,
					set = function(info, value)
						RGS.db.profile.group.projectedTextures = value						
					end,
                },
                viewDistance = {
                    type = "range",
                    name = "View Distance",
					desc = "View distance controls how far you can see. Larger view distances require more memory and a faster processor.",
					order = 11,
                    min = 1,
                    max = 10,
                    step = 1,
                    get = function(info) return RGS.db.profile.group.viewDistance end,
					set = function(info, value)
						RGS.db.profile.group.viewDistance = value						
					end,
                },
                environmentDetail = {
                    type = "range",
                    name = "Environment Detail",
					desc = "Controls how far you can see objects. Decrease to improve performance.",
					order = 12,
                    min = 1,
                    max = 10,
                    step = 1,
                    get = function(info) return RGS.db.profile.group.environmentDetail end,
					set = function(info, value)
						RGS.db.profile.group.environmentDetail = value						
					end,
                },
                groundClutter = {
                    type = "range",
                    name = "Ground Clutter",
					desc = "Controls the density and the distance at which ground clutter items, like grass and foilage, are placed. Decrease to improve performance.",
					order = 13,
                    min = 1,
                    max = 10,
                    step = 1,
                    get = function(info) return RGS.db.profile.group.groundClutter end,
					set = function(info, value)
						RGS.db.profile.group.groundClutter = value						
					end,
                },
            },
        },
        raid = {
            name = "Raid",
            type = "group",
			order = 3,
            args = {
				updateSettingsButton = {
					type = "execute",
					name = "Update Settings",
					desc = "Update this profile with the current in-game graphics settings.",
					order = 1,  -- Adjust the order to place the button correctly in the list
					func = function() RGS:UpdateProfileWithCurrentSettings("raid") end,
				},
                shadowQuality = {
                    type = "select",
                    name = "Shadow Quality",
					desc = "Controls both the method and quality of shadows. Decreasing this may greatly improve performance.\n\n" ..
						   "Ultra High: High-resolution environment and unit soft shadows, very far distance.\n\n" ..
						   "High: High-resolution environment and unit soft shadows, far distance.\n\n" ..
						   "Good: Low-resolution environment and unit shadows, medium distance.\n\n" ..
						   "Fair: Low-resolution environment, close distance unit shadows.\n\n" ..
						   "Low: Blob shadows.\n\n" ..
						   "Off: No shadows.",
					order = 2,
					values = {
						[5] = "Ultra-High",
						[4] = "Ultra",
						[3] = "High",
						[2] = "Good",
						[1] = "Fair",
						[0] = "Low"
					},
                    get = function(info) return RGS.db.profile.raid.shadowQuality end,
					set = function(info, value)
						RGS.db.profile.raid.shadowQuality = value						
					end,
                },
                liquidDetail = {
                    type = "select",
                    name = "Liquid Detail",
					desc = "Controls the rendering quality of liquids. Decreasing this may improve performance.\n\n" ..
						   "Ultra-High: Maximum map liquid textures, procedural ripples, and full reflection.\n\n" ..
						   "High: Normal map liquid textures, procedural ripples, and screen-based reflection.\n\n" ..
						   "Good: Normal map liquid textures, and texture-based ripples and sky reflection.\n\n" ..
						   "Fair: Normal map liquid textures, no reflection, and sky reflection.\n\n" ..
						   "Low: Animated liquid textures, texture-based ripples, and no reflection.",
					order = 3,
					values = {
						[3] = "High",
						[2] = "Good",
						[1] = "Fair",
						[1] = "Low"
					},
                    get = function(info) return RGS.db.profile.raid.liquidDetail end,
					set = function(info, value)
						RGS.db.profile.raid.liquidDetail = value						
					end,
                },
                particleDensity = {
                    type = "select",
                    name = "Particle Density",
					desc = "Controls the number of particles used in effects caused by spells, fires, etc. Decrease to improve performance.",
					order = 4,
					values = {
						[5] = "Ultra",
						[4] = "High",
						[3] = "Good",
						[2] = "Fair",
						[1] = "Low",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.raid.particleDensity end,
					set = function(info, value)
						RGS.db.profile.raid.particleDensity = value						
					end,
                },
                SSAOSetting = {
                    type = "select",
                    name = "SSAO",
					desc = "Controls the rendering quality of the advanced lighting effects. Decreasing this may greatly improve performance.",
					order = 5,
					values = {
						[4] = "Ultra",
						[3] = "High",
						[2] = "Good",
						[1] = "Low",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.raid.SSAOSetting end,
					set = function(info, value)
						RGS.db.profile.raid.SSAOSetting = value						
					end,
                },
                depthEffects = {
                    type = "select",
                    name = "Depth Effects",
					desc = "Controls the rendering of depth-based particle effects. Decreasing this may improve performance.\n\n" ..
						   "High: Particle depth fading and full-resolution refraction. Depth-based sunshafts and glare with improved sampling.\n\n" ..
						   "Good: Particle depth fading and low-resolution refraction. Depth-based sunshafts and glare.\n\n" ..
						   "Fair: Particle depth fading and no glare. Traditional sunshafts and refraction.\n\n" ..
						   "Low: No particle depth fading or glare. Depth-based sunshafts and traditional refraction.",
					order = 6,
					values = {
						[3] = "High",
						[2] = "Good",
						[1] = "Low",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.raid.depthEffects end,
					set = function(info, value)
						RGS.db.profile.raid.depthEffects = value						
					end,
                },
                computeEffects = {
                    type = "select",
                    name = "Compute Effects",
					desc = "Controls the quality of Compute-based effects such as Volumetric Fog and some particle effects. " ..
						   "Compute-based effects may be more expensive for older graphics cards.\n\n" ..
						   "Disabled: Volume fog disabled, compute-based particle collision disabled.\n\n" ..
						   "Low: Low resolution, single pass volume fog with reduced placements.\n\n" ..
						   "Good: Medium-resolution volume fog.\n\n" ..
						   "High: High-resolution volume fog.\n\n" ..
						   "Ultra: Ultra-resolution volume fog with additional placements.",
					order = 7,
					values = {
						[4] = "Ultra",
						[3] = "High",
						[2] = "Good",
						[1] = "Low",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.raid.computeEffects end,
					set = function(info, value)
						RGS.db.profile.raid.computeEffects = value						
					end,
                },
                textureResolution = {
                    type = "select",
                    name = "Texture Resolution",
					desc = "Controls the level of all texture detail. Decreasing this may slightly improve performance.\n\n" ..
						   "High: High-resolution environment textures, high-detail terrain blending, and high-resolution character textures.\n\n" ..
						   "Fair: Medium-resolution environment textures, low-detail terrain blending, and low-resolution character textures.\n\n" ..
						   "Low: Low-resolution environment textures, very low-detail terrain blending, and low-resolution character textures.\n\n" ..
							"|cffff0000Modifying setting from base/current increases momentarily the lag on graphic setting change.|r",
					order = 8,
					values = {
						[2] = "High",
						[1] = "Fair",
						[0] = "Low"
					},
                    get = function(info) return RGS.db.profile.raid.textureResolution end,
					set = function(info, value)
						RGS.db.profile.raid.textureResolution = value						
					end,
                },
                spellDensity = {
                    type = "select",
                    name = "Spell Density",
					desc = "Controls visibility of non-essential spells. Helps manage visual clutter and performance during combat.\n\n" ..
						   "Essential: Only show essential spells. Your own spells are always shown.\n\n" ..
						   "Some: Reduce non-essential spells shown by around 75%.\n\n" ..
						   "Half: Reduce non-essential spells shown by around 50%.\n\n" ..
						   "Most: Reduce non-essential spells shown based on framerate. If you are above your desired framerate, everything will be shown.\n\n" ..
						   "Everything: Always show all spells.",
					order = 9,
					values = {
						[0] = "Essential",
						[1] = "Some",
						[2] = "Half",
						[3] = "Most",
						[4] = "Dynamic",
						[5] = "Everything"
					},
                    get = function(info) return RGS.db.profile.raid.spellDensity end,
					set = function(info, value)
						RGS.db.profile.raid.spellDensity = value						
					end,
                },
                projectedTextures = {
                    type = "select",
                    name = "Projected Textures",
					desc = "Enables the projecting of textures to the environment. Disabling this may improve performance.",
					order = 10,
					values = {
						[1] = "Enabled",
						[0] = "Disabled"
					},
                    get = function(info) return RGS.db.profile.raid.projectedTextures end,
					set = function(info, value)
						RGS.db.profile.raid.projectedTextures = value						
					end,
                },
                viewDistance = {
                    type = "range",
                    name = "View Distance",
					desc = "View distance controls how far you can see. Larger view distances require more memory and a faster processor.",
					order = 11,
                    min = 1,
                    max = 10,
                    step = 1,
                    get = function(info) return RGS.db.profile.raid.viewDistance end,
					set = function(info, value)
						RGS.db.profile.raid.viewDistance = value						
					end,
                },
                environmentDetail = {
                    type = "range",
                    name = "Environment Detail",
					desc = "Controls how far you can see objects. Decrease to improve performance.",
					order = 12,
                    min = 1,
                    max = 10,
                    step = 1,
                    get = function(info) return RGS.db.profile.raid.environmentDetail end,
					set = function(info, value)
						RGS.db.profile.raid.environmentDetail = value						
					end,
                },
                groundClutter = {
                    type = "range",
                    name = "Ground Clutter",
					desc = "Controls the density and the distance at which ground clutter items, like grass and foilage, are placed. Decrease to improve performance.",
					order = 13,
                    min = 1,
                    max = 10,
                    step = 1,
                    get = function(info) return RGS.db.profile.raid.groundClutter end,
					set = function(info, value)
						RGS.db.profile.raid.groundClutter = value						
					end,
                },
            },
        },
    },
}


---------------------------
-- 3. Setup Functions
---------------------------

function RGS:SetupOptions()
    AceConfig:RegisterOptionsTable("RGS", options)
    AceConfigDialog:AddToBlizOptions("RGS", "Rhodan's Graphical Settings")
end