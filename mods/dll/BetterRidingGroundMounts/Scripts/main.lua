-- made by caites

local palConfig = require "config"

-- Prints the mod successful loading message in red
print(palConfig.palRedColorWrapperFront .. palConfig.palModName .. " version " .. palConfig.palModVersion .. " loaded for game version " .. palConfig.palGameVersion .. palConfig.palRedColorWrapperBack)

-- [CLIENT] Register the new modifiers and print a successful change message in red
RegisterHook("/Script/Engine.PlayerController:ClientRestart", function()
    if not palConfig.clientRestarted then
        local items = FindAllOf("PalGameSetting")
        if items then
            for _, item in ipairs(items) do                
				item.WalkableFloorAngleForRide  = palConfig.WalkableFloorAngleForRide			
            end
        end
        print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Max angle of obstacle climible by ground mount set to " .. palConfig.WalkableFloorAngleForRide .. palConfig.palRedColorWrapperBack)
				
    end
    palConfig.clientRestarted = true
end)

-- [DEDICATED SRV] Register the new modifiers and print a successful change message in red
RegisterHook("/Script/Engine.PlayerController:ServerAcknowledgePossession", function(Context)
    if not palConfig.serverAcknowledgedPossession then
        local items = FindAllOf("PalGameSetting")
        if items then
            for _, item in ipairs(items) do                
				item.WalkableFloorAngleForRide  = palConfig.WalkableFloorAngleForRide			
            end
        end
        print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Max angle of obstacle climible by ground mount set to " .. palConfig.WalkableFloorAngleForRide .. palConfig.palRedColorWrapperBack)
				
    end
    palConfig.serverAcknowledgedPossession = true
end)