/* Assault Mode Script File. Created by THS inc 2023 and Ivan Suvorov. */

printl("Assault Gamemode Created by Ivan Suvorov and THS inc 2023");
printl("Assault Gamemode Created by Ivan Suvorov and THS inc 2023");
printl("Assault Gamemode Created by Ivan Suvorov and THS inc 2023");

MutationOptions <-
{
	// Get default items for survivors
	DefaultItems =
	[
		"weapon_pistol_magnum",
        "weapon_rifle",
        "weapon_first_aid_kit"
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

	function EndScriptedMode()
	{
    	if(developer())
    	{
	        printl("Currient Final Result Index - " + SessionState.FinalMapState)
	        printl("Currient Final Result Index - " + SessionState.FinalMapState)
	        printl("Currient Final Result Index - " + SessionState.FinalMapState)
	    }

	    return SessionState.FinalMapState;
	}

    /* IV Note: AI Options */
    cm_AggressiveSpecials = false
    cm_AllowPillConversion = true
    cm_MaxSpecials = 5
}

MutationState <-
{
    CurrentStage = -1,
    FinalMapState = 1,

    ExtraSurvivorsPrecached = false,
    ExtraSurvivorsMode = false,
    ExtraSurvivorsSpawned = false
}

const TASK_HUD_NAME = "AssaultTasks";
const TASK_HEADER = "Assault Task:";
const TASK_DESCRIPTION_HEADER = "Desctiption:";

AssaultModeHUD <-
{
    Fields =
    {
        taskname = { slot = HUD_MID_TOP, name = TASK_HUD_NAME, dataval = "", flags = HUD_FLAG_ALIGN_LEFT }
    }
}

function IV_Init_Task_HUD_Panel(panel_data)
{
	if(IV_MAP_TASK_INDEX < 0)
    AssaultModeHUD.Fields["taskname"].dataval = panel_data;

	// load the AssaultModeHUD table
	HUDSetLayout( AssaultModeHUD );
    HUDPlace(HUD_MID_TOP, 0.25, 0.04, 0.5, 0.1);
}

function SetupModeHUD( )
{
    IV_Init_Task_HUD_Panel(TASK_HEADER + " None; " + TASK_DESCRIPTION_HEADER + " None");
}

function IV_Simple_Add_Task_HUD_Panel(panel_data)
{
    AssaultModeHUD.Fields["taskname"].dataval = panel_data;
}

function OnGameEvent_round_start_post_nav( params )
{
    if(developer())
    {
        printl("Currient Mutation Options:");
        printl("=============================================================");
        foreach (indx, val in MutationOptions )
        {
            printl("[" + (indx + 1) + "] " + val);
        }
        printl("=============================================================");

        printl("Currient Director Options:");
        printl("=============================================================");
        foreach (indx, val in DirectorOptions )
        {
            printl("[" + (indx + 1) + "] " + val);
        }
        printl("=============================================================");
    }

    if(developer())
    {
        IV_Init_Developer_ConVars();
    }

    printl("Assault Gamemode Area Inited!!!");
}

function IV_Init_Developer_ConVars()
{
    Convars.SetValue("sb_all_bot_game", 1);
    Convars.SetValue("allow_all_bot_survivor_team", 1);
}

const TARGET_EXTRA_NAME = "@targetextrahelper"
const TARGET_EXTRA_SPAWN_PREFIX = "spawn"
const TARGET_EXTRA_EXIT_PREFIX = "exit"

local l_extra_exit_point_move =
{
    L4D1 =
    {
        BILL = TARGET_EXTRA_NAME + TARGET_EXTRA_EXIT_PREFIX + "bill"
        ZOEY = TARGET_EXTRA_NAME + TARGET_EXTRA_EXIT_PREFIX + "zoey"
        LOUIS = TARGET_EXTRA_NAME + TARGET_EXTRA_EXIT_PREFIX + "louis"
        FRANCIS = TARGET_EXTRA_NAME + TARGET_EXTRA_EXIT_PREFIX + "francis"
    }
    L4D2 =
    {
        NICK = TARGET_EXTRA_NAME + TARGET_EXTRA_EXIT_PREFIX + "nick"
        COACH = TARGET_EXTRA_NAME + TARGET_EXTRA_EXIT_PREFIX + "coach"
        ROCHELLE = TARGET_EXTRA_NAME + TARGET_EXTRA_EXIT_PREFIX + "rochelle"
        ELLIS = TARGET_EXTRA_NAME + TARGET_EXTRA_EXIT_PREFIX + "ellis"
    }
}

function IV_Check_Extra_Name(player)
{
    if(Director.GetSurvivorSet() == 1)
    {
        if(IsPlayerABot(player) && player.IsSurvivor() && (player.GetPlayerName().tolower() == "nick" || player.GetPlayerName().tolower() == "coach"
        || player.GetPlayerName().tolower() == "rochelle" || player.GetPlayerName().tolower() == "ellis"))
        return true;
    }
    else
    {
        if(IsPlayerABot(player) && player.IsSurvivor() && (player.GetPlayerName().tolower() == "bill" || player.GetPlayerName().tolower() == "zoey"
        || player.GetPlayerName().tolower() == "louis" || player.GetPlayerName().tolower() == "francis"))
        return true;
    }

    return false;
}

function IV_ExtraBot_Move_Command(checked_bot, vec_move)
{
    if(!IsPlayerABot(checked_bot))
    {
        printl("This player - '" + checked_bot.GetPlayerName() + "' is NOT a BOT!!! Aborting...");
        return;
    }

    local commands =
    {
        bot = checked_bot,
        cmd = DirectorScript.BOT_CMD_MOVE,
        pos = vec_move
    }

    CommandABot( commands );
}

const IV_EXTRA_SURVIVOR_NAME_DEFAULT = "Assault Extra Survivor";

local l_extra_survivors_last_index = 0;
local l_extra_survivors_array =
[
    null,
    null,
    null,
    null
]

function IV_Init_ExtraBot_Spawn_Scenario(player)
{
    local glowColor = 65280;
    if ( player.IsOnThirdStrike() )
        glowColor = 255;

    //SetFakeClientConVarValue( player, "name", IV_EXTRA_SURVIVOR_NAME_DEFAULT + " " + player.GetPlayerName() );
    NetProps.SetPropInt( player, "m_Glow.m_glowColorOverride", glowColor );
    NetProps.SetPropInt( player, "m_Glow.m_iGlowType", 3 );

    if(l_extra_survivors_last_index < 4)
    {
        l_extra_survivors_array[l_extra_survivors_last_index] = player;
        l_extra_survivors_last_index++;
    }
    else
    {
        printl("Failed to Precache Extra Survivor!!! Max Slots Used!!!");
        printl("Failed to Precache Extra Survivor!!! Max Slots Used!!!");
        printl("Failed to Precache Extra Survivor!!! Max Slots Used!!!");
    }

    local tg_name = TARGET_EXTRA_NAME + TARGET_EXTRA_SPAWN_PREFIX + player.GetPlayerName().tolower();
    local target_to_move = Entities.FindByName(null, tg_name);
    if(target_to_move == null)
    {
        printl("Target Spawn Move Check Returned 'NULL'!!! Checked Target Name - '" + tg_name + "'");
        return;
    }

    IV_ExtraBot_Move_Command(player, target_to_move.GetOrigin());
}

function IV_ExtraBot_Scenario_Escape()
{
    foreach (indx, value in l_extra_survivors_array)
    {
        if(value != null)
        {
            if(developer())
            printl("Moving bot - '" + value.GetPlayerName() + "' to Final Point...");

            local tg_name = TARGET_EXTRA_NAME + TARGET_EXTRA_EXIT_PREFIX + value.GetPlayerName().tolower();
            local target_to_move = Entities.FindByName(null, tg_name);
            if(target_to_move == null)
            {
                printl("Target Exit Move Check Returned 'NULL'!!! Checked Target Name - '" + tg_name + "'");
                return;
            }

            IV_ExtraBot_Move_Command(value, target_to_move.GetOrigin());
        }
    }
}

function OnGameEvent_player_spawn( params )
{
    local player = GetPlayerFromUserID( params["userid"] );

    if(SessionState.ExtraSurvivorsSpawned)
    {
        if(IV_Check_Extra_Name(player))
        {
            IV_Init_ExtraBot_Spawn_Scenario(player);
        }
    }

    if(developer())
    {
        printl("Spawned Assault Mode Player - " + player.GetPlayerName());
    }
}



IV_STAGE_MAIN_ACTION <- 0;
IV_STAGE_ESCAPE <- 1;
IV_STAGE_PREPARE_END <- 2;
IV_STAGE_FINALE_END <- 3;

IV_DIRECTOR_MAIN <- null;
IV_TRIGGER_FINALE <- null;

IV_HARDMODE_RELAY <- null;

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

function IV_SET_TGHARDMODE_Object(tghardmode_object)
{
    if(tghardmode_object == null)
    {
        printl("Sended 'NULL' TGHARDMODE Object!!!")
        return;
    }

    IV_HARDMODE_RELAY <- tghardmode_object.GetName();

    IV_Init_Extra_Survivors();

    printl("Sended TGHARDMODE Object - '" + IV_HARDMODE_RELAY + "'");
}

function IV_Set_Extra_Survivor_Scenario(scenario_index)
{
    local index = scenario_index > 1 ? 1 : scenario_index < 0 ? 0 : scenario_index

    Convars.SetValue("sb_l4d1_survivor_behavior", index);
}

function IV_Init_Extra_Survivors()
{
    IV_Precache_Extra_Survivors();

    //Convars.SetValue("sb_l4d1_survivor_behavior", 1);

    SessionState.ExtraSurvivorsMode = true;
}

/* L4D1 Survivors Models Name */
const IV_SURVIVOR_L4D1_BILL_MODEL = "models/survivors/survivor_namvet.mdl";
const IV_SURVIVOR_L4D1_LOUIS_MODEL = "models/survivors/survivor_manager.mdl";
const IV_SURVIVOR_L4D1_ZOEY_MODEL = "models/survivors/survivor_teenangst.mdl";
const IV_SURVIVOR_L4D1_FRANCIS_MODEL = "models/survivors/survivor_biker.mdl";

/* L4D2 Survivors Models Name */
const IV_SURVIVOR_L4D2_NICK_MODEL = "models/survivors/survivor_gambler.mdl";
const IV_SURVIVOR_L4D2_COACH_MODEL = "models/survivors/survivor_coach.mdl";
const IV_SURVIVOR_L4D2_ROCHELLE_MODEL = "models/survivors/survivor_producer.mdl";
const IV_SURVIVOR_L4D2_ELLIS_MODEL = "models/survivors/survivor_mechanic.mdl";

function IV_Precache_Extra_Survivors()
{
    local four_survivors_result =
    [
        false,
        false,
        false,
        false
    ]

    if(Director.GetSurvivorSet() == 1)
    {
        four_survivors_result[0] = IV_Precache_And_Check_Result(IV_SURVIVOR_L4D2_NICK_MODEL);
        four_survivors_result[1] = IV_Precache_And_Check_Result(IV_SURVIVOR_L4D2_COACH_MODEL);
        four_survivors_result[2] = IV_Precache_And_Check_Result(IV_SURVIVOR_L4D2_ROCHELLE_MODEL);
        four_survivors_result[3] = IV_Precache_And_Check_Result(IV_SURVIVOR_L4D2_ELLIS_MODEL);
    }
    else
    {
        four_survivors_result[0] = IV_Precache_And_Check_Result(IV_SURVIVOR_L4D1_BILL_MODEL);
        four_survivors_result[1] = IV_Precache_And_Check_Result(IV_SURVIVOR_L4D1_LOUIS_MODEL);
        four_survivors_result[2] = IV_Precache_And_Check_Result(IV_SURVIVOR_L4D1_ZOEY_MODEL);
        four_survivors_result[3] = IV_Precache_And_Check_Result(IV_SURVIVOR_L4D1_FRANCIS_MODEL);
    }

    SessionState.ExtraSurvivorsPrecached = four_survivors_result[0] && four_survivors_result[1] && four_survivors_result[2] && four_survivors_result[3];
}

function IV_Precache_And_Check_Result(model_name)
{
    local result = false;

    if(!IsModelPrecached(model_name))
    result = PrecacheModel(model_name);
    else
    result = true;

    if(!result)
    printl("Model is NOT Precached!!! Tell a Programmer!!! Model Name - '" + model_name + "'")
    else if(developer())
    printl("Model - '" + model_name + "' Precache state is 'TRUE'");

    return result;
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
    if(SessionState.CurrentStage < 0 || (SessionOptions.ScriptedStageType == STAGE_SETUP && SessionState.CurrentStage == IV_STAGE_PREPARE_END))
    SessionState.CurrentStage++;

    if(developer() && SessionState.CurrentStage == IV_STAGE_ESCAPE)
    printl("Final Escape Stage...");

    if(SessionState.CurrentStage == IV_STAGE_ESCAPE)
    {
        IV_ExtraBot_Scenario_Escape();
    }

    if(developer())
    printl("Assault Mode Next Stage - " + SessionState.CurrentStage)
    switch ( SessionState.CurrentStage )
    {
        case IV_STAGE_MAIN_ACTION:
        SessionOptions.ScriptedStageType = STAGE_NONE;
        break;
        case IV_STAGE_ESCAPE:
        SessionOptions.ScriptedStageType = STAGE_ESCAPE;
        break;
        case IV_STAGE_PREPARE_END:
        SessionOptions.ScriptedStageType = STAGE_SETUP;
        SessionOptions.ScriptedStageValue = 3;
        case IV_STAGE_FINALE_END:
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

    if((SessionState.CurrentStage + 1) != IV_STAGE_PREPARE_END)
    SessionState.CurrentStage++;
    else if(IV_TRIGGER_FINALE != null)
    IV_Check_Round_Final();
    else
    SessionState.CurrentStage++;

    if(IV_TRIGGER_FINALE != null)
    return;

    if((SessionState.CurrentStage + 1) == IV_STAGE_FINALE_END)
    SessionState.FinalMapState = 0;

    if(SessionState.CurrentStage == IV_STAGE_PREPARE_END || SessionState.CurrentStage == IV_STAGE_ESCAPE)
    Director.ForceNextStage();

    if(developer())
    {
        printl("Currient State Options:");
        printl("=============================================================");
        foreach (indx, val in SessionState )
        {
            printl("[" + (indx + 1) + "] " + val);
        }
        printl("=============================================================");
    }
}

