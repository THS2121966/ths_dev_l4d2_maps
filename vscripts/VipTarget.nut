IncludeScript("VSLib.nut");

IV_WANDERING_ZOMBIES <- 5;

if ( !IsModelPrecached( "models/survivors/survivor_namvet.mdl" ) )
	PrecacheModel( "models/survivors/survivor_namvet.mdl" );

if ( Convars.GetFloat( "sb_l4d1_survivor_behavior" ) > 0 )
	Convars.SetValue( "sb_l4d1_survivor_behavior", 0 );

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

	local tg_name = "Vip Target";

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

	printl("[IV Bot Creator] Added Vip Target Named - '" + tg_name + "'");

	if(IV_VIP_PLAYER != null)
	IV_Realise_Recure_Start();
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

	commands <-
	{
		cmd = 1
		pos = Entities.FindByName(null, "vip_escape_area_mdl_01").GetOrigin()
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

MutationOptions <-
{
    CommonLimit = 80
 	MegaMobSize = 50
 	WanderingZombieDensityModifier = IV_WANDERING_ZOMBIES
 	MaxSpecials  = 24
 	TankLimit    = 8
 	WitchLimit   = 8
	BoomerLimit  = 12
 	ChargerLimit = 3
 	HunterLimit  = 5
	JockeyLimit  = 3
	SpitterLimit = 12
	SmokerLimit  = 5
}

if(developer())
foreach (index, parm in MutationOptions)
{
	printl("[" + (index + 1) + "] '" + MutationOptions[index] + "' = '" + parm + "'");
}
