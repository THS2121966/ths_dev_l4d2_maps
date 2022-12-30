//-----------------------------------------------------------------------------

PANIC <- 0
TANK <- 1
DELAY <- 2
CUSTOM <- 3

//-----------------------------------------------------------------------------

IV_MAP_FINALE_STAGES_SIMPLE <- 5
IV_MAP_MAX_FINALE_STAGES <- 9

IV_MAP_PRE_SCAVENGE_DELAY <- 20
IV_MAP_PRE_FINAL_DELAY <- 15

IV_FINALE_5_CHECKED_DELAY <- IV_MAP_PRE_FINAL_DELAY
IV_IS_SIMPLE_FINALE <- true

IV_SURVIVORS_COUNT <- 0

function IV_Check_Survivors_Count()
{
    IV_SURVIVORS_COUNT = 0;

    local player = null
    while( player = Entities.FindByClassname(player, "player") )
    {
        IV_SURVIVORS_COUNT++;
        printl( player.GetModelName() );
    }
}

IV_DIRECTOR_ENTITY_NAME <- "@Director"
local difficulty = Convars.GetStr( "z_difficulty" ).tolower();

function IV_Check_GameMode(gamemode)
{
    IV_Check_Survivors_Count();

    if(gamemode == "versus")
    {
        IV_FINALE_5_CHECKED_DELAY = IV_MAP_PRE_FINAL_DELAY;
        IV_IS_SIMPLE_FINALE = true;
		difficulty = "normal";
    }
    else
    {
        if(IV_SURVIVORS_COUNT < 3)
        {
            return;
        }

        IV_IS_SIMPLE_FINALE = false;
        IV_FINALE_5_CHECKED_DELAY = IV_MAP_PRE_SCAVENGE_DELAY;
		EntFire(IV_DIRECTOR_ENTITY_NAME, "AddOutput", "OnTeamScored " + IV_DIRECTOR_ENTITY_NAME + ":RunScriptCode:DirectorScript.MapScript.LocalScript.GasCanPoured():0:-1", 0);
    }
}

GameMode <- Director.GetGameModeBase()

IV_Check_GameMode(GameMode);

SharedOptions <-
{
	A_CustomFinale_StageCount = IV_MAP_FINALE_STAGES_SIMPLE

 	A_CustomFinale1 = PANIC
	A_CustomFinaleValue1 = 1

 	A_CustomFinale2 = PANIC
	A_CustomFinaleValue2 = 1

	A_CustomFinale3 = DELAY
	A_CustomFinaleValue3 = 15

	A_CustomFinale4 = TANK
	A_CustomFinaleValue4 = 1

	A_CustomFinale5 = DELAY
	A_CustomFinaleValue5 = IV_FINALE_5_CHECKED_DELAY

	PreferredMobDirection = SPAWN_LARGE_VOLUME
	PreferredSpecialDirection = SPAWN_LARGE_VOLUME
	ShouldConstrainLargeVolumeSpawn = false

	ZombieSpawnRange = 3000

	SpecialRespawnInterval = 20
}

function IV_ADD_Specials_Final_Sages()
{
	SharedOptions.A_CustomFinale_StageCount = IV_MAP_MAX_FINALE_STAGES;
    SharedOptions.A_CustomFinale6 <- CUSTOM;
	SharedOptions.A_CustomFinaleValue6 <- "l4d_rails_survival_mission_scavenge";

	SharedOptions.A_CustomFinale7 <- DELAY;
	SharedOptions.A_CustomFinaleValue7 <- 10;

	SharedOptions.A_CustomFinale8 <- TANK;
	SharedOptions.A_CustomFinaleValue8 <- 1;
	//SharedOptions.A_CustomFinaleMusic8 <- "";

	SharedOptions.A_CustomFinale9 <- DELAY;
	SharedOptions.A_CustomFinaleValue9 <- IV_MAP_PRE_FINAL_DELAY;
}

if(!IV_IS_SIMPLE_FINALE)
{
    IV_ADD_Specials_Final_Sages();
}

InitialPanicOptions <-
{
	ShouldConstrainLargeVolumeSpawn = true
}


PanicOptions <-
{
	CommonLimit = 25
}

TankOptions <-
{
	ShouldAllowSpecialsWithTank = true
	SpecialRespawnInterval = 30
}


DirectorOptions <- clone SharedOptions
{
}

//-----------------------------------------------------------------------------

function AddTableToTable( dest, src )
{
	foreach( key, val in src )
	{
		dest[key] <- val
	}
}

//-----------------------------------------------------------------------------

IV_GAS_CANS_NEEDED_TO_END <- 7
IV_GAS_CANS_ADVANCED <- IV_GAS_CANS_NEEDED_TO_END + 3

IV_TEMPLATE_SCVNG_GENERATOR_SPAWN_NAME <- "template_scavenge_generator"

IV_EXTRA_SPAWN_POINTS_G01_NAME <-
{
	Extra_Spawn_Logic_Inited = false

	Points_Names = "@ExtraFinalZTarget_G_01"
	Spawn_Area_Name = "@ExtraFinalZTarget_G_01_Safe_Area"

	Points = null
	Area = null
}

function IV_Realise_Points_Table()
{
	local founded_points = [];

	local last_point = null;
	while (last_point = Entities.FindByName(last_point, IV_EXTRA_SPAWN_POINTS_G01_NAME.Points_Names))
	{
		if(developer())
		printl("Checked point - " + last_point.GetName());

		founded_points.append(last_point);
	}

	IV_EXTRA_SPAWN_POINTS_G01_NAME.Points <- founded_points;
	IV_EXTRA_SPAWN_POINTS_G01_NAME.Area <- Entities.FindByName(null, IV_EXTRA_SPAWN_POINTS_G01_NAME.Spawn_Area_Name);

	if(IV_EXTRA_SPAWN_POINTS_G01_NAME.Points != null && IV_EXTRA_SPAWN_POINTS_G01_NAME.Points[0] != null && IV_EXTRA_SPAWN_POINTS_G01_NAME.Area != null)
	{
		DoEntFire( "!self", "AddOutput", "OnEntireTeamStartTouch " + IV_DIRECTOR_ENTITY_NAME +
		":RunScriptCode:DirectorScript.MapScript.LocalScript.IV_ADD_EXTRA_AREA_01_SURVIVOR():0:-1", 0, null, IV_EXTRA_SPAWN_POINTS_G01_NAME.Area );
		DoEntFire( "!self", "AddOutput", "OnEntireTeamEndTouch " + IV_DIRECTOR_ENTITY_NAME +
		":RunScriptCode:DirectorScript.MapScript.LocalScript.IV_REMOVE_EXTRA_AREA_01_SURVIVOR():0:-1", 0, null, IV_EXTRA_SPAWN_POINTS_G01_NAME.Area );
		IV_EXTRA_SPAWN_POINTS_G01_NAME.Extra_Spawn_Logic_Inited = true;
	}
	else
	printl("No Active Extra Spawn Points or Spawn Area Founded!!! Aborting...");
}

IV_Realise_Points_Table();

function IV_Check_Hard_Greater_Scenario(diff)
{
	if(developer())
	printl(difficulty);

	if(diff == "hard" || diff == "impossible")
	return true;

	return false;
}

local IV_SURVIVORS_EXTRA_AREA_01_TOUCHED = 0

function IV_ADD_EXTRA_AREA_01_SURVIVOR()
{
	IV_SURVIVORS_EXTRA_AREA_01_TOUCHED++;

	if(developer())
	printl("Added Survuvor in Extra Area01");
}

function IV_REMOVE_EXTRA_AREA_01_SURVIVOR()
{
	IV_SURVIVORS_EXTRA_AREA_01_TOUCHED--;

	if(developer())
	printl("Removed Survuvor in Extra Area01");
}

function IV_Check_Survivors_Extra_Area_01_State()
{
	if(IV_SURVIVORS_EXTRA_AREA_01_TOUCHED > 0)
	return true;

	return false;
}

function IV_Realise_More_Tanks_Scenario()
{
	if(!IV_EXTRA_SPAWN_POINTS_G01_NAME.Extra_Spawn_Logic_Inited)
	return;

	local tanks_spawner_array = []

	foreach ( checked_point in IV_EXTRA_SPAWN_POINTS_G01_NAME.Points )
	{
		if(developer())
		printl("Checked '" + checked_point.GetName() + "' Target");

		local origin = checked_point.GetOrigin();
		local angles = checked_point.GetAngles();

		local kvs =
		{
			origin = origin.ToKVString()
			angles = angles.ToKVString()
			targetname = "@ExtraTankSpawner"
		}

		local spawner = SpawnEntityFromTable( "commentary_zombie_spawner", kvs );

		if(developer())
		printl("Spawned '" + spawner.GetName() + "' Extra Tank Spawn Position");

		tanks_spawner_array.append(spawner);
	}

	if(!IV_Check_Survivors_Extra_Area_01_State())
	{
		local extra_tanks_count = 0;

		foreach ( checked_spawner in tanks_spawner_array )
		{
			DoEntFire( "!self", "SpawnZombie", "Tank", 0, null, checked_spawner );
			extra_tanks_count++;
			printl("Spawned Tank On Extra Slot!!! Extra Tanks Count = " + extra_tanks_count + "");
		}
	}
}

function OnBeginCustomFinaleStage( num, type )
{
	if ( developer() > 0 )
	{
		printl("========================================================");
		printl( "Beginning custom finale stage " + num + " of type " + type );
	}

	local waveOptions = null
	if ( num == 1 )
	{
		waveOptions = InitialPanicOptions
	}
	else if ( type == PANIC )
	{
		waveOptions = PanicOptions
		if ( "MegaMobMinSize" in PanicOptions )
		{
			waveOptions.MegaMobSize <- RandomInt( PanicOptions.MegaMobMinSize, MegaMobMaxSize )
		}
	}
	else if ( type == TANK )
	{
		waveOptions = TankOptions
	}

	//---------------------------------

	if(type == CUSTOM)
	{
		EntFire(IV_DIRECTOR_ENTITY_NAME, "FireUser1", "", 0)

		if(IV_Check_Hard_Greater_Scenario(difficulty))
		{
			EntFire(IV_TEMPLATE_SCVNG_GENERATOR_SPAWN_NAME, "AddOutput", "OnEntitySpawned " + IV_DIRECTOR_ENTITY_NAME +
			":RunScriptCode:DirectorScript.MapScript.LocalScript.IV_Advance_Scavenge_Mode():0.1:-1", 0);

			EntFire( "scavenge_display", "SetTotalItems", IV_GAS_CANS_ADVANCED );

			IV_GAS_CANS_NEEDED_TO_END = IV_GAS_CANS_ADVANCED;
		}
	}

	if(num == SharedOptions.A_CustomFinale_StageCount + 1 && IV_Check_Hard_Greater_Scenario(difficulty))
	{
		IV_Realise_More_Tanks_Scenario();
	}

	MapScript.DirectorOptions.clear()

	AddTableToTable( MapScript.DirectorOptions, SharedOptions );

	if ( waveOptions != null )
	{
		AddTableToTable( MapScript.DirectorOptions, waveOptions );
	}

	//---------------------------------

	if ( developer() > 0 )
	{
		Msg( "\n*****\nMapScript.DirectorOptions:\n" );
		foreach( key, value in MapScript.DirectorOptions )
		{
			Msg( "    " + key + " = " + value + "\n" );
		}

		if ( LocalScript.rawin( "DirectorOptions" ) )
		{
			Msg( "\n*****\nLocalScript.DirectorOptions:\n" );
			foreach( key, value in LocalScript.DirectorOptions )
			{
				Msg( "    " + key + " = " + value + "\n" );
			}
		}
		printl("========================================================");
	}
}

function IV_Advance_Scavenge_Mode()
{
	local check_array = 3;
	local spawn_witch = true;
	local ent_gascan = null;

	while (ent_gascan = Entities.FindByName(ent_gascan, "scavenge_gascan_spawn_hardmode"))
	{
		if(check_array == 0)
		break;

		if(developer())
		printl(ent_gascan.GetName());

		DoEntFire( "!self", "SpawnItem", "", 0, null, ent_gascan );
		DoEntFire( "!self", "TurnGlowsOn", "", 0.1, null, ent_gascan );
		check_array--;

		if(spawn_witch)
		{
			spawn_witch = false;

			local witch_spawner = Entities.FindByName(null, "witch_hardmode_spawner");

			if(witch_spawner)
			{
				EntFire("witch_hardmode_spawner_spawn_fx", "Start", "", 0);
				DoEntFire("!self", "SpawnZombie", "Witch", 0, null, witch_spawner);
			}
			else
			printl("Failed to Spawn Scavenge Witch!!!");
		}
	}
}

IV_GAS_CANS_POUNDED <- 0

function GasCanPoured()
{
	IV_GAS_CANS_POUNDED++;

	if ( developer() > 0 )
		Msg(" Poured: " + IV_GAS_CANS_POUNDED + "\n");

	if(IV_GAS_CANS_POUNDED == IV_GAS_CANS_NEEDED_TO_END - 1)
	{
		EntFire(IV_DIRECTOR_ENTITY_NAME, "FireUser2", "", 0);
	}
	else if ( IV_GAS_CANS_POUNDED == IV_GAS_CANS_NEEDED_TO_END )
	{
		if ( developer() > 0 )
			Msg(" needed: " + IV_GAS_CANS_NEEDED_TO_END + "\n");

		EntFire(IV_DIRECTOR_ENTITY_NAME, "FireUser3", "", 0);
		EntFire(IV_DIRECTOR_ENTITY_NAME, "EndCustomScriptedStage", "", 5);
	}
}