Msg("[THS] Director Horror Mode!!!\n");

DirectorOptions <-
{
	// This turns off tanks and witches.
	ProhibitBosses = false

	//LockTempo = true
	CommonLimit = 30
	MobSpawnMinTime = 3
	MobSpawnMaxTime = 7
	MobMinSize = 15
	MobMaxSize = 18
	MobMaxPending = 30
	SustainPeakMinTime = 5
	SustainPeakMaxTime = 10
	IntensityRelaxThreshold = 0.99
	RelaxMinInterval = 1
	RelaxMaxInterval = 5
	RelaxMaxFlowTravel = 50
	SpecialRespawnInterval = 1.0
        SmokerLimit = 2
        JockeyLimit = 0
        BoomerLimit = 1
        HunterLimit = 3
        ChargerLimit = 0
		TankLimit = 1
	PreferredMobDirection = SPAWN_IN_FRONT_OF_SURVIVORS
	ZombieSpawnRange = 2500
}

Director.ResetMobTimer()
Director.PlayMegaMobWarningSounds()
