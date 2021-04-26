Msg("Initiating Director Horror Pre Search Scenario...\n");

DirectorOptions <-
{
	// This turns off tanks and witches (when true).
	ProhibitBosses = true

	// Pams for pre start z
	NoMobSpawns = true
	CommonLimit = 5
	
	//LockTempo = true

	// Sets the time between mob spawns. Mobs can only spawn when the pacing is in the BUILD_UP state.
	MobSpawnMinTime = 120
	MobSpawnMaxTime = 180

	// How many zombies are in each mob.
	MobMinSize = 30
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
        SmokerLimit = 0
        JockeyLimit = 0
        BoomerLimit = 0
        HunterLimit = 0
        ChargerLimit = 0

	// Valid spawn locations
	PreferredMobDirection = SPAWN_NO_PREFERENCE
	ZombieSpawnRange = 1320
}
