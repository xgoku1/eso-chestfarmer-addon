--Variables
ChestFarmer = {}
ChestFarmer.name = "ChestFarmer"
ChestFarmer.versionNum = 1
ChestFarmer.numChests = 0
ChestFarmer.numLockpicks = 0
ChestFarmer.delvePd = {124, 134, 137, 138, 142, 162, 169, 216, 270, 271, 272, 273, 274, 275, 284, 287, 288, 289, 290, 291, 296, 306, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 341, 359, 360, 361, 362, 363, 364, 396, 397, 398, 399, 400, 401, 405, 406, 407, 408, 409, 410, 413, 417, 418, 419, 420, 421, 422, 442, 444, 447, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 475, 477, 478, 480, 481, 482, 484, 485, 486, 487, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 531, 532, 557, 575, 576, 577, 578, 579, 580, 676, 689, 691, 692, 693, 694, 697, 705, 706, 817, 824, 825, 889, 890, 891, 892, 893, 894, 895, 896, 897, 898, 899, 900, 901, 902, 903, 904, 905, 906, 918, 919, 921, 922, 923, 924, 925, 961, 985, 986, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1066, 1073, 1089, 1090, 1091, 1092, 1094, 1095, 1096, 1119, 1134, 1135, 1165, 1166, 1167, 1168, 1169, 1170, 1186, 1187, 1209, 1210}

--Init functions

function ChestFarmer.onAddonLoaded(event, addonName)
	if addonName == ChestFarmer.name then
		ChestFarmer.Initialize()
		ChestFarmer.SetScene()
	end
end

function ChestFarmer.Initialize()
	ChestFarmer.savedVariables = ZO_SavedVars:NewAccountWide("ChestFarmerSavedData", 1, nil, ChestFarmer.Default)	
	ChestFarmer.RestorePosition()
end

function ChestFarmer.SetScene()
	--Scenes
	local fragment = ZO_HUDFadeSceneFragment:New(ChestFarmerWindow, nil, 0)
	HUD_SCENE:AddFragment(fragment)
	HUD_UI_SCENE:AddFragment(fragment)
end

--UI functions

function ChestFarmer.OnIndicatorMoveStop()
	ChestFarmer.savedVariables.left = ChestFarmerWindow:GetLeft()
	ChestFarmer.savedVariables.top = ChestFarmerWindow:GetTop()
end

function ChestFarmer.RestorePosition()
	local left = ChestFarmer.savedVariables.left
	local top = ChestFarmer.savedVariables.top
	ChestFarmerWindow:ClearAnchors()
	ChestFarmerWindow:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
end

function ChestFarmer.resetButtonPressed()
	ChestFarmer.numChests = 0
	ChestFarmer.sfWrite(ChestFarmer.numChests)
	ChestFarmer.numLockpicks = GetNumLockpicksLeft("player")
	ChestFarmerWindowLockpicksCount:SetText(ChestFarmer.numLockpicks .. " lockpicks remaining")
	ChestFarmerWindowChestsCount:SetText(ChestFarmer.numChests .. " chests opened") 
end

--function to open set collections scene
function ChestFarmer.openCollections()
	SCENE_MANAGER:Toggle("itemSetsBook")
end

function ChestFarmer.chestsReset_showTooltip(self)
	InitializeTooltip(InformationTooltip, self, TOPRIGHT, 0, 5, BOTTOMRIGHT)
	SetTooltipText(InformationTooltip, "Reset Count")
end

function ChestFarmer.chestsReset_hideTooltip(self)
	ClearTooltip(InformationTooltip)
end

function ChestFarmer.setsCount_showTooltip(self)
	InitializeTooltip(InformationTooltip, self, TOPRIGHT, 0, 5, BOTTOMRIGHT)
	SetTooltipText(InformationTooltip, "Open Set Collections")
end

function ChestFarmer.setsCount_hideTooltip(self)
	ClearTooltip(InformationTooltip)
end

--Data functions

function ChestFarmer.findSets()
	local tempParentZoneId = GetParentZoneId(GetZoneId(GetUnitZoneIndex("player")))
	--Starter Zones
	--Bal Foyen
	if tempParentZoneId == 281 then
		return {281}
	--Bleakrock Isle
	elseif tempParentZoneId == 280 then
		return {281}
	--Betnikh
	elseif tempParentZoneId == 535 then
		return {281}
	--Stros M'Kai
	elseif tempParentZoneId == 534 then
		return {281}
	--Khenarthi's Roost
	elseif tempParentZoneId == 537 then
		return {281}
	--Ebonheart Pact
	--Deshaan
	elseif tempParentZoneId == 57 then
		return {292, 34, 293}
	--Eastmarch
	elseif tempParentZoneId == 101 then
		return {21, 27, 56} 
	--Shadowfen
	elseif tempParentZoneId == 117 then
		return {62, 66, 187}
	--Stonefalls
	elseif tempParentZoneId == 41 then
		return {49, 291, 31}
	--The Rift
	elseif tempParentZoneId == 103 then
		return {135, 20, 294}
	--Daggerfall Covenant
	--Alik'r Desert
	elseif tempParentZoneId == 104 then
		return {284, 47, 283}
	--Bangkorai
	elseif tempParentZoneId == 92 then
		return {285, 286, 70}
	--Glenumbra
	elseif tempParentZoneId == 3 then
		return {58, 107, 65}
	--Rivenspire
	elseif tempParentZoneId == 20 then
		return {60, 98, 282}
	--Stormhaven
	elseif tempParentZoneId == 19 then
		return {22, 112, 93}
	--Aldmeri Dominion
	--Auridon
	elseif tempParentZoneId == 381 then
		return {36, 86, 105}
	--Grahtwood
	elseif tempParentZoneId == 383 then
		return {287, 69, 57}
	--Greenshade
	elseif tempParentZoneId == 108 then
		return {64, 106, 288}
	--Malabal Tor
	elseif tempParentZoneId == 58 then
		return {289, 30, 99}
	--Reaper's March
	elseif tempParentZoneId == 382 then
		return {290, 114, 90}
	--Neutral zones
	--Summerset
	elseif tempParentZoneId == 1011 then
		return {382, 383, 384}
	--Western Skyrim
	elseif tempParentZoneId == 1160 then
		return {487, 488, 489}
	--Blackreach: Greymoor Caverns
	elseif tempParentZoneId == 1161 then
		return {487, 488, 489}
	--Clockwork City
	elseif tempParentZoneId == 980 then
		return {354, 355, 356}
	--Coldharbour
	elseif tempParentZoneId == 347 then
		return {94, 26, 68}
	--Craglorn
	elseif tempParentZoneId == 888 then
		return {145, 146, 147}
	--Gold Coast
	elseif tempParentZoneId == 823 then
		return {243, 244, 245}
	--Hew's Bane
	elseif tempParentZoneId == 816 then
		return {227, 228}
	--Murkmire
	elseif tempParentZoneId == 726 then
		return {405, 406, 407}
	--Northern Elsweyr
	elseif tempParentZoneId == 1086 then
		return {440, 441, 442}
	--Southern Elsweyr
	elseif tempParentZoneId == 1133 then
		return {465, 466, 467}
	--The Reach
	elseif tempParentZoneId == 1207 then
		return {536, 537, 538}
	--Blackreach: Arkthzand Cavern
	elseif tempParentZoneId == 1208 then
		return {536, 537, 538}
	--Vvardenfell	
	elseif tempParentZoneId == 849 then
		return {320, 321, 322}
	--Wrothgar
	elseif tempParentZoneId == 684 then
		return {210, 212, 218}
	--Cyrodiil	
	elseif tempParentZoneId == 181 then
		return {101, 39, 85, 131, 422, 419, 52, 128, 133, 113, 480, 104, 482, 127, 25, 130, 83, 238, 126, 100, 417, 59, 237, 109, 234, 108, 76, 235, 89, 67, 132, 420, 418, 421, 97, 63, 50, 481, 129, 236, 111, 239, 125}
	--Imperial City
	elseif tempParentZoneId == 584 then
		return {179, 184, 246, 253, 181, 200, 180, 201, 199, 248, 247, 204, 205, 206}
	--Exceptions
	--The Harborage
	elseif tempParentZoneId == 199 then
		return {}
	--The Earth Forge
	elseif tempParentZoneId == 208 then
		return {}
	--Eyevea
	elseif tempParentZoneId == 267 then
		return {}
	--Pregame
	elseif tempParentZoneId == 279 then
		return {}
	--Battlegrounds
	--Arcane University
	elseif tempParentZoneId == 511 then
		return {}
	--Deeping Drome
	elseif tempParentZoneId == 512 then
		return {}
	--Mor Khazgur
	elseif tempParentZoneId == 513 then
		return {}
	--Istirus Outpost
	elseif tempParentZoneId == 514 then
		return {}
	--Istirus Outpost Arena
	elseif tempParentZoneId == 515 then
		return {}
	--Ald Carac
	elseif tempParentZoneId == 516 then
		return {}
	--Eld Angavar 1
	elseif tempParentZoneId == 517 then
		return {}
	--Eld Angavar 2
	elseif tempParentZoneId == 518 then
		return {}
	--Stirk
	elseif tempParentZoneId == 572 then
		return {}
	--The Wailing Prison
	elseif tempParentZoneId == 586 then
		return {94, 26, 68}
	--The Earth Forge
	elseif tempParentZoneId == 642 then
		return {}
	--Houses
	--Linchal Grand Manor
	elseif tempParentZoneId == 1005 then
		return {243, 244, 245}
	--Lakemire Xanmeer Manor
	elseif tempParentZoneId == 1108 then
		return {405, 406, 407}
	--Enchanted Snow Globe Home
	elseif tempParentZoneId == 1109 then
		return {21, 27, 56} 
	--Thieves' Oasis
	elseif tempParentZoneId == 1200 then
		return {285, 286, 70}
	--Stone Eagle Aerie
	elseif tempParentZoneId == 1264 then
		return {536, 537, 538}
	--Moon Gate
	elseif tempParentZoneId == 1116 then
		return {440, 441, 442}
	--The Valley of Blades
	elseif tempParentZoneId == 1142 then
		return {}
	--Vahlokzin's Lair
	elseif tempParentZoneId == 1144 then
		return {465, 466, 467}
	--The Undergrove
	elseif tempParentZoneId == 1195 then
		return {487, 488, 489}
	end
end

function ChestFarmer.showCollected()
	local zoneSets = {}
	local collectedSets = 0
	local totalSets = 0
	local setsPercentage = ""
	zoneSets = ChestFarmer.findSets()
	for k,v in pairs(zoneSets) do
		collectedSets = collectedSets + GetNumItemSetCollectionSlotsUnlocked(v)
		totalSets = totalSets + GetNumItemSetCollectionPieces(v)
	end
	--debugging
	if collectedSets == 0 then
		d("GetNumItemSetCollectionSlotsUnlocked returning 0")
	end
	setsPercentage = string.format("%.2f",(collectedSets/totalSets)*100)
	ChestFarmerWindowSetsCount:SetText(collectedSets .. "/" .. totalSets .. " collected." .. " (" .. setsPercentage .. "%)")
end

function ChestFarmer.sfReadZone()
	local tempParentZoneId = GetParentZoneId(GetZoneId(GetUnitZoneIndex("player")))
	--Starter Zones
	--Bal Foyen
	if tempParentZoneId == 281 then
		return 281, ChestFarmer.savedVariables.starterTC
	--Bleakrock Isle
	elseif tempParentZoneId == 280 then
		return 280, ChestFarmer.savedVariables.starterTC
	--Betnikh
	elseif tempParentZoneId == 535 then
		return 535, ChestFarmer.savedVariables.starterTC
	--Stros M'Kai
	elseif tempParentZoneId == 534 then
		return 534, ChestFarmer.savedVariables.starterTC
	--Khenarthi's Roost
	elseif tempParentZoneId == 537 then
		return 537, ChestFarmer.savedVariables.starterTC
	--Ebonheart Pact
	--Deshaan
	elseif tempParentZoneId == 57 then
		return 57, ChestFarmer.savedVariables.deshaanTC 
	--Eastmarch
	elseif tempParentZoneId == 101 then
		return 101, ChestFarmer.savedVariables.eastmarchTC 
	--Shadowfen
	elseif tempParentZoneId == 117 then
		return 117, ChestFarmer.savedVariables.shadowfenTC
	--Stonefalls
	elseif tempParentZoneId == 41 then
		return 41, ChestFarmer.savedVariables.stonefallsTC 
	--The Rift
	elseif tempParentZoneId == 103 then
		return 103, ChestFarmer.savedVariables.theriftTC
	--Daggerfall Covenant
	--Alik'r Desert
	elseif tempParentZoneId == 104 then
		return 104, ChestFarmer.savedVariables.alikrdesertTC
	--Bangkorai
	elseif tempParentZoneId == 92 then
		return 92, ChestFarmer.savedVariables.bangkoraiTC
	--Glenumbra
	elseif tempParentZoneId == 3 then
		return 3, ChestFarmer.savedVariables.glenumbraTC
	--Rivenspire
	elseif tempParentZoneId == 20 then
		return 20, ChestFarmer.savedVariables.rivenspireTC
	--Stormhaven
	elseif tempParentZoneId == 19 then
		return 19, ChestFarmer.savedVariables.stormhavenTC
	--Aldmeri Dominion
	--Auridon
	elseif tempParentZoneId == 381 then
		return 381, ChestFarmer.savedVariables.auridonTC
	--Grahtwood
	elseif tempParentZoneId == 383 then
		return 383, ChestFarmer.savedVariables.grahtwoodTC
	--Greenshade
	elseif tempParentZoneId == 108 then
		return 108, ChestFarmer.savedVariables.greenshadeTC
	--Malabal Tor
	elseif tempParentZoneId == 58 then
		return 58, ChestFarmer.savedVariables.malabaltorTC
	--Reaper's March
	elseif tempParentZoneId == 382 then
		return 382, ChestFarmer.savedVariables.reapersmarchTC
	--Neutral zones
	--Summerset
	elseif tempParentZoneId == 1011 then
		return 1011, ChestFarmer.savedVariables.summersetTC 
	--Western Skyrim
	elseif tempParentZoneId == 1160 then
		return 1160, ChestFarmer.savedVariables.wSkyrimTC
	--Blackreach: Greymoor Caverns
	elseif tempParentZoneId == 1161 then
		return 1161, ChestFarmer.savedVariables.wSkyrimTC
	--Clockwork City
	elseif tempParentZoneId == 980 then
		return 980, ChestFarmer.savedVariables.clockworkTC
	--Coldharbour
	elseif tempParentZoneId == 347 then
		return 347, ChestFarmer.savedVariables.coldharbourTC 
	--Craglorn
	elseif tempParentZoneId == 888 then
		return 888, ChestFarmer.savedVariables.craglornTC
	--Gold Coast
	elseif tempParentZoneId == 823 then
		return 823, ChestFarmer.savedVariables.goldcoastTC
	--Hew's Bane
	elseif tempParentZoneId == 816 then
		return 816, ChestFarmer.savedVariables.hewsbaneTC
	--Murkmire
	elseif tempParentZoneId == 726 then
		return 726, ChestFarmer.savedVariables.murkmireTC 
	--Northern Elsweyr
	elseif tempParentZoneId == 1086 then
		return 1086, ChestFarmer.savedVariables.nElsweyrTC
	--Southern Elsweyr
	elseif tempParentZoneId == 1133 then
		return 1133, ChestFarmer.savedVariables.sElsweyrTC
	--The Reach
	elseif tempParentZoneId == 1207 then
		return 1207, ChestFarmer.savedVariables.thereachTC
	--Blackreach: Arkthzand Cavern
	elseif tempParentZoneId == 1208 then
		return 1208, ChestFarmer.savedVariables.thereachTC
	--Vvardenfell	
	elseif tempParentZoneId == 849 then
		return 849, ChestFarmer.savedVariables.vvardenfellTC
	--Wrothgar
	elseif tempParentZoneId == 684 then
		return 684, ChestFarmer.savedVariables.wrothgarTC
	--Cyrodiil	
	elseif tempParentZoneId == 181 then
		return 181, ChestFarmer.savedVariables.cyrodiilTC
	--Imperial City
	elseif tempParentZoneId == 584 then
		return 584, ChestFarmer.savedVariables.impcityTC
	--Exceptions
	--The Harborage
	elseif tempParentZoneId == 199 then
		return 199, 0
	--The Earth Forge
	elseif tempParentZoneId == 208 then
		return 208, 0
	--Eyevea
	elseif tempParentZoneId == 267 then
		return 267, 0
	--Pregame
	elseif tempParentZoneId == 279 then
		return 279, 0
	--Battlegrounds
	--Arcane University
	elseif tempParentZoneId == 511 then
		return 511, 0
	--Deeping Drome
	elseif tempParentZoneId == 512 then
		return 512, 0
	--Mor Khazgur
	elseif tempParentZoneId == 513 then
		return 513, 0
	--Istirus Outpost
	elseif tempParentZoneId == 514 then
		return 514, 0
	--Istirus Outpost Arena
	elseif tempParentZoneId == 515 then
		return 515, 0
	--Ald Carac
	elseif tempParentZoneId == 516 then
		return 516, 0
	--Eld Angavar 1
	elseif tempParentZoneId == 517 then
		return 517, 0
	--Eld Angavar 2
	elseif tempParentZoneId == 518 then
		return 518, 0
	--Stirk
	elseif tempParentZoneId == 572 then
		return 572, 0
	--The Wailing Prison
	elseif tempParentZoneId == 586 then
		return 347, ChestFarmer.savedVariables.coldharbourTC
	--The Earth Forge
	elseif tempParentZoneId == 642 then
		return 642, 0
	--Houses
	--Linchal Grand Manor
	elseif tempParentZoneId == 1005 then
		return 823, ChestFarmer.savedVariables.goldcoastTC 
	--Lakemire Xanmeer Manor
	elseif tempParentZoneId == 1108 then
		return 726, ChestFarmer.savedVariables.murkmireTC 
	--Enchanted Snow Globe Home
	elseif tempParentZoneId == 1109 then
		return 101, ChestFarmer.savedVariables.eastmarchTC 
	--Thieves' Oasis
	elseif tempParentZoneId == 1200 then
		return 92, ChestFarmer.savedVariables.bangkoraiTC
	--Stone Eagle Aerie
	elseif tempParentZoneId == 1264 then
		return 1207, ChestFarmer.savedVariables.thereachTC
	--Moon Gate
	elseif tempParentZoneId == 1116 then
		return 1086, ChestFarmer.savedVariables.nElsweyrTC
	--The Valley of Blades
	elseif tempParentZoneId == 1142 then
		return 1142, 0
	--Vahlokzin's Lair
	elseif tempParentZoneId == 1144 then
		return 1133, ChestFarmer.savedVariables.sElsweyrTC
	--The Undergrove
	elseif tempParentZoneId == 1195 then
		return 1161, ChestFarmer.savedVariables.wSkyrimTC
	end
end

function ChestFarmer.sfRead()
	local actualZoneId = 0
	actualZoneId, ChestFarmer.numChests = ChestFarmer.sfReadZone()
	--edgecase for addon initialization
	if ChestFarmer.numChests == nil then
		ChestFarmer.numChests = 0
	end
	local actualZone = GetZoneNameById(actualZoneId)
	ChestFarmerWindowZoneDisplay:SetText("This Zone: " .. actualZone)
	ChestFarmer.numLockpicks = GetNumLockpicksLeft("player")
	ChestFarmerWindowLockpicksCount:SetText(ChestFarmer.numLockpicks .. " lockpicks remaining") 
	ChestFarmerWindowChestsCount:SetText(ChestFarmer.numChests .. " chests opened")
	ChestFarmer.showCollected()
end

function ChestFarmer.sfWrite(tempTc)
	local tempParentZoneId = GetParentZoneId(GetZoneId(GetUnitZoneIndex("player")))
	--Starter Zones
	--Bal Foyen
	if tempParentZoneId == 281 then
		ChestFarmer.savedVariables.starterTC = tempTc
	--Bleakrock Isle
	elseif tempParentZoneId == 280 then
		ChestFarmer.savedVariables.starterTC = tempTc
	--Betnikh
	elseif tempParentZoneId == 535 then
		ChestFarmer.savedVariables.starterTC = tempTc
	--Stros M'Kai
	elseif tempParentZoneId == 534 then
		ChestFarmer.savedVariables.starterTC = tempTc
	--Khenarthi's Roost
	elseif tempParentZoneId == 537 then
		ChestFarmer.savedVariables.starterTC = tempTc
	--Ebonheart Pact
	--Deshaan
	elseif tempParentZoneId == 57 then
		ChestFarmer.savedVariables.deshaanTC = tempTc 
	--Eastmarch
	elseif tempParentZoneId == 101 then
		ChestFarmer.savedVariables.eastmarchTC = tempTc 
	--Shadowfen
	elseif tempParentZoneId == 117 then
		ChestFarmer.savedVariables.shadowfenTC = tempTc
	--Stonefalls
	elseif tempParentZoneId == 41 then
		ChestFarmer.savedVariables.stonefallsTC = tempTc 
	--The Rift
	elseif tempParentZoneId == 103 then
		ChestFarmer.savedVariables.theriftTC = tempTc
	--Daggerfall Covenant
	--Alik'r Desert
	elseif tempParentZoneId == 104 then
		ChestFarmer.savedVariables.alikrdesertTC = tempTc
	--Bangkorai
	elseif tempParentZoneId == 92 then
		ChestFarmer.savedVariables.bangkoraiTC = tempTc
	--Glenumbra
	elseif tempParentZoneId == 3 then
		ChestFarmer.savedVariables.glenumbraTC = tempTc
	--Rivenspire
	elseif tempParentZoneId == 20 then
		ChestFarmer.savedVariables.rivenspireTC = tempTc
	--Stormhaven
	elseif tempParentZoneId == 19 then
		ChestFarmer.savedVariables.stormhavenTC = tempTc
	--Aldmeri Dominion
	--Auridon
	elseif tempParentZoneId == 381 then
		ChestFarmer.savedVariables.auridonTC = tempTc
	--Grahtwood
	elseif tempParentZoneId == 383 then
		ChestFarmer.savedVariables.grahtwoodTC = tempTc
	--Greenshade
	elseif tempParentZoneId == 108 then
		ChestFarmer.savedVariables.greenshadeTC = tempTc
	--Malabal Tor
	elseif tempParentZoneId == 58 then
		ChestFarmer.savedVariables.malabaltorTC = tempTc
	--Reaper's March
	elseif tempParentZoneId == 382 then
		ChestFarmer.savedVariables.reapersmarchTC = tempTc
	--Neutral zones
	--Summerset
	elseif tempParentZoneId == 1011 then
		ChestFarmer.savedVariables.summersetTC = tempTc 
	--Western Skyrim
	elseif tempParentZoneId == 1160 then
		ChestFarmer.savedVariables.wSkyrimTC = tempTc
	--Blackreach: Greymoor Caverns
	elseif tempParentZoneId == 1161 then
		ChestFarmer.savedVariables.wSkyrimTC = tempTc
	--Clockwork City
	elseif tempParentZoneId == 980 then
		ChestFarmer.savedVariables.clockworkTC = tempTc
	--Coldharbour
	elseif tempParentZoneId == 347 then
		ChestFarmer.savedVariables.coldharbourTC = tempTc 
	--Craglorn
	elseif tempParentZoneId == 888 then
		ChestFarmer.savedVariables.craglornTC = tempTc
	--Gold Coast
	elseif tempParentZoneId == 823 then
		ChestFarmer.savedVariables.goldcoastTC = tempTc
	--Hew's Bane
	elseif tempParentZoneId == 816 then
		ChestFarmer.savedVariables.hewsbaneTC = tempTc
	--Murkmire
	elseif tempParentZoneId == 726 then
		ChestFarmer.savedVariables.murkmireTC = tempTc 
	--Northern Elsweyr
	elseif tempParentZoneId == 1086 then
		ChestFarmer.savedVariables.nElsweyrTC = tempTc
	--Southern Elsweyr
	elseif tempParentZoneId == 1133 then
		ChestFarmer.savedVariables.sElsweyrTC = tempTc
	--The Reach
	elseif tempParentZoneId == 1207 then
		ChestFarmer.savedVariables.thereachTC = tempTc
	--Blackreach: Arkthzand Cavern
	elseif tempParentZoneId == 1208 then
		ChestFarmer.savedVariables.thereachTC = tempTc
	--Vvardenfell	
	elseif tempParentZoneId == 849 then
		ChestFarmer.savedVariables.vvardenfellTC = tempTc
	--Wrothgar
	elseif tempParentZoneId == 684 then
		ChestFarmer.savedVariables.wrothgarTC = tempTc
	--Cyrodiil	
	elseif tempParentZoneId == 181 then
		ChestFarmer.savedVariables.cyrodiilTC = tempTc
	--Imperial City
	elseif tempParentZoneId == 584 then
		ChestFarmer.savedVariables.impcityTC = tempTc
	--Exceptions
	--The Wailing Prison
	elseif tempParentZoneId == 586 then
		ChestFarmer.savedVariables.coldharbourTC = tempTc
	--Moon Gate
	elseif tempParentZoneId == 1116 then
		ChestFarmer.savedVariables.nElsweyrTC = tempTc
	--Vahlokzin's Lair
	elseif tempParentZoneId == 1144 then
		ChestFarmer.savedVariables.sElsweyrTC = tempTc
	--The Undergrove
	elseif tempParentZoneId == 1195 then
		ChestFarmer.savedVariables.wSkyrimTC = tempTc
	end
end

function ChestFarmer.countIncrement()
	if IsUnitInDungeon("player") == true then
		local tempSubZoneId = GetZoneId(GetUnitZoneIndex("player"))
		for k,v in pairs(ChestFarmer.delvePd) do
			if tempSubZoneId == v then
				ChestFarmer.numChests = ChestFarmer.numChests + 1
			end
		end
	else
		ChestFarmer.numChests = ChestFarmer.numChests + 1
	end
	ChestFarmer.sfWrite(ChestFarmer.numChests)
	ChestFarmer.numLockpicks = GetNumLockpicksLeft("player")
	ChestFarmerWindowLockpicksCount:SetText(ChestFarmer.numLockpicks .. " lockpicks remaining")
	ChestFarmerWindowChestsCount:SetText(ChestFarmer.numChests .. " chests opened")
end

--Events

EVENT_MANAGER:RegisterForEvent(ChestFarmer.name, EVENT_ADD_ON_LOADED, ChestFarmer.onAddonLoaded)
EVENT_MANAGER:RegisterForEvent(ChestFarmer.name, EVENT_PLAYER_ACTIVATED, ChestFarmer.sfRead)
EVENT_MANAGER:RegisterForEvent(ChestFarmer.name, EVENT_LOCKPICK_SUCCESS, ChestFarmer.countIncrement)
EVENT_MANAGER:RegisterForEvent(ChestFarmer.name, EVENT_ITEM_SET_COLLECTION_UPDATED,	ChestFarmer.showCollected)