local utilities = {}

function utilities.GetChatCategoryName(Channel)
    if Channel == 0 then
        return "Unknown"
    elseif Channel == 1 then
        return "Global"
    elseif Channel == 2 then
        return "Guild"
    elseif Channel == 3 then
        return "Say"
    end
end

function utilities.GetPalUtility() 
    return StaticFindObject("/Script/Pal.Default__PalUtility")
end

local PalUtility = utilities.GetPalUtility()

local PalGameSetting = nil

function utilities.GetPalGameSetting()
    if PalGameSetting == nil or not PalGameSetting:IsValid() then
        PalGameSetting = FindFirstOf("PalGameSetting")
    end

    return PalGameSetting
end

local GameplayStatics = StaticFindObject("/Script/Engine.Default__GameplayStatics")

function utilities.GetAllActorsOfClass(WorldContextObject, Class, OutArray)
    GameplayStatics:GetAllActorsOfClass(WorldContextObject, Class, OutArray)
end

function utilities.SendMessage(WorldContext, Message)
    if PalUtility == nil or not PalUtility:IsValid() then
        PalUtility = utilities.GetPalUtility()
    end

    PalUtility:SendSystemAnnounce(WorldContext, Message)
end

function utilities.TeleportTo(Player, TargetName)
    if PalUtility == nil or not PalUtility:IsValid() then
        PalUtility = utilities.GetPalUtility()
    end

    local Players = FindAllOf("PalPlayerCharacter")

    for index, OtherPlayer in pairs(Players) do
        local OtherState = OtherPlayer.PlayerState
        if OtherState ~= nil and OtherState:IsValid() then
            local OtherName = OtherState.PlayerNamePrivate
            if OtherName ~= nil then
                if OtherName:ToString() == TargetName then
                    PalUtility:Teleport(Player, OtherPlayer:K2_GetActorLocation(), OtherPlayer:K2_GetActorRotation(), true, false)
                end
            end
        end
    end
end

function utilities.IsPlayerAdmin(PlayerState)
    return PlayerState:GetPlayerController().bAdmin
end

function utilities.SplitCommandIntoArgs(Command)
    local Args = {}
    local Index = 0
    for match in Command:gmatch("%S+") do
        Args[Index] = match
        Index = Index + 1
    end
    return Args
end

return utilities