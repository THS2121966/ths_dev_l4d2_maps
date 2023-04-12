/* Ivan Suvorov and THS inc 2023 */
/* IV Note: Main VipTarget Gamemode Script File */

if(!IncludeScript("VSLib.nut"))
{
	for (index = 0; index < 3; index++)
	{
		printl("Falied to Load VSLib Logic!!! Please download that from Steam Workshop!!!");
	}

	return;
}

IV_VIP_TARGET_NAME <- "VipTarget";

IV_BOT_RESCURE_POINT <- null;

IV_WANDERING_ZOMBIES <- 1;
IV_VIP_WAS_DIFFERENT_BOT <- true;

if ( !IsModelPrecached( "models/survivors/survivor_namvet.mdl" ) )
	PrecacheModel( "models/survivors/survivor_namvet.mdl" );

if(!IV_VIP_WAS_DIFFERENT_BOT)
Convars.SetValue( "sb_l4d1_survivor_behavior", 0 );
else
Convars.SetValue( "sb_l4d1_survivor_behavior", 1 );

IV_VIP_CHARACTER <- 4;
IV_LAST_PLAYER_ID <- null;

IV_SPAWNED_VIP <- false;
IV_IS_SPAWN_ENABLED <- false;

IV_DUMMY_SPAWN_NAME <- null;

IV_VIP_DANGER_ZONE_NAME <- "@VipDanger";
IV_SAFE_ZONE_SCRIPT_NAME <- "@VipSafeZone";

IV_VIP_PLAYER <- null;

function RestoreVipCharacter( userid, character )
{
	local player = GetPlayerFromUserID( userid );
	if ( (!player) || (!player.IsSurvivor()) )
		return;

	NetProps.SetPropInt( player, "m_survivorCharacter", character );
}

function SpawnVipTarget( userid )
{
	if ( Director.GetSurvivorSet() == 1 )
	{
		local player = GetPlayerFromUserID( userid );
		if ( (!player) || (!player.IsSurvivor()) )
			return;

		local previousCharacter = NetProps.GetPropInt( player, "m_survivorCharacter" );
		local botName = "bill";

		if ( previousCharacter == 1 )
		{
			botName = "zoey";
			IV_VIP_CHARACTER = 5;
		}
		else if ( previousCharacter == 2 )
		{
			botName = "louis";
			IV_VIP_CHARACTER = 7;
		}
		else if ( previousCharacter == 3 )
		{
			botName = "francis";
			IV_VIP_CHARACTER = 6;
		}
		NetProps.SetPropInt( player, "m_survivorCharacter", 9 );
		SendToServerConsole( "sb_add " + botName );
		EntFire( "worldspawn", "RunScriptCode", "g_ModeScript.RestoreVipCharacter(" + userid + "," + previousCharacter + ")", 0.1 );
	}
	else
		SendToServerConsole( "sb_add bill" );

		printl("[IV Bot Creator] Added new Bot Slot!!! Checking it for Vip Target...");

		IV_SPAWNED_VIP = true;
}

function ConvertVIPTarget( userid )
{
	local player = GetPlayerFromUserID( userid );
	if ( (!player) || (!player.IsSurvivor()) )
		return;

	local tg_name = IV_VIP_TARGET_NAME;

	if(!IV_VIP_WAS_DIFFERENT_BOT)
	NetProps.SetPropInt( player, "m_iTeamNum", 2 );

	NetProps.SetPropInt( player, "m_survivorCharacter", 9 );
	//player.SetModel( "models/survivors/survivor_ceda.mdl" );
	//NetProps.SetPropString( player, "m_ModelName", "models/survivors/survivor_namvet.mdl" );
	SetFakeClientConVarValue( player, "name", tg_name );

	local glowColor = 65280;
	if ( player.IsOnThirdStrike() )
		glowColor = 255;

	NetProps.SetPropInt( player, "m_Glow.m_glowColorOverride", glowColor );
	NetProps.SetPropInt( player, "m_Glow.m_iGlowType", 3 );

	player.SetOrigin(Entities.FindByName(null, IV_DUMMY_SPAWN_NAME).GetOrigin());
	EntFire(IV_DUMMY_SPAWN_NAME, "Kill", "", 0.1);

	IV_VIP_PLAYER <- player;

	printl("[IV Bot Creator] Added Vip Target Named - '" + player.GetPlayerName() + "'");

	if(IV_VIP_PLAYER != null)
	{
		EntFire("worldspawn", "RunScriptCode", "g_ModeScript.IV_Bot_Startup_Command()", 0.1);
		EntFire("worldspawn", "RunScriptCode", "g_ModeScript.IV_Realise_Recure_Start()", 3);
	}
}

function IV_Bot_Startup_Command()
{
	local first_player = Entity.GetAnyClosestSurvivor();

	if(first_player == null)
	return;

	commands <-
	{
		cmd = DirectorScript.BOT_CMD_MOVE
		pos = first_player.GetPosition()
	}

	CommandABot(commands);
}

function IV_Create_Vip(dummy_ent_name)
{
	if(IV_LAST_PLAYER_ID == null)
	{
		printl("Player ID is Invalid!!! Tell a programmer!!!");
		return;
	}

	if(developer())
	printl("[IV Bot Creator] Trying to create Vip Target...");

	IV_IS_SPAWN_ENABLED = true;

	IV_DUMMY_SPAWN_NAME <- dummy_ent_name;

	if(!IV_SPAWNED_VIP)
	SpawnVipTarget(IV_LAST_PLAYER_ID);
}

function IV_Realise_Recure_Start()
{
	EntFire(IV_SAFE_ZONE_SCRIPT_NAME, "RunScriptCode", "IV_BEGIN_Rescure()");
}

function IV_Rescure_Bot_Move_Event()
{
	local command_move_object = IV_BOT_RESCURE_POINT;

	if(command_move_object == null)
	{
		printl("Falied to Check Vip Target Move Area!!! Tell a Programmer!!!")
		return;
	}

	commands <-
	{
		cmd = DirectorScript.BOT_CMD_MOVE
		pos = command_move_object.GetOrigin()
		bot = IV_VIP_PLAYER
	}

	CommandABot(commands);
}

function OnGameEvent_player_spawn( params )
{
	local player = GetPlayerFromUserID( params["userid"] );
	if ( (!player) || (!player.IsSurvivor()) )
		return;

	if ( NetProps.GetPropInt( player, "m_iTeamNum" ) == 4 && NetProps.GetPropInt( player, "m_survivorCharacter" ) == IV_VIP_CHARACTER )
	{
		EntFire( "worldspawn", "RunScriptCode", "g_ModeScript.ConvertVIPTarget(" + params["userid"] + ")", 0 );
	}

	if (!IV_SPAWNED_VIP)
	{
		if(!IV_IS_SPAWN_ENABLED)
		{
			printl("Player ID = '" + params["userid"] + "'");
			IV_LAST_PLAYER_ID <- params["userid"];
			return;
		}

		EntFire( "worldspawn", "RunScriptCode", "g_ModeScript.SpawnVipTarget(" + params["userid"] + ")", 0.5 );
		IV_SPAWNED_VIP = true;
	}
}

/*MutationOptions <-
{
    CommonLimit = 30
 	MegaMobSize = 15
 	WanderingZombieDensityModifier = IV_WANDERING_ZOMBIES
 	MaxSpecials  = 2
 	TankLimit    = 0
 	WitchLimit   = 0
	BoomerLimit  = 1
 	ChargerLimit = 0
 	HunterLimit  = 2
	JockeyLimit  = 0
	SpitterLimit = 0
	SmokerLimit  = 0
}*/

/*if(developer())
foreach (index, parm in MutationOptions)
{
	printl(index + " = " + parm);
}*/
