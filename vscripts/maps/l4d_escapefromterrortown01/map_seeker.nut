/* THS inc and Ivan Suvorov 2023 */
/* Map Scripted Events Main Logic */

printl("Loading Map Seeker for Controlling Scripted Map Events...");

if(!IncludeScript("IVScriptEngineBase/iv_players_manager.nut"))
{
    printl("Failed to Load Players Manager!!! Aborting Logic...");
    return;
}

IV_INFO_DIRECTOR_ENTITY <- EntityGroup[0];

function IV_Gameplay_Start_Scenario()
{
    g_players_manager <- IV_Players_Manager(true);

    local temp_players_list = g_players_manager.IV_Get_Players_list();

    if(temp_players_list.len() <= 2)
    g_game_difficulty = IV_DIFFICULTY_LEVELS[1];

    if(g_gamemode_status == "versus")
    {
        DoEntFire("!self", "EndScript", "" 8, null, IV_INFO_DIRECTOR_ENTITY);
        DoEntFire("!self", "BeginScript", "l4d_escapefromterrortown01_ambient" 12, null, IV_INFO_DIRECTOR_ENTITY);
        EntFire("secred_door_infected_spawn_01_area", "FireUser1", "", 0);
    }
}