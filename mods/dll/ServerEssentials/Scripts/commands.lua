local commands = {}

local config = require("./config")
local utilities = require("./utilities")
local variabletypes = require("./variabledata")

-- Sets the time of day (0-23)
commands["settime"] = {}
commands["settime"].IsAdminOnly = true
commands["settime"].run = function(PlayerState, CommandArgs)
    local TimeManager = FindFirstOf("PalTimeManager")
    local Hour = tonumber(CommandArgs[1])
    if Hour ~= nil then
        if type(Hour) == "number" then
            TimeManager:SetGameTime_FixDay(Hour)
            utilities.SendMessage(PlayerState, string.format("%s has changed the time of day to %s", PlayerState.PlayerNamePrivate:ToString(), Hour))
        end
    end
end

-- Sets variables inside PalGameSetting
-- Only works for the listed variables inside variabledata.lua for now
commands["set"] = {}
commands["set"].IsAdminOnly = true
commands["set"].run = function(PlayerState, CommandArgs)
    if config.AllowSetCommand == true then
        local SettingName = CommandArgs[1]
        local PalGameSetting = utilities.GetPalGameSetting()
        local VariableType = variabletypes[SettingName]
        if VariableType ~= nil then
            if VariableType == "Float" then
                local Variable = tonumber(CommandArgs[2])
                if Variable ~= nil then
                    PalGameSetting:SetPropertyValue(SettingName, Variable)
                    utilities.SendMessage(PlayerState, string.format("%s has changed '%s' to %s", PlayerState.PlayerNamePrivate:ToString(), SettingName, Variable))
                end
            elseif VariableType == "Int32" then
                local Variable = tonumber(CommandArgs[2])
                if Variable ~= nil then
                    PalGameSetting[VariableType] = Variable
                    utilities.SendMessage(PlayerState, string.format("%s has changed '%s' to %s", PlayerState.PlayerNamePrivate:ToString(), SettingName, Variable))
                end
            else
                print(string.format("Invalid Type: '%s'\n", VariableType))
            end
        else
            print(string.format("Invalid Setting: '%s'\n", SettingName))
        end
    end
end

-- Teleports to another player by their name, must be admin to use the command
commands["tp"] = {}
commands["tp"].IsAdminOnly = true
commands["tp"].run = function(PlayerState, CommandArgs)
    local Player = PlayerState.PawnPrivate
    if config.AllowTeleport == true then
        local TargetName = CommandArgs[1]
        if TargetName ~= nil then
            utilities.TeleportTo(Player, TargetName)
        end
    end
end

return commands