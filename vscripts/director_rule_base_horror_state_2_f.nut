Msg("Initiating Director Horror State 2 Map Final Scenario...\n");

IncludeScript("ths_scripts_base/iv_warning_msg_system.nut", this) //MSG and Core Script manager (base commands and Start, Shutdow system)


IVCoreStartup(debug_enabled, "director_rule_base_horror_state_2_f.nut")
msg_sound_channel <- "s_msg_system"

debug_enabled <- true //DISABLE IT WHEN RELEASING MAP!!!

//IV note: Custom Director Parms
ProhibitBossesCheckSState <- false
SpecialInfectedCount <- 1


if(l4d_s_count >= 3 )
{
	ProhibitBossesCheckSState = false
	SpecialInfectedCount = 5
}
else
{
	ProhibitBossesCheckSState = true
	SpecialInfectedCount = 3
}


DirectorOptions <-
{
	// This turns off tanks and witches (when true).
	ProhibitBosses = ProhibitBossesCheckSState

	//LockTempo = true

	// Sets the time between mob spawns. Mobs can only spawn when the pacing is in the BUILD_UP state.
	MobSpawnMinTime = 1
	MobSpawnMaxTime = 5

	// How many zombies are in each mob.
	MobMinSize = 15
	MobMaxSize = 30
	MobMaxPending = 30

	// Modifies the length of the SUSTAIN_PEAK and RELAX states to shorten the time between mob spawns.
	SustainPeakMinTime = 5
	SustainPeakMaxTime = 10
	IntensityRelaxThreshold = 0.99
	RelaxMinInterval = 1
	RelaxMaxInterval = 5
	RelaxMaxFlowTravel = 50

	//Special infected options
	SpecialRespawnInterval = 2.5
        SmokerLimit = 1
		SpitterLimit = 1
        JockeyLimit = 2
        BoomerLimit = 2
        HunterLimit = 3
        ChargerLimit = 0

	// Valid spawn locations
	PreferredMobDirection = SPAWN_NO_PREFERENCE
    MaxSpecials = SpecialInfectedCount
	ZombieSpawnRange = 3000
}

if(debug_enabled == true)
{
	printl(thsdev_logo+"Debug END Map state info:")
	printl(thsdev_logo+"ProhibitBosses parm = "+ProhibitBossesCheckSState)
	printl(thsdev_logo+"MaxSpecials parm = "+SpecialInfectedCount)
}

TestSurvivorsMSG()

/*if(survivor_l4d2_list[0] == null && survivor_l4d2_list[1] == null && survivor_l4d2_list[2] == null && survivor_l4d2_list[3] == null && survivor_l4d_list[0] == null && survivor_l4d_list[1] == null && survivor_l4d_list[2] == null && survivor_l4d_list[3] == null )
{
ReleaseWarnigMessage(debug_enabled, "No Survivors Founded!!! Aborting...")
}*/

Director.ResetMobTimer()		// Sets the mob spawn timer to 0.
Director.PlayMegaMobWarningSounds()	// Plays the incoming mob sound effect.