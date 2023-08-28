/* Assault Mode Script File. Created by THS inc 2023 and Ivan Suvorov. */

function IV_Map_Advance_Stage()
{
    printl("Called AS Manage Fuction - 'IV_Map_Advance_Stage'");

    g_ModeScript.IV_Advance_Stage();
}

IV_DIRECTOR_ENT_LINK <- EntityGroup[0];
IV_TGFINALE_ENT_LINK <- EntityGroup[1];
IV_RELAY_INTRO_SKIP_ENT_LINK <- EntityGroup[2];

IV_TGHARDMODE_ENT_LINK <- EntityGroup[3];

IV_INTRO_SHOWED <- false;

function IV_Map_Update_Assault_Task()
{
    g_ModeScript.IV_Update_Assault_Task();
}

local iv_mode_save_restore_parms_default =
{
    intro_checked_once = false,
    spawned_extra_survivor = false,

    data_restored = false
};

local iv_mode_save_restore_parms =
{
    intro_checked_once = false,
    spawned_extra_survivor = false,

    data_restored = false
};

function IV_Clearup_Extra_Survivors()
{
    if(Director.GetSurvivorSet() == 1)
    {
        EntFire("!nick", "Kill");
        EntFire("!coach", "Kill");
        EntFire("!ellis", "Kill");
        EntFire("!rochelle", "Kill");
    }
    else
    {
        EntFire("!bill", "Kill");
        EntFire("!louis", "Kill");
        EntFire("!zoey", "Kill");
        EntFire("!francis", "Kill");
    }

    printl("Cleared Last Extra Survivors!!!");
    printl("Cleared Last Extra Survivors!!!");
    printl("Cleared Last Extra Survivors!!!");
}

function OnGameEvent_round_start_post_nav(params)
{
    g_ModeScript.IV_SET_Director_Object(IV_DIRECTOR_ENT_LINK);
    g_ModeScript.IV_SET_TGFinale_Object(IV_TGFINALE_ENT_LINK);
    g_ModeScript.IV_SET_TGHARDMODE_Object(IV_TGHARDMODE_ENT_LINK);

    local data_saved_name = "IV_MODE_DATA_SAVED";

    printl("Starting Restore 'IV_MODE_DATA_SAVED' Table");

    RestoreTable( data_saved_name, iv_mode_save_restore_parms );

    if(iv_mode_save_restore_parms.spawned_extra_survivor)
    {
        IV_Clearup_Extra_Survivors();

        iv_mode_save_restore_parms.spawned_extra_survivor = false;
        SaveTable( data_saved_name, iv_mode_save_restore_parms );
    }

    if(!iv_mode_save_restore_parms.data_restored)
    {
        iv_mode_save_restore_parms.intro_checked_once = true;
        iv_mode_save_restore_parms.data_restored = true;

        printl("Saving 'IV_MODE_DATA_SAVED' Table");
        SaveTable( data_saved_name, iv_mode_save_restore_parms );
    }
    else
    {
        IV_INTRO_SHOWED = iv_mode_save_restore_parms.intro_checked_once;
        SaveTable( data_saved_name, iv_mode_save_restore_parms );
    }

    if(IV_INTRO_SHOWED)
    EntFire(IV_RELAY_INTRO_SKIP_ENT_LINK.GetName(), "Trigger");

    if(IV_INTRO_SHOWED == false)
    printl("Intro Show State = 'FALSE'");
    else
    printl("Intro Show State = 'TRUE'");

    g_ModeScript.IV_Add_Shutdown_Func(OnShutdown);

    printl("Assault Gamemode Manager Parms Inited!!!");
    printl("Assault Gamemode Manager Parms Inited!!!");
    printl("Assault Gamemode Manager Parms Inited!!!");
}

function IV_Spawn_Extra_Survivor(scenario_index, hardmode_check = 1)
{
    local spawn_next_state = hardmode_check >= 1;
    if(spawn_next_state)
    {
        local difficulty = Convars.GetStr( "z_difficulty" ).tolower();
        spawn_next_state = difficulty == "hard" || difficulty == "impossible";

        if(!spawn_next_state)
        return;
    }

    if(!SessionState.ExtraSurvivorsMode)
    {
        printl("Extra Survivor Mode Not Setted!!! Failed to Spawn Extra Survivor!!!");
        printl("Extra Survivor Mode Not Setted!!! Failed to Spawn Extra Survivor!!!");
        printl("Extra Survivor Mode Not Setted!!! Failed to Spawn Extra Survivor!!!");
        return;
    }

    if(!SessionState.ExtraSurvivorsPrecached)
    {
        printl("Extra Survivor Mode Setted BUT Models Not Precached!!! Failed to Spawn Extra Survivor!!!");
        printl("Extra Survivor Mode Setted BUT Models Not Precached!!! Failed to Spawn Extra Survivor!!!");
        printl("Extra Survivor Mode Setted BUT Models Not Precached!!! Failed to Spawn Extra Survivor!!!");
        return;
    }

    g_ModeScript.IV_Set_Extra_Survivor_Scenario(scenario_index);

    EntFire(IV_TGHARDMODE_ENT_LINK.GetName(), "Trigger");
    SessionState.ExtraSurvivorsSpawned = true;

    local data_saved_name = "IV_MODE_DATA_SAVED";
    iv_mode_save_restore_parms.spawned_extra_survivor = true;
    SaveTable( data_saved_name, iv_mode_save_restore_parms );
}

function OnShutdown()
{
    if(developer())
    printl("Assault GM Manager Shutdown Reason - '" + SessionState.ShutdownReason + "'");

    if ( SessionState.ShutdownReason != SCRIPT_SHUTDOWN_ROUND_RESTART && SessionState.ShutdownReason != SCRIPT_SHUTDOWN_TEAM_SWAP )
    {
        printl("Saving 'IV_MODE_DATA_SAVED' Table");
        local data_saved_name = "IV_MODE_DATA_SAVED";
        SaveTable( data_saved_name, iv_mode_save_restore_parms_default );
    }

    printl("Used 'OnShutdown()' Function in GMManager!!!");
}

