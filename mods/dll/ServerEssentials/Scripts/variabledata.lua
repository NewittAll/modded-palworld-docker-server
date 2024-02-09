local variabletypes = {}

-- Use this file purely for reference, do not change anything here!
-- Float/Int32 mentions here are purely to help keep track of what type each value is and to keep code a little cleaner
-- Float is a whole number with a decimal (1.2 as an example)
-- Integer is a whole number (25 as an example)

-- Health after respawning (Default 1.00 which is 100%)
variabletypes["PlayerHPRateFromRespawn"] = "Float"

-- Hunger after respawning (Default 1.00 which is 100%)
variabletypes["PlayerStomachRateFromRespawn"] = "Float"

-- Headshot Damage Multiplier ? Default 2.00
variabletypes["DamageRate_WealPoint"] = "Float"

-- Bodyshot Damage Multiplier ? Default 0.50
variabletypes["DamageRate_StrongPoint"] = "Float"

-- Damage reduction for broken weapons (Default 0.20)
variabletypes["BreakedWeaponDamageRate"] = "Float"

-- Defense reduction for broken armor (Default 0.20)
variabletypes["BreakedArmorDefenseRate"] = "Float"

-- Health regen in % per second (Default 1% or 0.1)
variabletypes["AutoHPRegene_Percent_perSecond"] = "Float"

-- Health regen while sleeping in % per second (Default 1% or 0.1)
variabletypes["AutoHPRegene_Percent_perSecond_Sleeping"] = "Float"

-- Health regen while sleeping in % per second (Default 1% or 0.1)
variabletypes["AutoHPRegene_Percent_perSecond_Sleeping"] = "Float"

-- How many Palworld minutes should a real world minute be (Default 20 Palworld minutes)
variabletypes["PalWorldMinutes_RealOneMinute"] = "Int32"

-- At what time should night start? (Default 8PM in-game)
variabletypes["NightStartHour"] = "Int32"

-- At what time should night end? (Default 5AM in-game)
variabletypes["NightEndHour"] = "Int32"

-- Amount of time to wait until skipping night while in bed (Default 3 seconds)
variabletypes["NightSkipWaitSecond"] = "Float"

-- Base Max Range? (Default 5000.00 meters)
variabletypes["BaseCampAreaRange"] = "Float"

-- Base Max Range? (Default 5000.00 meters)
variabletypes["BaseCampAreaRange"] = "Float"

-- Amount of time to show the respawn screen in seconds (Default 3 seconds)
variabletypes["OpenGameOverUITime"] = "Float"

-- Time to wait to be able to respawn in seconds (Default 10 seconds)
variabletypes["BlockRespawnTime"] = "Float"

-- How long to press to hatch an egg (Default 4 seconds)
variabletypes["LongPressInterval_GetHatchedPal"] = "Float"

-- How long to press to unlock a cage (Default 5 seconds)
variabletypes["LongPressInterval_EnemyCampCage"] = "Float"

-- Technology points gained per level (Default 3)
variabletypes["technologyPointPerLevel"] = "Int32"

-- Technology points gained from first kill of a tower boss? (Default 5)
variabletypes["bossTechnologyPointPerTowerBoss"] = "Int32"

-- Technology points gained from first kill of a normal boss? (Default 1)
variabletypes["bossTechnologyPointPerTowerBoss"] = "Int32"

-- Amount of times you can fail to unlock a password protected chest (Default 3)
variabletypes["PasswordLockFailedMaxNum"] = "Int32"

-- How long to press to join another player's guild (Default 4 seconds)
variabletypes["JoinGuildRequestInteractLongPushTime"] = "Float"

-- How long until a Pal inside a PalBox is revived in minutes (Default 10 minutes)
variabletypes["PalBoxReviveTime"] = "Float"

return variabletypes