--~klusterfk~--

--This is for things that are bound to floor/ground placement, like crafting stations.
--I tested 35-125. Could maybe get away with ~150 before it gets stupid.
InstallDistanceNormalFromOwner = 100  --Default: 100

--This is for everything else. Adjust to your liking. 
--I found 2600 to be comfortable. Beyond 3000 is ridiculous.
--Default range reaches 1-2 tile away. 3 tiles is around 1750. 5 tiles around 2600
InstallableRange = 2600  --Default 1000: -- Default range is ~1.5 tiles reach. 2600 is roughly 5 tiles.1750/3


clientRestarted = false
RegisterHook("/Script/Engine.PlayerController:ClientRestart", function(Context, NewPawn)
	Player = Context:get().Pawn

	PalBuilderComponent = FindFirstOf("PalBuilderComponent")
	DoPalBuilderComponentTweaks(PalBuilderComponent)

	clientRestarted = true
end)

if clientRestarted then
	NotifyOnNewObject("/Script/Pal.PalBuilderComponent", function(PalBuilderComponent)
		DoPalBuilderComponentTweaks(PalBuilderComponent)
	end)

end

function DoPalBuilderComponentTweaks()
	PalBuilderComponent.InstallDistanceNormalFromOwner = InstallDistanceNormalFromOwner
	PalBuilderComponent.InstallableRange = InstallableRange
end