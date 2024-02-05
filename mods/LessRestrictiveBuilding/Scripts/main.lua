-- Caites_mods
-- BaseCampNeighborMinimumDistance - possibly minimal distance between bases, float, default is ?
BaseCampNeighborMinimumDistance = -8400

-- PlayerRecord_BuildingObjectMaxNum - possibly maximum number of objects build by character, default is ?
PlayerRecord_BuildingObjectMaxNum = 99999999

-- BuildSimulationFoundationFloatingAllowance - height at what floating foundations allowed to be built, default is ?
BuildSimulationFoundationFloatingAllowance = 99999999

-- BuildSimulationLeanAngleMax - allowed inclination for objects, default is around 30
BuildSimulationLeanAngleMax = 90

-- BuildingMaxZ - possibly max height allowed for building, default is ?
BuildingMaxZ = 99999999

print("Less Restrictive Building loaded\n")

NotifyOnNewObject("/Script/Pal.PalGameSetting", function(PalGameSetting)
	PalGameSetting.BuildSimulationFoundationFloatingAllowance = BuildSimulationFoundationFloatingAllowance
	PalGameSetting.BuildSimulationLeanAngleMax = BuildSimulationLeanAngleMax
	PalGameSetting.BuildingMaxZ = BuildingMaxZ
	PalGameSetting.BaseCampNeighborMinimumDistance = BaseCampNeighborMinimumDistance
	PalGameSetting.PlayerRecord_BuildingObjectMaxNum = PlayerRecord_BuildingObjectMaxNum

end)
