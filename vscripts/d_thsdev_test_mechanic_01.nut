Msg("Initiating thsdev_test_mechanic_01_d_logic\n");

DirectorOptions <-
{
	AlwaysAllowWanderers = true
	MobSpawnMinTime = 60
	MobSpawnMaxTime = 90
	MobMinSize = 12
	MobMaxSize = 20
	MobMaxPending = 20
	SustainPeakMinTime = 5
	SustainPeakMaxTime = 8
	IntensityRelaxThreshold = 0.95
	RelaxMinInterval = 15
	RelaxMaxInterval = 30
	RelaxMaxFlowTravel = 2000
	SmokerLimit = 2
	HunterLimit = 3
	ChargerLimit = 0
	BoomerLimit = 0
	SpecialRespawnInterval = 45.0
	ZombieSpawnRange = 2300
	NumReservedWanderers = 10
}

Director.ResetMobTimer()