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
RGS.db = RGS.db or {}
RGS.db.profile = RGS.db.profile or {}

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
						[0] = "Low"
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
				textureFilteringMode = {
					type = "select",
					name = "Texture Filtering Mode",
					desc = "Increases texture sharpness, particularly for textures viewed at an angle.",
					order = 11,
					values = {
						[5] = "16x Anisotropic",
						[4] = "8x Anisotropic",
						[3] = "4x Anisotropic",
						[2] = "2x Anisotropic",
						[1] = "Trilinear",
						[0] = "Bilinear"
					},
					get = function(info) return RGS.db.profile.solo.textureFilteringMode end,
					set = function(info, value)
						RGS.db.profile.solo.textureFilteringMode = value						
					end,
				},
				viewDistance = {
					type = "range",
					name = "View Distance",
					desc = "View distance controls how far you can see. Larger view distances require more memory and a faster processor.",
					order = 12,
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
					order = 13,
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
					order = 14,
					min = 1,
					max = 10,
					step = 1,
					get = function(info) return RGS.db.profile.solo.groundClutter end,
					set = function(info, value)
						RGS.db.profile.solo.groundClutter = value						
					end,
				},
				shadowRT = {
					type = "select",
					name = "Raytraced Shadows",
					desc = "Improves shadow quality with ray tracing, which produces shadows with more nature softness, greatly increased precision and from additional light sources.\n\n" ..
						   "This feature requires:\n" ..
						   "A hardware ray tracing capable graphics card\n" ..
						   "Windows 10 May 2020 Update (version 2004)\n" ..
						   "Up to date graphics drivers DirectX 12\n\n" ..
						   "Fair: Ray Traced Shadows from directional light sources at reduced resolution.\n\n" ..
						   "Good: Ray Traced Shadows from directional and local light sources at reduced resolution.\n\n" ..
						   "High: Ray Traced Shadows from directional and local light sources at full resolution.",
					order = 15,
					values = {
						[3] = "High",
						[2] = "Good",
						[1] = "Fair",
						[0] = "Disabled"
					},
					get = function(info) return RGS.db.profile.solo.shadowRT end,
					set = function(info, value)
						RGS.db.profile.solo.shadowRT = value						
					end,
				},
				sunShafts = {
					type = "select",
					name = "Sun Shafts",
					--desc = "",
					order = 16,
					values = {
						[2] = "High",
						[1] = "Low",
						[0] = "Disabled"
					},
					get = function(info) return RGS.db.profile.solo.sunShafts end,
					set = function(info, value)
						RGS.db.profile.solo.sunShafts = value						
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
						[0] = "Low"
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
				textureFilteringMode = {
					type = "select",
					name = "Texture Filtering Mode",
					desc = "Increases texture sharpness, particularly for textures viewed at an angle.",
					order = 11,
					values = {
						[5] = "16x Anisotropic",
						[4] = "8x Anisotropic",
						[3] = "4x Anisotropic",
						[2] = "2x Anisotropic",
						[1] = "Trilinear",
						[0] = "Bilinear"
					},
					get = function(info) return RGS.db.profile.scenario.textureFilteringMode end,
					set = function(info, value)
						RGS.db.profile.scenario.textureFilteringMode = value
					end,
				},
				viewDistance = {
					type = "range",
					name = "View Distance",
					desc = "View distance controls how far you can see. Larger view distances require more memory and a faster processor.",
					order = 12,
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
					order = 13,
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
					order = 14,
					min = 1,
					max = 10,
					step = 1,
					get = function(info) return RGS.db.profile.scenario.groundClutter end,
					set = function(info, value)
						RGS.db.profile.scenario.groundClutter = value
					end,
				},
				shadowRT = {
					type = "select",
					name = "Raytraced Shadows",
					desc = "Improves shadow quality with ray tracing, which produces shadows with more nature softness, greatly increased precision and from additional light sources.\n\n" ..
						   "This feature requires:\n" ..
						   "A hardware ray tracing capable graphics card\n" ..
						   "Windows 10 May 2020 Update (version 2004)\n" ..
						   "Up to date graphics drivers DirectX 12\n\n" ..
						   "Fair: Ray Traced Shadows from directional light sources at reduced resolution.\n\n" ..
						   "Good: Ray Traced Shadows from directional and local light sources at reduced resolution.\n\n" ..
						   "High: Ray Traced Shadows from directional and local light sources at full resolution.",
					order = 15,
					values = {
						[3] = "High",
						[2] = "Good",
						[1] = "Fair",
						[0] = "Disabled"
					},
					get = function(info) return RGS.db.profile.scenario.shadowRT end,
					set = function(info, value)
						RGS.db.profile.scenario.shadowRT = value
					end,
				},
				sunShafts = {
					type = "select",
					name = "Sun Shafts",
					--desc = "",
					order = 16,
					values = {
						[2] = "High",
						[1] = "Low",
						[0] = "Disabled"
					},
					get = function(info) return RGS.db.profile.scenario.sunShafts end,
					set = function(info, value)
						RGS.db.profile.scenario.sunShafts = value
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
						[0] = "Low"
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
				textureFilteringMode = {
					type = "select",
					name = "Texture Filtering Mode",
					desc = "Increases texture sharpness, particularly for textures viewed at an angle.",
					order = 11,
					values = {
						[5] = "16x Anisotropic",
						[4] = "8x Anisotropic",
						[3] = "4x Anisotropic",
						[2] = "2x Anisotropic",
						[1] = "Trilinear",
						[0] = "Bilinear"
					},
					get = function(info) return RGS.db.profile.group.textureFilteringMode end,
					set = function(info, value)
						RGS.db.profile.group.textureFilteringMode = value
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
					order = 12,
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
					order = 13,
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
					order = 14,
					min = 1,
					max = 10,
					step = 1,
					get = function(info) return RGS.db.profile.group.groundClutter end,
					set = function(info, value)
						RGS.db.profile.group.groundClutter = value						
					end,
				},
				shadowRT = {
					type = "select",
					name = "Raytraced Shadows",
					desc = "Improves shadow quality with ray tracing, which produces shadows with more nature softness, greatly increased precision and from additional light sources.\n\n" ..
						   "This feature requires:\n" ..
						   "A hardware ray tracing capable graphics card\n" ..
						   "Windows 10 May 2020 Update (version 2004)\n" ..
						   "Up to date graphics drivers DirectX 12\n\n" ..
						   "Fair: Ray Traced Shadows from directional light sources at reduced resolution.\n\n" ..
						   "Good: Ray Traced Shadows from directional and local light sources at reduced resolution.\n\n" ..
						   "High: Ray Traced Shadows from directional and local light sources at full resolution.",
					order = 15,
					values = {
						[3] = "High",
						[2] = "Good",
						[1] = "Fair",
						[0] = "Disabled"
					},
					get = function(info) return RGS.db.profile.group.shadowRT end,
					set = function(info, value)
						RGS.db.profile.group.shadowRT = value						
					end,
				},
				sunShafts = {
					type = "select",
					name = "Sun Shafts",
					--desc = "",
					order = 16,
					values = {
						[2] = "High",
						[1] = "Low",
						[0] = "Disabled"
					},
					get = function(info) return RGS.db.profile.group.sunShafts end,
					set = function(info, value)
						RGS.db.profile.group.sunShafts = value						
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
						[0] = "Low"
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
				textureFilteringMode = {
					type = "select",
					name = "Texture Filtering Mode",
					desc = "Increases texture sharpness, particularly for textures viewed at an angle.",
					order = 11,
					values = {
						[5] = "16x Anisotropic",
						[4] = "8x Anisotropic",
						[3] = "4x Anisotropic",
						[2] = "2x Anisotropic",
						[1] = "Trilinear",
						[0] = "Bilinear"
					},
					get = function(info) return RGS.db.profile.raid.textureFilteringMode end,
					set = function(info, value)
						RGS.db.profile.raid.textureFilteringMode = value						
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
					order = 12,
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
					order = 13,
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
					order = 14,
					min = 1,
					max = 10,
					step = 1,
					get = function(info) return RGS.db.profile.raid.groundClutter end,
					set = function(info, value)
						RGS.db.profile.raid.groundClutter = value						
					end,
				},
				shadowRT = {
					type = "select",
					name = "Raytraced Shadows",
					desc = "Improves shadow quality with ray tracing, which produces shadows with more nature softness, greatly increased precision and from additional light sources.\n\n" ..
						   "This feature requires:\n" ..
						   "A hardware ray tracing capable graphics card\n" ..
						   "Windows 10 May 2020 Update (version 2004)\n" ..
						   "Up to date graphics drivers DirectX 12\n\n" ..
						   "Fair: Ray Traced Shadows from directional light sources at reduced resolution.\n\n" ..
						   "Good: Ray Traced Shadows from directional and local light sources at reduced resolution.\n\n" ..
						   "High: Ray Traced Shadows from directional and local light sources at full resolution.",
					order = 15,
					values = {
						[3] = "High",
						[2] = "Good",
						[1] = "Fair",
						[0] = "Disabled"
					},
					get = function(info) return RGS.db.profile.raid.shadowRT end,
					set = function(info, value)
						RGS.db.profile.raid.shadowRT = value
					end,
				},
				sunShafts = {
					type = "select",
					name = "Sun Shafts",
					--desc = "",
					order = 16,
					values = {
						[2] = "High",
						[1] = "Low",
						[0] = "Disabled"
					},
					get = function(info) return RGS.db.profile.raid.sunShafts end,
					set = function(info, value)
						RGS.db.profile.raid.sunShafts = value						
					end,
				},
			},
		},
	},
}


-- Keep the controls aligned with Blizzard's current CVar values. The game stores
-- View Distance, Environment Detail and Ground Clutter as 0-9 but displays 1-10.
local labels = {
    outlineMode = { name = "Outline Mode", values = { [0] = "Disabled", [1] = "Good", [2] = "High" } },
    resampleQuality = { name = "Resample Quality", values = { [0] = "Point", [1] = "Bilinear", [2] = "Bicubic", [3] = "FidelityFX Super Resolution 1.0" } },
    vrsMode = { name = "VRS Mode", values = { [0] = "Disabled", [1] = "Standard", [2] = "Aggressive" } },
}

local additionalRanges = {
    resampleSharpness = { name = "Resample Sharpness", min = 0, max = 2, step = 0.1 },
    contrast = { name = "Contrast", min = 0, max = 100, step = 1 },
    brightness = { name = "Brightness", min = 0, max = 100, step = 1 },
    gamma = { name = "Gamma", min = 0.3, max = 2.8, step = 0.1 },
    maxFPS = { name = "Max Foreground FPS", min = 8, max = 200, step = 1 },
    maxFPSBk = { name = "Max Background FPS", min = 8, max = 200, step = 1 },
    targetFPS = { name = "Target FPS", min = 8, max = 200, step = 1 },
}

local additionalToggles = {
    useMaxFPS = "Limit Foreground FPS",
    useMaxFPSBk = "Limit Background FPS",
    useTargetFPS = "Use Target FPS",
}

for _, profileType in ipairs({ "solo", "scenario", "group", "raid" }) do
    local profileName = profileType
    local args = RGS.options.args[profileType].args
    args.updateSettingsButton.desc = profileType == "raid"
        and "Capture Blizzard's Raid and Battleground graphics settings when that bank is enabled; otherwise capture Base. Shared Advanced settings are also captured."
        or "Capture Blizzard's Base graphics settings and shared Advanced settings into this profile."
    args.applySettingsButton = {
        type = "execute", name = "Apply Settings Now", order = 1.5,
        desc = "Apply this profile to its Blizzard graphics settings bank now.",
        func = function() RGS:ApplyProfileSettings(profileName) end,
    }
    args.graphicsQuality = {
        type = "range", name = "Graphics Quality Preset", order = 1.7,
        desc = "Blizzard's overall quality preset. Individual quality controls below are applied after this preset.",
        min = 1, max = 10, step = 1,
        hidden = function() return RGS:GetCVarNumber("graphicsQuality") == nil end,
        get = function()
            local setting = RGS.settings[1]
            local value = RGS.db.profile[profileName].graphicsQuality
            if value == nil then value = RGS:GetCVarNumber(RGS:GetSettingCVar(setting, profileName)) or 0 end
            return value + 1
        end,
        set = function(_, value) RGS.db.profile[profileName].graphicsQuality = value - 1 end,
    }

    for _, key in ipairs({ "viewDistance", "environmentDetail", "groundClutter" }) do
        local sliderKey = key
        local option = args[key]
        option.min, option.max = 1, 10
        option.get = function()
            return (RGS.db.profile[profileName][sliderKey] or 0) + 1
        end
        option.set = function(_, value)
            RGS.db.profile[profileName][sliderKey] = value - 1
        end
    end

    -- Clients with the modern spell-visual system have three choices.
    if C_VideoOptions and C_VideoOptions.IsSpellVisualDensitySystemSupported
        and C_VideoOptions.IsSpellVisualDensitySystemSupported() then
        args.spellDensity.values = { [0] = "Essential", [1] = "Reduced", [2] = "Full" }
    end

    for index, setting in ipairs(RGS.settings) do
        local key = setting[1]
        local settingInfo, settingKey = setting, key
        local available = function() return not RGS:IsSettingAvailable(settingInfo) end
        if args[key] then
            args[key].hidden = available
        elseif labels[key] then
            args[key] = {
                type = "select", name = labels[key].name, order = 16 + index,
                values = labels[key].values, hidden = available,
                get = function()
                    return RGS.db.profile[profileName][settingKey] or RGS:GetCVarNumber(RGS:GetSettingCVar(settingInfo, profileName))
                end,
                set = function(_, value) RGS.db.profile[profileName][settingKey] = value end,
            }
        elseif additionalRanges[key] then
            local spec = additionalRanges[key]
            args[key] = {
                type = "range", name = spec.name, order = 16 + index,
                min = spec.min, max = spec.max, step = spec.step, hidden = available,
                get = function()
                    return RGS.db.profile[profileName][settingKey] or RGS:GetCVarNumber(RGS:GetSettingCVar(settingInfo, profileName)) or spec.min
                end,
                set = function(_, value) RGS.db.profile[profileName][settingKey] = value end,
            }
        elseif additionalToggles[key] then
            args[key] = {
                type = "toggle", name = additionalToggles[key], order = 16 + index,
                hidden = available,
                get = function()
                    local value = RGS.db.profile[profileName][settingKey]
                    if value == nil then value = RGS:GetCVarNumber(settingInfo[2]) end
                    return value == 1
                end,
                set = function(_, value) RGS.db.profile[profileName][settingKey] = value and 1 or 0 end,
            }
        end
    end
end
