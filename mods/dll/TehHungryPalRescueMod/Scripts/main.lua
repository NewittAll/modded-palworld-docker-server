local config = require "config"
local PalUtility = nil
local isHooked = false
local returnToTitle = false
local hungry_pals = {}

local function tryUnstuckPal(pal)
    local name = pal:GetFullName()
    local params = pal.CharacterParameterComponent
    local is_sleep = params.IsSleepAction
    if (is_sleep == true) then
        hungry_pals[name] = nil
        return
    end
    print("[THPR] Pal " .. name .. " is probably stuck and cant reach food box\n")
    local spawn_location = pal.SpawnLocation_ForServer
    if PalUtility then
        print("[THPR] Teleporting pal to spawn location...\n")
        if pal then
            PalUtility:TeleportAroundLoccation(pal, {X=spawn_location.X,Y=spawn_location.Y,Z=spawn_location.Z}, {W=0.0,X=0.0,Y=0.0,Z=0.0})
            hungry_pals[name] = nil
        end
    else
        print("[THPR] No pal utility found")
    end
end

local function palHungryCheck()
    if returnToTitle then
        print("[THPR] Skipping hunger check because on title screen\n")
        hungry_pals = {}
        return false
    end
    if next(hungry_pals) ~= nil then
        local timeNow = os.time()
        for _, palData in pairs(hungry_pals) do
            local elapsedTime = timeNow - palData.start
            if elapsedTime > config.reset_if_has_not_eaten_in then
                tryUnstuckPal(palData.pal)
            end
        end
    end
    return false
end

local function palAte(controller)
    local pal = controller:get():GetCharacter()
    local p_name = pal:GetFullName()
    hungry_pals[p_name] = nil
end

local function palHungry(self)
    local pal = self:get():GetCharacter()
    local p_name = pal:GetFullName()
    if hungry_pals[p_name] == nil then
        hungry_pals[p_name] = {start=os.time(), pal=pal}
    end
end

RegisterHook("/Script/Engine.PlayerController:ServerAcknowledgePossession", function ()
    returnToTitle = false
    if (not isHooked) then
        local delay = config.loop_interval * 1000
        LoopAsync(delay, palHungryCheck)
        PalUtility = StaticFindObject("/Script/Pal.Default__PalUtility")
        RegisterHook("/Game/Pal/Blueprint/Controller/AIAction/BaseCamp/RecoverHungry/BP_AIAction_BaseCampRecoverHungry.BP_AIAction_BaseCampRecoverHungry_C:ActionStart", palHungry)
        RegisterHook("/Game/Pal/Blueprint/Controller/AIAction/BaseCamp/RecoverHungry/BP_AIAction_BaseCampRecoverHungry.BP_AIAction_BaseCampRecoverHungry_C:ChangeActionEat", palAte)
        if not config.running_on_dedicated_server then
            ExecuteWithDelay(15000, function() RegisterHook("/Game/Pal/Blueprint/UI/UserInterface/ESCMenu/WBP_MenuESC.WBP_MenuESC_C:OnReturn2Title", function() returnToTitle=true end) end)
        end
        isHooked = true
        print("[THPR] Registered Hooks\n")
    end
end)