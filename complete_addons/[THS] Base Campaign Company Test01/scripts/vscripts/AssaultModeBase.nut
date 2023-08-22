/* Assault Mode Script File. Created by THS inc 2023 and Ivan Suvorov. */

printl("Assault Gamemode Created by Ivan Suvorov and THS inc 2023");
printl("Assault Gamemode Created by Ivan Suvorov and THS inc 2023");
printl("Assault Gamemode Created by Ivan Suvorov and THS inc 2023");

MutationOptions <-
{
	// Get default items for survivors
	DefaultItems =
	[
		"weapon_pistol_magnum"
	]

	function GetDefaultItem( idx )
    {
		if ( idx < DefaultItems.len() )
        {
            printl("Added Assault Mode Spawn Weapon - " + DefaultItems[idx])
			return DefaultItems[idx]
		}
		return 0
	}
}

MutationState <-
{
    CurrentStage = -1
}

const TASK_HUD_NAME = "AssaultTasks";
const TASK_HEADER = "Assault Task:";
const TASK_DESCRIPTION_HEADER = "Desctiption:";

function IV_Simple_Add_Task_HUD_Panel(panel_data)
{
	ModeHUD <-
	{
        Fields =
        {
			gamename = { slot = HUD_MID_TOP, name = TASK_HUD_NAME, dataval = panel_data }
        }
	}

	// load the ModeHUD table
	HUDSetLayout( ModeHUD )
}

function SetupModeHUD( )
{
    IV_Simple_Add_Task_HUD_Panel(TASK_HEADER + " None; " + TASK_DESCRIPTION_HEADER + " None");
}

function OnGameEvent_round_start_post_nav( params )
{
    printl("Assault Gamemode Area Inited!!!");
}

function OnGameEvent_player_spawn( params )
{
    local player = GetPlayerFromUserID( params["userid"] );

    printl("Spawned Assault Mode Player - " + player.GetName());
}

IV_STAGE_MAIN_ACTION <- 0;
IV_STAGE_ESCAPE <- 1;
IV_STAGE_FINALE_END <- 2;

IV_DIRECTOR_MAIN <- null;
IV_TRIGGER_FINALE <- null;

function IV_SET_Director_Object(director_object)
{
    if(director_object == null)
    {
        printl("Sended 'NULL' Director Object!!!")
        return;
    }

    IV_DIRECTOR_MAIN <- director_object.GetName();

    printl("Sended Director Object - '" + IV_DIRECTOR_MAIN + "'");
}

function IV_SET_TGFinale_Object(tgfinale_object)
{
    if(tgfinale_object == null)
    {
        printl("Sended 'NULL' TGFinale Object!!!")
        return;
    }

    IV_TRIGGER_FINALE <- tgfinale_object.GetName();

    printl("Sended TGFinale Object - '" + IV_TRIGGER_FINALE + "'");
}

IV_MAP_TASK_INDEX <- -1;
IV_MAP_TASKS_LIST <- null;

function IV_Update_Assault_Task()
{
    IV_MAP_TASK_INDEX++;
    IV_Check_Assault_Task();
}

function IV_Check_Assault_Task()
{
    if(IV_MAP_TASKS_LIST == null || IV_MAP_TASKS_LIST[0] == null)
    {
        if(developer())
        printl("Assault Task Hud Returned 'NULL' at Function - 'IV_Check_Assault_Task'");
        return;
    }

    printl("Checked Assault Mode Task - '" + IV_MAP_TASKS_LIST[IV_MAP_TASK_INDEX][0] + "'");

    IV_Simple_Add_Task_HUD_Panel(TASK_HEADER + " " + IV_MAP_TASKS_LIST[IV_MAP_TASK_INDEX][0] + "; " + TASK_DESCRIPTION_HEADER + " " + IV_MAP_TASKS_LIST[IV_MAP_TASK_INDEX][1]);
}

function IV_ADD_Tasks_List(tasks_table)
{
    IV_MAP_TASKS_LIST <- tasks_table;
    IV_MAP_TASK_INDEX = 0;

    foreach(idx, value in IV_MAP_TASKS_LIST)
    {
        printl("Checked Assault Mode Task - '" + value[0] + "'")
    }

    IV_Check_Assault_Task();
}

function GetNextStage()
{
    if(SessionState.CurrentStage < 0)
    SessionState.CurrentStage++;

    if(developer())
    printl("Assault Mode Next Stage - " + SessionState.CurrentStage)
    switch ( SessionState.CurrentStage )
    {
        case IV_STAGE_MAIN_ACTION:
        SessionOptions.ScriptedStageType = STAGE_SETUP;
        SessionOptions.ScriptedStageValue = 3;
        break;
        case IV_STAGE_ESCAPE:
        if(IV_TRIGGER_FINALE != null)
        SessionOptions.ScriptedStageType = STAGE_ESCAPE;
        else
        SessionOptions.ScriptedStageType = STAGE_RESULTS;
        break;
    }
}

function IV_Check_Round_Final()
{
    EntFire(IV_TRIGGER_FINALE, "Trigger");
}

function IV_Advance_Stage()
{
    printl("Used Advance State Funcrion!!!");

    if((SessionState.CurrentStage + 1) != IV_STAGE_FINALE_END)
    SessionState.CurrentStage++;
    else
    IV_Check_Round_Final();
}
