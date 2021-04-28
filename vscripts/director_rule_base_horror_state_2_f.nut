Msg("Initiating Director Horror State 2 Map Final Scenario...\n");

IncludeScript("ths_scripts_base/iv_warning_msg_system.nut", this) //MSG and Core Script manager (base commands and Start, Shutdow system)


IVCoreStartup(debug_enabled, "director_rule_base_horror_state_2_f.nut")


DirectorOptions <-
{
	// This turns off tanks and witches (when true).
	ProhibitBosses = false
	
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
    MaxSpecials = 5
	ZombieSpawnRange = 3000
}

if(debug_enabled == true)
{
	printl(thsdev_logo+thsdev_error_logo+"Debug END Map state info:")
	printl(thsdev_logo+thsdev_error_logo+"ProhibitBosses parm = "+ProhibitBosses)
	printl(thsdev_logo+thsdev_error_logo+"MobSpawnMinTime parm = "+MobSpawnMinTime)
	printl(thsdev_logo+thsdev_error_logo+"MobSpawnMaxTime parm = "+MobSpawnMaxTime)
	printl(thsdev_logo+thsdev_error_logo+"MobMinSize parm = "+MobMinSize)
	printl(thsdev_logo+thsdev_error_logo+"MobMaxSize parm = "+MobMaxSize)
	printl(thsdev_logo+thsdev_error_logo+"MobMaxPending parm = "+MobMaxPending)
	printl(thsdev_logo+thsdev_error_logo+"SustainPeakMinTime parm = "+SustainPeakMinTime)
	printl(thsdev_logo+thsdev_error_logo+"SustainPeakMaxTime parm = "+SustainPeakMaxTime)
	printl(thsdev_logo+thsdev_error_logo+"IntensityRelaxThreshold parm = "+IntensityRelaxThreshold)
	printl(thsdev_logo+thsdev_error_logo+"RelaxMinInterval parm = "+RelaxMinInterval)
	printl(thsdev_logo+thsdev_error_logo+"RelaxMaxInterval parm = "+RelaxMaxInterval)
	printl(thsdev_logo+thsdev_error_logo+"RelaxMaxFlowTravel parm = "+RelaxMaxFlowTravel)
	printl(thsdev_logo+thsdev_error_logo+"SpecialRespawnInterval parm = "+SpecialRespawnInterval)
	printl(thsdev_logo+thsdev_error_logo+"PreferredMobDirection parm = "+PreferredMobDirection)
	printl(thsdev_logo+thsdev_error_logo+"MaxSpecials parm = "+MaxSpecials)
	printl(thsdev_logo+thsdev_error_logo+"ZombieSpawnRange parm = "+ZombieSpawnRange)
	printl(thsdev_logo+thsdev_error_logo+"Debug END Special Infected Map state info:")
	printl(thsdev_logo+thsdev_error_logo+"SmokerLimit parm = "+SmokerLimit)
	printl(thsdev_logo+thsdev_error_logo+"SpitterLimit parm = "+SpitterLimit)
	printl(thsdev_logo+thsdev_error_logo+"JockeyLimit parm = "+JockeyLimit)
	printl(thsdev_logo+thsdev_error_logo+"BoomerLimit parm = "+BoomerLimit)
	printl(thsdev_logo+thsdev_error_logo+"HunterLimit parm = "+HunterLimit)
	printl(thsdev_logo+thsdev_error_logo+"ChargerLimit parm = "+ChargerLimit)
}

TestSurvivorsMSG()

if(survivor_l4d2_list[0] == null && survivor_l4d2_list[1] == null && survivor_l4d2_list[2] == null && survivor_l4d2_list[3] == null && survivor_l4d_list[0] == null && survivor_l4d_list[1] == null && survivor_l4d_list[2] == null && survivor_l4d_list[3] == null )
{
ReleaseWarnigMessage(debug_enabled, "No Survivors Founded!!! Aborting...")
}

Director.ResetMobTimer()		// Sets the mob spawn timer to 0.
Director.PlayMegaMobWarningSounds()	// Plays the incoming mob sound effect.