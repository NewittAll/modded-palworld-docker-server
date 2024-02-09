local utilities = require("./utilities")
local commands = require("./commands")
local config = require("./config")

local Prefix = string.format("^%s", config.CommandPrefix)
local PlayerList = {}

local function LogChatMessage(Category, Player, Message)
    if config.LogChatMessages == true then
        if Category <= config.LogChatLevel then
            print(string.format("[%s] %s: %s\n", utilities.GetChatCategoryName(Category), Player.PlayerNamePrivate:ToString(), Message))
        end
    end
end

local function CommandHandler(PlayerState, CommandArgs)
    local Command = commands[CommandArgs[0]]
    if Command ~= nil then
        if Command.IsAdminOnly == true then
            if not utilities.IsPlayerAdmin(PlayerState) == true then
                return
            end
            Command.run(PlayerState, CommandArgs)
        end
    end
end

RegisterHook("/Script/Pal.PalPlayerState:EnterChat_Receive", function(Context, ChatMessage)
   local Message = ChatMessage:get().Message:ToString()
   LogChatMessage(ChatMessage:get().Category, Context:get(), Message)
   if string.match(Message, Prefix) then
      local MessageNoPrefix = string.sub(Message, 2)
      local CommandArgs = utilities.SplitCommandIntoArgs(MessageNoPrefix)
      CommandHandler(Context:get(), CommandArgs)
   end
end)

RegisterHook("/Script/Pal.PalPlayerCharacter:OnCompleteInitializeParameter", function(Context, Character)
    if config.ShowNotificationOnPlayerConnect == true then
        local Player = Context:get()
        local PlayerState = Player.PlayerState
        if PlayerList[PlayerState.PlayerId] == nil then
            local PlayerName = PlayerState.PlayerNamePrivate:ToString()
            local JoinMessage = string.format("%s has connected.", PlayerName)
            PlayerList[PlayerState.PlayerId] = PlayerName
            print(string.format("%s\n", JoinMessage))
            utilities.SendMessage(Context:get(), JoinMessage) 
        end
    end
end)

RegisterHook("/Script/Pal.PalPlayerController:OnDestroyPawn", function(Context, Actor)
    if config.ShowNotificationOnPlayerDisconnect == true then
        local Player = Context:get()
        local PlayerState = Player.PlayerState
        local PlayerName = PlayerState.PlayerNamePrivate:ToString()
        local LeaveMessage = string.format("%s has disconnected.", PlayerName)
        PlayerList[PlayerState.PlayerId] = nil
        print(string.format("%s\n", LeaveMessage))
        utilities.SendMessage(Context:get(), LeaveMessage)
    end
end)