/* Ivan Suvorov and THS inc 2023 */
/* IV Note: Game Main Director Rules */

printl("Initialising Main Director Rules...")

DirectorOptions <-
{
	WanderingZombieDensityModifier = 1

    CommonLimit = 30

	// This turns off tanks and witches (when true).
	ProhibitBosses = false

	// Sets the time between mob spawns. Mobs can only spawn when the pacing is in the BUILD_UP state.
	MobSpawnMinTime = 180
	MobSpawnMaxTime = 210

	// How many zombies are in each mob.
	MobMinSize = 30
	MobMaxSize = 45
	MobMaxPending = 15

	// Modifies the length of the SUSTAIN_PEAK and RELAX states to shorten the time between mob spawns.
	SustainPeakMinTime = 5
	SustainPeakMaxTime = 10
	IntensityRelaxThreshold = 0.99
	RelaxMinInterval = 1
	RelaxMaxInterval = 5
	RelaxMaxFlowTravel = 50

	//Special infected options
	SpecialRespawnInterval = 15

	// Valid spawn locations
	PreferredMobDirection = SPAWN_FAR_AWAY_FROM_SURVIVORS
	ZombieSpawnRange = 1500
}
