Msg("Initiating Director Horror State 1 Scenario...\n");

DirectorOptions <-
{
	// This turns off tanks and witches (when true).
	ProhibitBosses = false
	
	//LockTempo = true

	// Sets the time between mob spawns. Mobs can only spawn when the pacing is in the BUILD_UP state.
	MobSpawnMinTime = 45
	MobSpawnMaxTime = 72

	// How many zombies are in each mob.
	MobMinSize = 12
	MobMaxSize = 25
	MobMaxPending = 25

	// Modifies the length of the SUSTAIN_PEAK and RELAX states to shorten the time between mob spawns.
	SustainPeakMinTime = 5
	SustainPeakMaxTime = 10
	IntensityRelaxThreshold = 0.99
	RelaxMinInterval = 1
	RelaxMaxInterval = 5
	RelaxMaxFlowTravel = 50

	//Special infected options
	SpecialRespawnInterval = 15
        SmokerLimit = 1
		SpitterLimit = 0
        JockeyLimit = 0
        BoomerLimit = 1
        HunterLimit = 3
        ChargerLimit = 1

	// Valid spawn locations
	PreferredMobDirection = SPAWN_NO_PREFERENCE
    MaxSpecials = 3
	ZombieSpawnRange = 2300
}

Director.ResetMobTimer()		// Sets the mob spawn timer to 0.