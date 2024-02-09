-- made by caites

local palConfig = require "config"

-- Prints the mod successful loading message in red
print(palConfig.palRedColorWrapperFront .. palConfig.palModName .. " version " .. palConfig.palModVersion .. " loaded for game version " .. palConfig.palGameVersion .. palConfig.palRedColorWrapperBack)

-- Register the new modifiers and print a successful change message in red
RegisterHook("/Script/Engine.PlayerController:ClientRestart", function()
    if palConfig.palCheckRestart ~= 1 then
        local items = FindAllOf("PalGameSetting")
        if items then
            for _, item in ipairs(items) do                
				item.PalBoxPageNum  = palConfig.PalBoxPageNum	
				item.PalBoxSlotNumInPage  = palConfig.PalBoxSlotNumInPage				
            end
        end
        print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Number of boxes set to " .. palConfig.PalBoxPageNum .. palConfig.palRedColorWrapperBack)
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Slots per box set to " .. palConfig.PalBoxSlotNumInPage .. palConfig.palRedColorWrapperBack)
				
    end
    palConfig.palCheckRestart = 1
end)

-- made by XxInvictus
-- [DEDICATED SRV] Register the new modifiers and print a successful change message in red
RegisterHook("/Script/Engine.PlayerController:ServerAcknowledgePossession", function(Context)
    if not serverCheckRestart then
        local items = FindAllOf("PalGameSetting")
        if items then
            for _, item in ipairs(items) do                
				item.PalBoxPageNum  = palConfig.PalBoxPageNum	
				item.PalBoxSlotNumInPage  = palConfig.PalBoxSlotNumInPage				
            end
        end
        print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Number of boxes set to " .. palConfig.PalBoxPageNum .. palConfig.palRedColorWrapperBack)
		print(palConfig.palRedColorWrapperFront .. "[" .. palConfig.palModName .. "] Slots per box set to " .. palConfig.PalBoxSlotNumInPage .. palConfig.palRedColorWrapperBack)
    end
    serverCheckRestart = true
end)
