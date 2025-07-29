/*Maded by Ivan Suvorov in 2025*/
/*Director Script. Map Scavenge COOP Mode.*/

Msg("[Ivan Suvorov] Initiating House Scavenge (COOP) Scenario!!!\n");

//IV Note: Map Constants
IV_DIRECTOR_ENTITY_NAME <- "@Director"
IV_ORATOR_ENT <- Entities.FindByClassname(null, "func_orator")
IV_SCV_MODE_GASCANS_DISPLAY_NAME <- "scv_mode_display"
IV_SCV_MODE_END_RELAY_NAME <- "relay_scv_mode_end"
IV_SCV_MODE_MAIN_GASCANS_GROUP_NAME <- "underfloor_generator_gascan_m_01"
IV_MAX_MAP_SCV_MODE_GASCANS <- 5

local total_items_to_collect = 3
local collected_items = 0

local GameMode = Director.GetGameModeBase()
local difficulty = Convars.GetStr("z_difficulty").tolower();

DirectorOptions <-
{
	ProhibitBosses = false
	CommonLimit = 8

	AlwaysAllowWanderers = false
	MobSpawnMinTime = 3
	MobSpawnMaxTime = 5
	MobMinSize = 1
	MobMaxSize = 3
	MobMaxPending = 5
	SustainPeakMinTime = 5
	SustainPeakMaxTime = 8
	IntensityRelaxThreshold = 0.95
	RelaxMinInterval = 1
	RelaxMaxInterval = 3
	RelaxMaxFlowTravel = 1800
	SmokerLimit = 0
	HunterLimit = 0
	ChargerLimit = 0
	JockeyLimit = 0
	SpitterLimit = 1
	BoomerLimit = 1
	TankLimit = 0
	WitchLimit = 0
	SpecialRespawnInterval = 35
	ZombieSpawnRange = 1800
	NumReservedWanderers = 2

function GasCanPoured()
{
	collected_items++;
	printl("[IV] [Scavenge Mode] Collected - (" + collected_items + ")/(" + total_items_to_collect + ")");

	if(collected_items < total_items_to_collect)
		return;

	printl("[IV] [Scavenge Mode] Collected All of Needed Gascans!!! Ending Scavenge Mode...");
	EntFire(IV_SCV_MODE_END_RELAY_NAME, "Trigger");
	printl("[IV] [Scavenge Mode] Ending Scavenge Mode Done!!!");
}
}

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
	EntFire(IV_DIRECTOR_ENTITY_NAME, "AddOutput", "OnTeamScored " + IV_DIRECTOR_ENTITY_NAME + ":RunScriptCode:DirectorScript.MapScript.LocalScript.DirectorOptions.GasCanPoured():0:-1", 0);
	EntFire(IV_SCV_MODE_GASCANS_DISPLAY_NAME, "SetTotalItems", total_items_to_collect);
}

IV_Pre_Setup_Scavenge_Mode();
IV_Realise_Scavenge_Mode();

Director.ResetMobTimer();