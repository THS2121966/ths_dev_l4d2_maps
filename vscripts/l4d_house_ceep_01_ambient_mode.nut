/*Maded by Ivan Suvorov in 2024*/
/*Director Script. First Map Start Ambient Mode.*/

Msg("[Ivan Suvorov] Initiating House Ambient Scenario!!!\n");

DirectorOptions <-
{
	ProhibitBosses = false
	CommonLimit = 12

	AlwaysAllowWanderers = true
	MobSpawnMinTime = 60
	MobSpawnMaxTime = 90
	MobMinSize = 10
	MobMaxSize = 20
	MobMaxPending = 20
	SustainPeakMinTime = 5
	SustainPeakMaxTime = 8
	IntensityRelaxThreshold = 0.95
	RelaxMinInterval = 15
	RelaxMaxInterval = 30
	RelaxMaxFlowTravel = 2000
	SmokerLimit = 1
	HunterLimit = 2
	ChargerLimit = 0
	JockeyLimit = 0
	SpitterLimit = 0
	TankLimit = 0
	WitchLimit = 3
	SpecialRespawnInterval = 45.0
	ZombieSpawnRange = 2000
	NumReservedWanderers = 10
}

Director.ResetMobTimer()