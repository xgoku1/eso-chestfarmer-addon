--Variables
ChestFarmer = {}
ChestFarmer.name = "ChestFarmer"
ChestFarmer.versionNum = 1
ChestFarmer.numChests = 0
ChestFarmer.numLockpicks = 0
ChestFarmer.delvePd = {[124] = true, [134] = true, [137] = true, [138] = true, [142] = true, [162] = true, [169] = true, [216] = true, [270] = true, [271] = true, [272] = true, [273] = true, [274] = true, [275] = true, [284] = true, [287] = true, [288] = true, [289] = true, [290] = true, [291] = true, [296] = true, [306] = true, [308] = true, [309] = true, [310] = true, [311] = true, [312] = true, [313] = true, [314] = true, [315] = true, [316] = true, [317] = true, [318] = true, [319] = true, [320] = true, [321] = true, [322] = true, [323] = true, [324] = true, [325] = true, [326] = true, [327] = true, [328] = true, [329] = true, [330] = true, [331] = true, [332] = true, [333] = true, [334] = true, [335] = true, [336] = true, [337] = true, [338] = true, [339] = true, [341] = true, [359] = true, [360] = true, [361] = true, [362] = true, [363] = true, [364] = true, [396] = true, [397] = true, [398] = true, [399] = true, [400] = true, [401] = true, [405] = true, [406] = true, [407] = true, [408] = true, [409] = true, [410] = true, [413] = true, [417] = true, [418] = true, [419] = true, [420] = true, [421] = true, [422] = true, [442] = true, [444] = true, [447] = true, [462] = true, [463] = true, [464] = true, [465] = true, [466] = true, [467] = true, [468] = true, [469] = true, [470] = true, [471] = true, [472] = true, [473] = true, [475] = true, [477] = true, [478] = true, [480] = true, [481] = true, [482] = true, [484] = true, [485] = true, [486] = true, [487] = true, [493] = true, [494] = true, [495] = true, [496] = true, [497] = true, [498] = true, [499] = true, [500] = true, [501] = true, [502] = true, [503] = true, [504] = true, [505] = true, [506] = true, [507] = true, [531] = true, [532] = true, [557] = true, [575] = true, [576] = true, [577] = true, [578] = true, [579] = true, [580] = true, [676] = true, [689] = true, [691] = true, [692] = true, [693] = true, [694] = true, [697] = true, [705] = true, [706] = true, [817] = true, [824] = true, [825] = true, [889] = true, [890] = true, [891] = true, [892] = true, [893] = true, [894] = true, [895] = true, [896] = true, [897] = true, [898] = true, [899] = true, [900] = true, [901] = true, [902] = true, [903] = true, [904] = true, [905] = true, [906] = true, [918] = true, [919] = true, [921] = true, [922] = true, [923] = true, [924] = true, [925] = true, [961] = true, [985] = true, [986] = true, [1014] = true, [1015] = true, [1016] = true, [1017] = true, [1018] = true, [1019] = true, [1020] = true, [1021] = true, [1066] = true, [1073] = true, [1089] = true, [1090] = true, [1091] = true, [1092] = true, [1094] = true, [1095] = true, [1096] = true, [1119] = true, [1134] = true, [1135] = true, [1165] = true, [1166] = true, [1167] = true, [1168] = true, [1169] = true, [1170] = true, [1186] = true, [1187] = true, [1209] = true, [1210] = true}

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
	fragment = ZO_HUDFadeSceneFragment:New(ChestFarmerWindow, nil, 0)
	--first run edgecase
	if ChestFarmer.savedVariables.guiHidden == nil then
		ChestFarmer.savedVariables.guiHidden = false
	end
	
	if ChestFarmer.savedVariables.guiHidden == false then
		HUD_SCENE:AddFragment(fragment)
		HUD_UI_SCENE:AddFragment(fragment)
	end
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
	ChestFarmer.cfWrite(ChestFarmer.numChests)
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

function ChestFarmer.slashHandler(param)
	--/chestfarmer
	if param == "" then
		ChestFarmer.savedVariables.guiHidden = not ChestFarmer.savedVariables.guiHidden
		if ChestFarmer.savedVariables.guiHidden == false then
			ChestFarmerWindow:SetHidden(ChestFarmer.savedVariables.guiHidden)
			HUD_SCENE:AddFragment(fragment)
			HUD_UI_SCENE:AddFragment(fragment)
		else
			ChestFarmerWindow:SetHidden(ChestFarmer.savedVariables.guiHidden)
			HUD_SCENE:RemoveFragment(fragment)
			HUD_UI_SCENE:RemoveFragment(fragment)
		end
	--/chestfarmer total
	elseif param == "total" then
		totalTC = 0
		for k,v in pairs{ChestFarmer.savedVariables.starterTC, ChestFarmer.savedVariables.deshaanTC, ChestFarmer.savedVariables.eastmarchTC, ChestFarmer.savedVariables.shadowfenTC, ChestFarmer.savedVariables.stonefallsTC, ChestFarmer.savedVariables.theriftTC, ChestFarmer.savedVariables.alikrdesertTC, ChestFarmer.savedVariables.bangkoraiTC, ChestFarmer.savedVariables.glenumbraTC, ChestFarmer.savedVariables.rivenspireTC, ChestFarmer.savedVariables.stormhavenTC, ChestFarmer.savedVariables.auridonTC, ChestFarmer.savedVariables.grahtwoodTC, ChestFarmer.savedVariables.greenshadeTC, ChestFarmer.savedVariables.malabaltorTC, ChestFarmer.savedVariables.reapersmarchTC, ChestFarmer.savedVariables.summersetTC, ChestFarmer.savedVariables.wSkyrimTC, ChestFarmer.savedVariables.clockworkTC, ChestFarmer.savedVariables.coldharbourTC, ChestFarmer.savedVariables.craglornTC, ChestFarmer.savedVariables.goldcoastTC, ChestFarmer.savedVariables.hewsbaneTC, ChestFarmer.savedVariables.murkmireTC, ChestFarmer.savedVariables.nElsweyrTC, ChestFarmer.savedVariables.sElsweyrTC, ChestFarmer.savedVariables.thereachTC, ChestFarmer.savedVariables.vvardenfellTC, ChestFarmer.savedVariables.wrothgarTC, ChestFarmer.savedVariables.cyrodiilTC, ChestFarmer.savedVariables.impcityTC} do
			if v ~= nil then
				totalTC = totalTC + v
			end
		end
		CHAT_ROUTER:AddSystemMessage("Total chests opened, in all zones: " .. totalTC)
	end
end

--Data functions

function ChestFarmer.fixCollected()
	if collectedSets == 0 then
		for k,v in pairs(zoneSets) do
			collectedSets = collectedSets + GetNumItemSetCollectionSlotsUnlocked(v)
		end
		if totalSets ~= 0 then
			setsPercentage = string.format("%.2f",(collectedSets/totalSets)*100)
		else
			setsPercentage = 0
		end
		ChestFarmerWindowSetsCount:SetText(collectedSets .. "/" .. totalSets .. " collected" .. " (" .. setsPercentage .. "%)")
	end
end

function ChestFarmer.cfRead()
	ChestFarmer.cfReadZone = {
	--Starter Zones
	--Bal Foyen 
		[281] = {281, ChestFarmer.savedVariables.starterTC, {281}},
	--Bleakrock Isle 
		[280] = {280, ChestFarmer.savedVariables.starterTC, {281}},
	--Betnikh 
		[535] = {535, ChestFarmer.savedVariables.starterTC, {281}},
	--Stros M'Kai 
		[534] = {534, ChestFarmer.savedVariables.starterTC, {281}},
	--Khenarthi's Roost 
		[537] = {537, ChestFarmer.savedVariables.starterTC, {281}},
	--Ebonheart Pact
	--Deshaan 
		[57] = {57, ChestFarmer.savedVariables.deshaanTC, {292, 34, 293}}, 
	--Eastmarch 
		[101] = {101, ChestFarmer.savedVariables.eastmarchTC, {21, 27, 56}},  
	--Shadowfen 
		[117] = {117, ChestFarmer.savedVariables.shadowfenTC, {62, 66, 187}},
	--Stonefalls 
		[41] = {41, ChestFarmer.savedVariables.stonefallsTC, {49, 291, 31}}, 
	--The Rift 
		[103] = {103, ChestFarmer.savedVariables.theriftTC, {135, 20, 294}},
	--Daggerfall Covenant
	--Alik'r Desert 
		[104] = {104, ChestFarmer.savedVariables.alikrdesertTC, {284, 47, 283}},
	--Bangkorai 
		[92] = {92, ChestFarmer.savedVariables.bangkoraiTC, {285, 286, 70}},
	--Glenumbra
		[3] = {3, ChestFarmer.savedVariables.glenumbraTC, {58, 107, 65}},
	--Rivenspire 
		[20] = {20, ChestFarmer.savedVariables.rivenspireTC, {60, 98, 282}},
	--Stormhaven 
		[19] = {19, ChestFarmer.savedVariables.stormhavenTC, {22, 112, 93}},
	--Aldmeri Dominion
	--Auridon 
		[381] = {381, ChestFarmer.savedVariables.auridonTC, {36, 86, 105}},
	--Grahtwood 
		[383] = {383, ChestFarmer.savedVariables.grahtwoodTC, {287, 69, 57}},
	--Greenshade 
		[108] = {108, ChestFarmer.savedVariables.greenshadeTC, {64, 106, 288}},
	--Malabal Tor 
		[58] = {58, ChestFarmer.savedVariables.malabaltorTC, {289, 30, 99}},
	--Reaper's March 
		[382] = {382, ChestFarmer.savedVariables.reapersmarchTC, {290, 114, 90}},
	--Neutral zones
	--Summerset 
		[1011] = {1011, ChestFarmer.savedVariables.summersetTC, {382, 383, 384}}, 
	--Western Skyrim 
		[1160] = {1160, ChestFarmer.savedVariables.wSkyrimTC, {487, 488, 489}},
	--Blackreach: Greymoor Caverns 
		[1161] = {1161, ChestFarmer.savedVariables.wSkyrimTC, {487, 488, 489}},
	--Clockwork City 
		[980] = {980, ChestFarmer.savedVariables.clockworkTC, {354, 355, 356}},
	--Coldharbour 
		[347] = {347, ChestFarmer.savedVariables.coldharbourTC, {94, 26, 68}}, 
	--Craglorn 
		[888] = {888, ChestFarmer.savedVariables.craglornTC, {145, 146, 147}},
	--Gold Coast 
		[823] = {823, ChestFarmer.savedVariables.goldcoastTC, {243, 244, 245}},
	--Hew's Bane 
		[816] = {816, ChestFarmer.savedVariables.hewsbaneTC, {227, 228}},
	--Murkmire 
		[726] = {726, ChestFarmer.savedVariables.murkmireTC, {405, 406, 407}},
	--Northern Elsweyr 
		[1086] = {1086, ChestFarmer.savedVariables.nElsweyrTC, {440, 441, 442}},
	--Southern Elsweyr 
		[1133] = {1133, ChestFarmer.savedVariables.sElsweyrTC, {465, 466, 467}},
	--The Reach 
		[1207] = {1207, ChestFarmer.savedVariables.thereachTC, {536, 537, 538}},
	--Blackreach: Arkthzand Cavern 
		[1208] = {1208, ChestFarmer.savedVariables.thereachTC, {536, 537, 538}},
	--Vvardenfell	 
		[849] = {849, ChestFarmer.savedVariables.vvardenfellTC, {320, 321, 322}},
	--Wrothgar 
		[684] = {684, ChestFarmer.savedVariables.wrothgarTC, {210, 212, 218}},
	--Cyrodiil	 
		[181] = {181, ChestFarmer.savedVariables.cyrodiilTC, {101, 39, 85, 131, 422, 419, 52, 128, 133, 113, 480, 104, 482, 127, 25, 130, 83, 238, 126, 100, 417, 59, 237, 109, 234, 108, 76, 235, 89, 67, 132, 420, 418, 421, 97, 63, 50, 481, 129, 236, 111, 239, 125}},
	--Imperial City 
		[584] = {584, ChestFarmer.savedVariables.impcityTC, {179, 184, 246, 253, 181, 200, 180, 201, 199, 248, 247, 204, 205, 206}},
	--Exceptions
	--The Harborage 
		[199] = {199, 0, {}}, 
	--The Earth Forge 
		[208] = {208, 0, {}}, 
	--Eyevea 
		[267] = {267, 0, {}}, 
	--Pregame 
		[279] = {279, 0, {}}, 
	--Battlegrounds
	--Arcane University 
		[511] = {511, 0, {}}, 
	--Deeping Drome 
		[512] = {512, 0, {}}, 
	--Mor Khazgur 
		[513] = {513, 0, {}}, 
	--Istirus Outpost 
		[514] = {514, 0, {}}, 
	--Istirus Outpost Arena 
		[515] = {515, 0, {}}, 
	--Ald Carac 
		[516] = {516, 0, {}}, 
	--Eld Angavar 1 
		[517] = {517, 0, {}}, 
	--Eld Angavar 2 
		[518] = {518, 0, {}}, 
	--Stirk 
		[572] = {572, 0, {}}, 
	--The Wailing Prison 
		[586] = {347, ChestFarmer.savedVariables.coldharbourTC, {94, 26, 68}},
	--The Earth Forge 
		[642] = {642, 0, {}}, 
	--Houses
	--Linchal Grand Manor 
		[1005] = {823, ChestFarmer.savedVariables.goldcoastTC, {243, 244, 245}},
	--Lakemire Xanmeer Manor 
		[1108] = {726, ChestFarmer.savedVariables.murkmireTC, {405, 406, 407}},
	--Enchanted Snow Globe Home 
		[1109] = {101, ChestFarmer.savedVariables.eastmarchTC, {21, 27, 56}},  
	--Thieves' Oasis 
		[1200] = {92, ChestFarmer.savedVariables.bangkoraiTC, {285, 286, 70}},
	--Stone Eagle Aerie 
		[1264] = {1207, ChestFarmer.savedVariables.thereachTC, {536, 537, 538}},
	--Moon Gate 
		[1116] = {1086, ChestFarmer.savedVariables.nElsweyrTC, {440, 441, 442}},
	--The Valley of Blades 
		[1142] = {1142, 0, {}}, 
	--Vahlokzin's Lair 
		[1144] = {1133, ChestFarmer.savedVariables.sElsweyrTC, {465, 466, 467}},
	--The Undergrove 
		[1195] = {1161, ChestFarmer.savedVariables.wSkyrimTC, {487, 488, 489}}
		}
	local actualZoneId = 0
	zoneSets = {}
	collectedSets = 0
	totalSets = 0
	setsPercentage = ""
	tempParentZoneId = GetParentZoneId(GetZoneId(GetUnitZoneIndex("player")))
	actualZoneId, ChestFarmer.numChests, zoneSets = (ChestFarmer.cfReadZone[tempParentZoneId])[1], (ChestFarmer.cfReadZone[tempParentZoneId])[2], (ChestFarmer.cfReadZone[tempParentZoneId])[3]
	
	--Process collection data
	for k,v in pairs(zoneSets) do
		collectedSets = collectedSets + GetNumItemSetCollectionSlotsUnlocked(v)
		totalSets = totalSets + GetNumItemSetCollectionPieces(v)
	end
	if totalSets ~= 0 then
		setsPercentage = string.format("%.2f",(collectedSets/totalSets)*100)
	else
		setsPercentage = 0
	end
	--edgecase for addon initialization
	if ChestFarmer.numChests == nil then
		ChestFarmer.numChests = 0
	end
	
	local actualZone = GetZoneNameById(actualZoneId)
	ChestFarmerWindowZoneDisplay:SetText("Zone: " .. actualZone)
	ChestFarmer.numLockpicks = GetNumLockpicksLeft("player")
	ChestFarmerWindowLockpicksCount:SetText(ChestFarmer.numLockpicks .. " lockpicks remaining") 
	ChestFarmerWindowChestsCount:SetText(ChestFarmer.numChests .. " chests opened")
	ChestFarmerWindowSetsCount:SetText(collectedSets .. "/" .. totalSets .. " collected" .. " (" .. setsPercentage .. "%)")
end

function ChestFarmer.cfWrite(tempTc)
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

function ChestFarmer.interactionLog()
-- Thanks to Shinni for this 'hack' to log last interacted, check out HarvestMap https://www.esoui.com/downloads/info57-HarvestMap.html
	local oldInteract = FISHING_MANAGER.StartInteraction
	FISHING_MANAGER.StartInteraction = function(...)
		local action, name, _, isOwned = GetGameCameraInteractableActionInfo()
		ChestFarmer.wasLastInteractableOwned = isOwned
		--ChestFarmer.lastInteractableName = name
		ChestFarmer.lastInteractableAction = action
		return oldInteract(...)
	end
end

function ChestFarmer.countIncrement()
	if IsUnitInDungeon("player") == true then
		local tempSubZoneId = GetZoneId(GetUnitZoneIndex("player"))
		if ChestFarmer.delvePd[tempSubZoneId] == true then
			if tempSubZoneId == v then
				if (not ChestFarmer.wasLastInteractableOwned) and ChestFarmer.lastInteractableAction == GetString(SI_GAMECAMERAACTIONTYPE12) then
						ChestFarmer.numChests = ChestFarmer.numChests + 1
				end
			end
		end
	else
		if (not ChestFarmer.wasLastInteractableOwned) and ChestFarmer.lastInteractableAction == GetString(SI_GAMECAMERAACTIONTYPE12) then
			ChestFarmer.numChests = ChestFarmer.numChests + 1
		end
	end
	ChestFarmer.cfWrite(ChestFarmer.numChests)
	ChestFarmer.numLockpicks = GetNumLockpicksLeft("player")
	ChestFarmerWindowLockpicksCount:SetText(ChestFarmer.numLockpicks .. " lockpicks remaining")
	ChestFarmerWindowChestsCount:SetText(ChestFarmer.numChests .. " chests opened")
end

--Events

EVENT_MANAGER:RegisterForEvent(ChestFarmer.name, EVENT_ADD_ON_LOADED, ChestFarmer.onAddonLoaded)
EVENT_MANAGER:RegisterForEvent(ChestFarmer.name, EVENT_PLAYER_ACTIVATED, ChestFarmer.cfRead)
EVENT_MANAGER:RegisterForEvent(ChestFarmer.name, EVENT_LOCKPICK_SUCCESS, ChestFarmer.countIncrement)
EVENT_MANAGER:RegisterForEvent(ChestFarmer.name, EVENT_ITEM_SET_COLLECTION_UPDATED,	ChestFarmer.cfRead)
EVENT_MANAGER:RegisterForUpdate("fixCollected", 3000, ChestFarmer.fixCollected)
EVENT_MANAGER:RegisterForUpdate("ChestFarmer-InteractionLog", 800, ChestFarmer.interactionLog)

--Slash commands
SLASH_COMMANDS["/chestfarmer"] = ChestFarmer.slashHandler