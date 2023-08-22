Msg("Initiating Assault Map Onslaught\n");

DirectorOptions <-
{
	// This turns off tanks and witches.
	ProhibitBosses = false

	//LockTempo = true
	MobSpawnMinTime = 1
	MobSpawnMaxTime = 1
	MobMinSize = 30
	MobMaxSize = 30
	MobMaxPending = 30
	SustainPeakMinTime = 5
	SustainPeakMaxTime = 10
	IntensityRelaxThreshold = 0.99
	RelaxMinInterval = 1
	RelaxMaxInterval = 5
	RelaxMaxFlowTravel = 50
	SpecialRespawnInterval = 5
        SmokerLimit = 1
        JockeyLimit = 0
        BoomerLimit = 1
        HunterLimit = 3
        ChargerLimit = 0
	PreferredMobDirection = SPAWN_IN_FRONT_OF_SURVIVORS
	ZombieSpawnRange = 2800
}

Director.ResetMobTimer()
Director.PlayMegaMobWarningSounds()

