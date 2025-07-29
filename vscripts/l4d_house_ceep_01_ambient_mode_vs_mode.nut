/*Maded by Ivan Suvorov in 2025*/
/*Director Script. First Map Start Ambient Mode.*/

Msg("[Ivan Suvorov] Initiating House Ambient (Versus Mode) Scenario!!!\n");

DirectorOptions <-
{
	ProhibitBosses = false
	CommonLimit = 18

	AlwaysAllowWanderers = true
	MobSpawnMinTime = 60
	MobSpawnMaxTime = 90
	MobMinSize = 15
	MobMaxSize = 20
	MobMaxPending = 20
	SustainPeakMinTime = 5
	SustainPeakMaxTime = 8
	IntensityRelaxThreshold = 0.95
	RelaxMinInterval = 15
	RelaxMaxInterval = 30
	RelaxMaxFlowTravel = 2000
	SmokerLimit = 0
	HunterLimit = 0
	ChargerLimit = 0
	JockeyLimit = 0
	SpitterLimit = 0
	BoomerLimit = 1
	TankLimit = 0
	WitchLimit = 3
	ZombieSpawnRange = 2000
	NumReservedWanderers = 10
}
