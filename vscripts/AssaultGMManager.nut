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

function OnGameEvent_round_start_post_nav( params )
{
    g_ModeScript.IV_SET_Director_Object(IV_DIRECTOR_ENT_LINK);
    g_ModeScript.IV_SET_TGFinale_Object(IV_TGFINALE_ENT_LINK);

    if(IV_INTRO_SHOWED)
    EntFire(IV_RELAY_INTRO_SKIP_ENT_LINK.GetName(), "Trigger");

    if(IV_INTRO_SHOWED == false)
    {
        printl("Intro Show State = 'FALSE'");
        IV_INTRO_SHOWED = true;
    }
    else
    printl("Intro Show State = 'TRUE'");

    printl("Assault Gamemode Manager Parms Inited!!!");
}

