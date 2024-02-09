local config = {}

-- Prefix required to trigger a command e.g !settime (Default is !)
config.CommandPrefix = "!"

-- Sends a system message to every player on the server when someone connects (true / false)
config.ShowNotificationOnPlayerConnect = true

-- Sends a system message to every player on the server when someone disconnects (true / false)
config.ShowNotificationOnPlayerDisconnect = true

-- Should the server show a log of messages in console whenever a player send a message (true / false)
config.LogChatMessages = true

-- Log categories at and below this
-- 0 = None
-- 1 = Global
-- 2 = Guild + Global
-- 3 = Guild + Global + Say (Proximity?)
config.LogChatLevel = 3

-- Enables/disables the !set command for changing PalGameSetting variables
config.AllowSetCommand = true

-- Enables/disables the !obtain and !give command for adding items to inventories
config.AllowItemCommands = true

-- Enables/disables the !tp command
config.AllowTeleport = true

return config