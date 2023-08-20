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
    EntFire(IV_TRIGGER_FINALE, "FinaleEscapeFinished");
}

function IV_Advance_Stage()
{
    printl("Used Advance State Funcrion!!!");

    if((SessionState.CurrentStage + 1) != IV_STAGE_FINALE_END)
    SessionState.CurrentStage++;
    else
    IV_Check_Round_Final();
}

