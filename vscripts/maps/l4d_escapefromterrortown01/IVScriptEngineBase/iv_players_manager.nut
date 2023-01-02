/* THS inc and Ivan Suvorov 2023 */
/* Players Control Manager */

printl("==============Loaded Players Manager Logic==============");

class IV_Players_Manager
{
    constructor(l4d2_players = true)
    {
        g_is_l4d2_players = l4d2_players;
        IV_PreCache_Players_List();
    }

    IV_L4D1_SURVIVORS_LIST =
    {
        Zoey = "models/survivors/survivor_teenangst.mdl",
        Bill = "models/survivors/survivor_namvet.mdl",
        Francis = "models/survivors/survivor_biker.mdl",
        Louis = "models/survivors/survivor_manager.mdl"
    }

    IV_L4D2_SURVIVORS_LIST =
    {
        Rochelle = "models/survivors/survivor_producer.mdl",
        Coach = "models/survivors/survivor_coach.mdl",
        Nick = "models/survivors/survivor_gambler.mdl",
        Ellis = "models/survivors/survivor_mechanic.mdl"
    }

    function IV_CHECK_PLAYER_CORRECT(player)
    {
        printl("Checking '" + player.GetName() + "'");

        local result = null;

        if(g_is_l4d2_players)
        {
            foreach (checked_model in IV_L4D2_SURVIVORS_LIST)
            {
                if(player.GetModelName() == checked_model)
                {
                    result = player;
                    break;
                }
            }
        }
        else
        {
            foreach (checked_model in IV_L4D1_SURVIVORS_LIST)
            {
                if(player.GetModelName() == checked_model)
                {
                    result = player;
                    break;
                }
            }
        }

        return result;
    }

    g_is_l4d2_players = true;
    g_players_list = [];

    function IV_PreCache_Players_List()
    {
        printl("PreCaching Active Survivors List...");

        local checked_player = null;
        while (checked_player = Entities.FindByClassname(checked_player, "player"))
        {
            printl("Founded Undefined Player '" + checked_player.GetName() + "'");

            local player_result = IV_CHECK_PLAYER_CORRECT(checked_player);
            if(player_result)
            {
                g_players_list.append(player_result);
                printl("Founded Player - '" + player_result.GetName() + "'");
            }
        }
    }

    function IV_Get_Players_list()
    {
        return g_players_list;
    }

    function IV_Find_Player_By_Name(player_name)
    {
        if(g_players_list == null)
        return null;

        if(g_players_list[0] == null)
        return null;

        local player_check = Entities.FindByName(null, player_name);

        if(!player_check)
        return null;

        foreach (checked_player in g_players_list)
        {
            printl("Checked '" + checked_player.GetModelName() + "' Player Model");
            if(checked_player.GetModelName() == player_check.GetModelName())
            return checked_player;
        }
    }
}