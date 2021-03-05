Msg("Initiating LonleyM1Main\n");

DirectorOptions <-
{
	// This turns off tanks and witches (when true).
	ProhibitBosses = true
	
	//LockTempo = true

	// Sets the time between mob spawns. Mobs can only spawn when the pacing is in the BUILD_UP state.
	MobSpawnMinTime = 999999
	MobSpawnMaxTime = 999999

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
	SpecialRespawnInterval = 1.0
        SmokerLimit = 1
        JockeyLimit = 2
        BoomerLimit = 0
        HunterLimit = 3
        ChargerLimit = 1

	// Valid spawn locations
	PreferredMobDirection = SPAWN_NO_PREFERENCE
	ZombieSpawnRange = 2300
}