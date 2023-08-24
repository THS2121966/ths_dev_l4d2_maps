/* Assault Mode Script File. Created by THS inc 2023 and Ivan Suvorov. */

function IV_Map_Advance_Stage()
{
    printl("Called AS Manage Fuction - 'IV_Map_Advance_Stage'");

    g_ModeScript.IV_Advance_Stage();
}

IV_DIRECTOR_ENT_LINK <- EntityGroup[0];
IV_TGFINALE_ENT_LINK <- EntityGroup[1];
IV_RELAY_INTRO_SKIP_ENT_LINK <- EntityGroup[2];

IV_INTRO_SHOWED <- false;

function IV_Map_Update_Assault_Task()
{
    g_ModeScript.IV_Update_Assault_Task();
}

local iv_mode_save_restore_parms =
{
    intro_checked_once = false,

    data_restored = false
};

function OnGameEvent_round_start_post_nav(params)
{
    g_ModeScript.IV_SET_Director_Object(IV_DIRECTOR_ENT_LINK);
    g_ModeScript.IV_SET_TGFinale_Object(IV_TGFINALE_ENT_LINK);

    local data_saved_name = "IV_MODE_DATA_SAVED";

    printl("Starting Restore 'IV_MODE_DATA_SAVED' Table");

    RestoreTable( data_saved_name, iv_mode_save_restore_parms );

    if(!iv_mode_save_restore_parms.data_restored)
    {
        iv_mode_save_restore_parms =
        {
            intro_checked_once = true,

            data_restored = true
        }

        printl("Saving 'IV_MODE_DATA_SAVED' Table");
        SaveTable( data_saved_name, iv_mode_save_restore_parms );
    }
    else
    IV_INTRO_SHOWED = iv_mode_save_restore_parms.intro_checked_once;

    if(IV_INTRO_SHOWED)
    EntFire(IV_RELAY_INTRO_SKIP_ENT_LINK.GetName(), "Trigger");

    if(IV_INTRO_SHOWED == false)
    printl("Intro Show State = 'FALSE'");
    else
    printl("Intro Show State = 'TRUE'");

    printl("Assault Gamemode Manager Parms Inited!!!");
    printl("Assault Gamemode Manager Parms Inited!!!");
    printl("Assault Gamemode Manager Parms Inited!!!");
}

function OnShutdown()
{
    if ( SessionState.ShutdownReason != SCRIPT_SHUTDOWN_ROUND_RESTART )
    {
        iv_mode_save_restore_parms =
        {
            intro_checked_once = false,

            data_restored = false
        }

        printl("Saving 'IV_MODE_DATA_SAVED' Table");
        SaveTable( data_saved_name, iv_mode_save_restore_parms );
    }
}

