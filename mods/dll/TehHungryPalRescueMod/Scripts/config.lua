local _TehHPRConfig = {
    -- Default: 10 | How often (in seconds) the mod checks for hungry pals. Lowering this will make it check more often, but may have a performance impact.
    loop_interval = 10,
    -- Default: 20 | How much elapsed time (in seconds) before a hungry pal is considered stuck and teleported. 
    -- Do not lower this more than ~20 seconds, or you may get pals stuck in a teleport loop.
    reset_if_has_not_eaten_in = 20,
    -- Default: false | Turn this to true if you are running the mod on a dedicated server (PalServer)
    running_on_dedicated_server = false
}

return _TehHPRConfig