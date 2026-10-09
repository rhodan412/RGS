12.1.0.0 (2026-10-09)

	*HIGHLIGHTS*
		- Fixed the broker icon opening RGS settings in Retail.
		- Graphics profiles now capture and apply the matching Base or Raid settings, with 1-10 sliders matching Blizzard's display.
		- Added more profile controls for graphics quality, outline, resampling, VRS, frame limits, and display tuning.
		- Added client manifests for Classic Season of Discovery, TBC Anniversary, and WoW Forever.

	Config.lua
		- Matched quality slider display to Blizzard's 1-10 scale, exposed supported graphics controls, and added explicit capture and apply actions for each context. (2026.10.09.0841)

	Core.lua
		- Rebuilt profile initialization and CVar capture/application around supported Base and Raid settings; removed overlapping delayed writes and corrected context selection. (2026.10.09.0841)

	Events.lua
		- Registered context and raid-bank events through AceEvent so the active profile updates on world, zone, group, scenario, and bank changes. (2026.10.09.0841)

	RGS.toc
		- Declared the 12.1.0 release and supported client interface versions. (2026.10.09.0841)

	RGS_Camelot.toc
		- Added the 1.60.1 WoW Forever client manifest with the shared RGS load order. (2026.10.09.0841)

	RGS_TBC.toc
		- Added the 2.5.6 TBC Anniversary client manifest with the shared RGS load order. (2026.10.09.0841)

	RGS_Vanilla.toc
		- Added the 1.15.9 Classic Season of Discovery client manifest with the shared RGS load order. (2026.10.09.0841)

	RGSMinimap.lua
		- Opened the registered settings category through the current Settings API with a Classic fallback and corrected click filtering. (2026.10.09.0841)


12.0.5.0 (2026-04-30)

	*HIGHLIGHTS*
		- Ace3 Library and TOC updates

	Ace3
		- Library Updates (2026.04.30)

	RGS.toc
		- Updated version# (2026.04.30)
		- Updated interface# (2026.04.30)


11.1.0.1 (2025-03-01)

	*HIGHLIGHTS*
		- Ace3 Library Updates
		- Added category information for addon (2025.03.01)

	Ace3
		- Library Updates

	RGS.toc
		- Updated version# (2025.03.01)
		- Updated interface# (2025.03.01)
		- Added category information for addon (2025.03.01)


11.0.7.1 - TOC Update

11.0.2.1 - TOC Update

1.1 - Corrected values in Config

1.09 - Bump version for 10.2.7 & added option for right clicking LDB to open Config page

1.08 - Bump version

1.07 - Updated Icon Image, added shadowRT, textureFilteringMode and sunShafts

1.06 - Added option to create profile for Scenario

1.05 - Updated settings for what constitutes a group

1.0 - Initial Release
