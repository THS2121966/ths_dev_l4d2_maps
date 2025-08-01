/*Maded by Ivan Suvorov in 2025*/
/*Director Script. Map Scavenge COOP Mode.*/

Msg("[Ivan Suvorov] Initiating House Scavenge (COOP) Scenario!!!\n");

//IV Note: Map Constants
IV_DIRECTOR_ENTITY_NAME <- "@Director"
IV_SCV_MODE_GASCANS_DISPLAY_NAME <- "scv_mode_display"
IV_SCV_MODE_MATH_COUNTER_NAME <- "math_scv_mode_gascans_counter"
IV_SCV_MODE_END_RELAY_NAME <- "relay_scv_mode_end"
IV_MAX_MAP_SCV_MODE_GASCANS <- 5

local total_items_to_collect = 3
local collected_items = 0

local GameMode = Director.GetGameModeBase()
local difficulty = Convars.GetStr("z_difficulty").tolower();

DirectorOptions <-
{
	CommonLimit = 8
	MobSpawnMinTime = 8
	MobSpawnMaxTime = 12
	MobSpawnSize = 5
	MobMaxPending = 10
	MusicDynamicMobSpawnSize = 8
	MusicDynamicMobStopSize = 4
	IntensityRelaxThreshold = 1.1
	RelaxMinInterval = 5
	RelaxMaxInterval = 8
	SustainPeakMinTime = 10
	SustainPeakMaxTime = 15
	SpecialRespawnInterval = 30
	LockTempo = false
	PreferredMobDirection = SPAWN_ANYWHERE
	PanicForever = true

	//IV Note: SI Spawn Rules
	SmokerLimit = 0
	HunterLimit = 0
	ChargerLimit = 0
	JockeyLimit = 0
	SpitterLimit = 1
	BoomerLimit = 1
	TankLimit = 0
	WitchLimit = 0
}

if(difficulty != "easy")
	DirectorOptions.SpecialRespawnInterval = 25;

function IV_Pre_Setup_Scavenge_Mode()
{
    if(GameMode == "versus")
    {
		difficulty = "normal";
		total_items_to_collect = IV_MAX_MAP_SCV_MODE_GASCANS;
    }
    else
    {
		if(difficulty != "easy")
			total_items_to_collect = IV_MAX_MAP_SCV_MODE_GASCANS;
		else
			total_items_to_collect = 3;
    }
}

function IV_Realise_Scavenge_Mode()
{
	EntFire(IV_SCV_MODE_MATH_COUNTER_NAME, "SetHitMax", total_items_to_collect);
	EntFire(IV_SCV_MODE_GASCANS_DISPLAY_NAME, "SetTotalItems", total_items_to_collect);
	EntFire(IV_DIRECTOR_ENTITY_NAME, "AddOutput", "OnTeamScored " + IV_DIRECTOR_ENTITY_NAME +
	":RunScriptCode:DirectorScript.MapScript.LocalScript.IV_Game_Event_Gascan_Poured():0:-1", 0);
}

function IV_Game_Event_Gascan_Poured()
{
	collected_items++;

	printl("[IV Script] [Scavenge Mode] Collected (" + collected_items + ")/(" + total_items_to_collect + ") Gascans");

	DirectorOptions.CommonLimit += collected_items;
	DirectorOptions.MobSpawnSize += collected_items;
	DirectorOptions.MobSpawnMinTime -= collected_items;
	DirectorOptions.MobSpawnMaxTime -= collected_items;

	if(collected_items < total_items_to_collect)
		return;
	
	if(collected_items > total_items_to_collect)
		error("Collected Items Greater than Total Items to Collect!!! Tell a Programmer!!!");
	
	Msg("[IV Script] [Scavenge Mode] All Gascans was Poured!!! Returning in Normal Mode...");
}

IV_Pre_Setup_Scavenge_Mode();
IV_Realise_Scavenge_Mode();

Director.ResetMobTimer();
Director.PlayMegaMobWarningSounds();
