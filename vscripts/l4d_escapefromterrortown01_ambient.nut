Msg("Initiating Tower Ambient...\n");

if(!IncludeScript("IVScriptEngineBase/iv_players_manager.nut"))
{
    printl("Failed to Load Players Manager!!! Using Default Director Settings...");
    //return;
}

g_players_manager <- IV_Players_Manager(true);

DirectorOptions <-
{
	AlwaysAllowWanderers = true,
	MobSpawnMinTime = 120,
	MobSpawnMaxTime = 180,
	MobMinSize = 15,
	MobMaxSize = 30,
	MobMaxPending = 12,
	SustainPeakMinTime = 5,
	SustainPeakMaxTime = 8,
	IntensityRelaxThreshold = 0.95,
	RelaxMinInterval = 15,
	RelaxMaxInterval = 30,
	RelaxMaxFlowTravel = 3000,
	SmokerLimit = 1,
	HunterLimit = 3,
	ChargerLimit = 0,
	SpitterLimit = 0,
	BoomerLimit = 1,
	JockeyLimit = 0,
	SpecialRespawnInterval = 45.0,
	ZombieSpawnRange = 3000,
	NumReservedWanderers = 10,

	TankLimit = 0,
	WitchLimit = 2
}

if(g_game_difficulty == "hard" || g_game_difficulty == "impossible")
{
	DirectorOptions.HunterLimit = 2;
	DirectorOptions.SmokerLimit = 2;
	DirectorOptions.ChargerLimit = 1;
	DirectorOptions.BoomerLimit = 2;

	DirectorOptions.MobMinSize = 30;
	DirectorOptions.MobMaxSize = 42;

	DirectorOptions.MobSpawnMinTime = 80;
	DirectorOptions.MobSpawnMaxTime = 120;

	DirectorOptions.SpecialRespawnInterval = 30;

	DirectorOptions.NumReservedWanderers = 5;

	DirectorOptions.TankLimit += 1;
	DirectorOptions.WitchLimit += 1;
}

Director.ResetMobTimer();