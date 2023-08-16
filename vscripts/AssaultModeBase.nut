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
IV_STAGE_RESULTS <- 1;

function GetNextStage()
{
    if(developer())
    printl("Assault Mode Next Stage - " + SessionState.CurrentStage)
    switch ( SessionState.CurrentStage )
    {
        case IV_STAGE_MAIN_ACTION:
        SessionOptions.ScriptedStageType = STAGE_ESCAPE;
        break;
        case IV_STAGE_RESULTS:
        SessionOptions.ScriptedStageType = STAGE_RESULTS;
        break;
    }
}

function IV_Advance_Stage()
{
    SessionState.CurrentStage++;
    GetNextStage();
}

