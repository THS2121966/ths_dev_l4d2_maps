/* THS inc and Ivan Suvorov 2023 */
/* Co-op mode Start Talking Manager */

printl("Loading Talking Manager for First Mission Map...");

if(!IncludeScript("maps/l4d_escapefromterrortown01/IVScriptEngineBase/iv_players_manager.nut"))
{
    printl("Failed to Load Players Manager!!! Aborting Logic...");
    return;
}

IV_TALK_ROCHELLE <-
[
    EntityGroup[0],
    EntityGroup[1]
]
IV_TALK_ELLIS <-
[
    EntityGroup[2],
    EntityGroup[3]
]
IV_TALK_NICK <-
[
    EntityGroup[4],
    EntityGroup[5]
]
IV_TALK_COACH <-
[
    EntityGroup[6],
    EntityGroup[7]
]

IV_TALK_PERSONS <-
[
    IV_TALK_ROCHELLE,
    IV_TALK_ELLIS,
    IV_TALK_NICK,
    IV_TALK_COACH
]
IV_TALK_PERSONS_ACTIVE <-
[
    false,
    false,
    false,
    false
]

function IV_Talk_Specifed_Scene(sended_scene_ent)
{
    if(sended_scene_ent == null || sended_scene_ent.GetClassname() != "logic_choreographed_scene")
    {
        printl("Invalid choreo sended entity!!!");

        if(sended_scene_ent != null)
        {
            printl("Failed Entity Name - '" + sended_scene_ent.GetName() + "', Entity Class - '" + sended_scene_ent.GetClassname() + "'");
        }

        return;
    }

    DoEntFire("!self", "Start", "", 0, null, sended_scene_ent);
}

g_players_manager <- null;

function IV_Start_Survivors_Talk()
{
    g_players_manager <- IV_Players_Manager(true);

    if(g_players_manager.IV_Find_Player_By_Name("!rochelle"))
    IV_TALK_PERSONS_ACTIVE[0] = true;
    if(g_players_manager.IV_Find_Player_By_Name("!ellis"))
    IV_TALK_PERSONS_ACTIVE[1] = true;
    if(g_players_manager.IV_Find_Player_By_Name("!nick"))
    IV_TALK_PERSONS_ACTIVE[2] = true;
    if(g_players_manager.IV_Find_Player_By_Name("!coach"))
    IV_TALK_PERSONS_ACTIVE[3] = true;

    local players_count = 0;
    foreach (player_state in IV_TALK_PERSONS_ACTIVE)
    {
        if(player_state)
        players_count++;
    }

    if(players_count > 1)
    {
        local players_index_array = [];
        foreach (i, checked_state in IV_TALK_PERSONS_ACTIVE)
        {
            if(checked_state)
            players_index_array.append(i);
        }

        local player_fist_talk = RandomInt(0, players_index_array.len() - 1);
        local player_second_talk = RandomInt(0, players_index_array.len() - 1);

        EntFire(IV_TALK_PERSONS[player_fist_talk][0].GetName(), "AddOutput", "OnCompletion " + IV_TALK_PERSONS[player_second_talk][0].GetName() +
        ":Start::0:-1", 0);
        EntFire(IV_TALK_PERSONS[player_second_talk][0].GetName(), "AddOutput", "OnCompletion " + IV_TALK_PERSONS[player_fist_talk][1].GetName() +
        ":Start::0:-1", 0);

        printl("Playing Team Talk Scene Starting At '" + IV_TALK_PERSONS[player_fist_talk][0].GetName() + "'");
        IV_Talk_Specifed_Scene(IV_TALK_PERSONS[player_fist_talk][0]);
    }
    else
    {
        foreach (i, checked_state in IV_TALK_PERSONS_ACTIVE)
        {
            if(checked_state)
            {
                printl("Playing Alone Talk Scene... '" + IV_TALK_PERSONS[i][0].GetName() + "'");
                IV_Talk_Specifed_Scene(IV_TALK_PERSONS[i][0]);
                break;
            }
        }
    }
}