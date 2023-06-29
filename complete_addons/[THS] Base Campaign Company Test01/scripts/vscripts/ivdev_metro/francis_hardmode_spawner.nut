/* Ivan Suvorov and THS inc 2023 */
/* Logic for Spawning Francis in HardMode Scenario */

const HELPER_NAME = "[Francis Spawner] ";

//IV Note: Ent's Definer
ENT_SPAWN_RELAY <- EntityGroup[0];
ENT_TEMPLATE_ELSE <- EntityGroup[1];

if ( !IsModelPrecached( "models/survivors/survivor_biker.mdl" ) )
	PrecacheModel( "models/survivors/survivor_biker.mdl" );

GameMode <- Director.GetGameModeBase();

FRANCIS_HANDLE <- null;

function IV_Check_GameMode_State(gamemode)
{
    printl(HELPER_NAME + "Currient Gamemode - '" + gamemode + "'")

    if(gamemode == "versus" || gamemode == "survival")
    return true;

    return false;
}

function IV_Check_Francis_State()
{
    if(developer())
    printl(HELPER_NAME + "Begining Check Game Difficulty...");

    local difficulty = Convars.GetStr( "z_difficulty" ).tolower();

    if(difficulty == "easy" || difficulty == "normal" && !IV_Check_GameMode_State(GameMode))
    DoEntFire("!self", "ForceSpawn", "", 0, null, ENT_TEMPLATE_ELSE );
    else
    {
        DoEntFire("!self", "Trigger", "", 0, null, ENT_SPAWN_RELAY );
        printl(HELPER_NAME + "Spawned Francis for Helping in that BATTLE!!!");

        DoEntFire("logic_francis_hardmode_spawn", "RunScriptCode", "IV_First_Move_Order()", 1.5, null, null );
    }
}

function IV_First_Move_Order()
{
    FRANCIS_HANDLE = Entities.FindByName(null, "!francis");

    if(FRANCIS_HANDLE == null)
    {
        printl(HELPER_NAME + "Failed to find Francis!!! Aborting...");
        return;
    }

    local trigger_finale_ent = Entities.FindByClassname(null, "trigger_finale");

    if(trigger_finale_ent == null)
    {
        printl(HELPER_NAME + "Not Founded Trigger Finale!!! Aborting Order...");
        return;
    }

    local order_pos = trigger_finale_ent.GetOrigin();

    IV_Command_Francis_Move(order_pos);
}

function IV_Command_Francis_Move(move_vector)
{
    if(FRANCIS_HANDLE == null)
    {
        printl(HELPER_NAME + "Failed to create move order!!! Francis not founded!!!");
        return;
    }

    local command_list =
    {
        bot = FRANCIS_HANDLE
        cmd = DirectorScript.BOT_CMD_MOVE
        pos = move_vector
    }

    CommandABot(command_list);
}

