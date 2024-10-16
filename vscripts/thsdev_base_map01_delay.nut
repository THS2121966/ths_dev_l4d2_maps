Msg("**[THS] Delay started**\n")

DirectorOptions <-
{
	MobMinSize = 2
	MobMaxSize = 3
        
	BoomerLimit = 0
	SmokerLimit = 0
	HunterLimit = 0
	SpitterLimit = 0
	JockeyLimit = 0
	ChargerLimit = 0
        
	MinimumStageTime = 15
       
	CommonLimit = 5
}

Director.ResetMobTimer() //Start the above onslaught settings immediately


// start the delay timer
EntFire( "timer_delay_end", "enable" )

//reset for this stage (PANIC and TANK depend on other factors)
DelayTouchedOrPoured   <- 0
DelayPoured            <- 0
//-------------------------------------------------


// abort the delay if a survivor picks up or pours a gas can
// Function called by c1m4_atrium_finale.nut
function AbortDelay()
{
    Msg("**Delay aborted early**\n")    
    EntFire( "timer_delay_abort", "enable" )
}

// called by the timers themselves
// These EntFired timers MUST be the same targetname in the map!
function EndDelay()
{
        Msg("**Delay ended**\n") 
        EntFire( "timer_delay_end", "Disable" )
        EntFire( "timer_delay_end", "ResetTimer" )
        EntFire( "timer_delay_abort", "Disable" )
        EntFire( "timer_delay_abort", "ResetTimer" )
        EntFire( "@director", "EndCustomScriptedStage" )
}