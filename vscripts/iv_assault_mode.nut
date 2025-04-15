//////////////////////////////////////////////////////////Created by Ivan Suvorov.//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////Assault Game Mode Init Logic//////////////////////////////////////////////////////

Msg("Realise Assault Game Mode...\n");

DirectorOptions <-
{
	ActiveChallenge = 1

	cm_AggressiveSpecials = false
	cm_DominatorLimit = 3
	cm_MaxSpecials = 5
	cm_SpecialRespawnInterval = 30
	cm_AutoReviveFromSpecialIncap = 1
	cm_TankLimit = 3

	SurvivorMaxIncapacitatedCount = 3
	SpecialInitialSpawnDelayMin = 12
	SpecialInitialSpawnDelayMax = 30
	TankHitDamageModifierCoop = 0.25

	SpitterLimit = 1
	JockeyLimit = 2
	ChargerLimit = 1

	WitchLimit = 3

	EscapeSpawnTanks = true

	weaponsToConvert =
	{
		weapon_defibrillator = "weapon_pain_pills_spawn"
	}

	DefaultItems =
	[
		"weapon_pistol_magnum"
	]

	function ConvertWeaponSpawn( classname )
	{
		if ( classname in weaponsToConvert )
		{
			return weaponsToConvert[classname];
		}
		return 0;
	}

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
    CurrentStage = -1,
    FinalMapState = 1
}

function OnGameEvent_player_spawn( params )
{
	local player = GetPlayerFromUserID( params["userid"] );

	if ( ( !player ) || ( !player.IsSurvivor() ) )
		return;

    printl("Spawned Assault Survivor Player - '" + player + "'");
}

function OnGameEvent_player_death( params )
{
	if ( !("userid" in params) )
		return;

	local victim = GetPlayerFromUserID( params["userid"] );

	if ( ( !victim ) || ( !victim.IsSurvivor() ) )
		return;

	local prevRagdoll = NetProps.GetPropEntity( victim, "m_hRagdoll" );
	if ( prevRagdoll != null )
		return;

	local clOrigin = victim.GetOrigin();

	local ragdoll = null;
	// cs_ragdoll can crash if proper netprops aren't set, some future-proofing
	// get rid of uninitialized ragdoll if something goes wrong here
	try
	{
		ragdoll = SpawnEntityFromTable( "cs_ragdoll", {} )
		NetProps.SetPropVector( ragdoll, "m_vecOrigin", clOrigin );
		NetProps.SetPropVector( ragdoll, "m_vecRagdollOrigin", clOrigin );
		NetProps.SetPropInt( ragdoll, "m_nModelIndex", NetProps.GetPropInt( victim, "m_nModelIndex" ) );
		NetProps.SetPropInt( ragdoll, "m_iTeamNum", NetProps.GetPropInt( victim, "m_iTeamNum" ) );
		NetProps.SetPropEntity( ragdoll, "m_hPlayer", victim );
		NetProps.SetPropInt( ragdoll, "m_iDeathPose", NetProps.GetPropInt( victim, "m_nSequence" ) );
		NetProps.SetPropInt( ragdoll, "m_iDeathFrame", NetProps.GetPropInt( victim, "m_flAnimTime" ) );
		NetProps.SetPropInt( ragdoll, "m_bClientSideAnimation", 1 );
		NetProps.SetPropInt( ragdoll, "m_iTeamNum", NetProps.GetPropInt( victim, "m_iTeamNum" ) );
		NetProps.SetPropInt( ragdoll, "m_nForceBone", NetProps.GetPropInt( victim, "m_nForceBone" ) );
		NetProps.SetPropInt( ragdoll, "m_ragdollType", 4 );
		NetProps.SetPropInt( ragdoll, "m_survivorCharacter", NetProps.GetPropInt( victim, "m_survivorCharacter" ) );
		NetProps.SetPropEntity( victim, "m_hRagdoll", ragdoll );

		//EntFire( "survivor_death_model", "Kill" );
		// EntFire is too slow and you can see one-frame image of death model
		for ( local body; body = Entities.FindByClassname( body, "survivor_death_model" ); )
		{
			body.Kill();
		}
	}
	catch (e)
	{
        printl("[Assault Manager] Failed to Realise CSS Ragdoll!!! Last Error Message is - '" + e + "'");
        printl("[Assault Manager] Failed to Create CSS Ragdoll!!! Trying to Realise 'BecomeRagdoll' Event Insead!!!");

		if ( ragdoll != null && ragdoll.IsValid() )
			ragdoll.Kill();

		EntFire( "survivor_death_model", "BecomeRagdoll" );
	}
}

function OnGameEvent_round_start_post_nav( params )
{
    Convars.SetValue("sb_all_bot_game", 1);
    Convars.SetValue("allow_all_bot_survivor_team", 1);

    IV_Realise_Assault_Mode_Post_Map();

    printl("Assault Game Mode is Loaded Sucessfull!!!");
}

function GetNextStage()
{
    if(SessionState.CurrentStage < 0)
	{
		printl("Assault Mode Prepare Stage!!!");
		SessionState.CurrentStage++;
		return;
	}

    if(developer())
    printl("Assault Mode Next Stage - " + SessionState.CurrentStage)
    switch ( SessionState.CurrentStage )
    {
        case 0:
        SessionOptions.ScriptedStageType = STAGE_SETUP;
        break;
        case 1:
        SessionOptions.ScriptedStageType = STAGE_PANIC;
        break;
        case 2:
        SessionOptions.ScriptedStageType = STAGE_SETUP;
        case 3:
        SessionOptions.ScriptedStageType = STAGE_RESULTS;
        break;
    }
}

g_as_manager <- null;

function IV_Realise_AS_Manager(sended_ent)
{
    g_as_manager <- sended_ent;

	if(g_as_manager == null)
	printl("Sended Assault Mode Manager is NULL!!!");
}

function IV_Realise_Assault_Mode_Post_Map()
{
    if(g_as_manager == null)
    printl("[Assault Manager] Assault Manager is Missing!!! Not a Assault Game Mode Specifed Map or Mapper foget Add This!!!");
}

function IV_Assault_Mode_Begin()
{
	Director.ForceNextStage();
}

function IV_Realise_Next_Stage()
{
	SessionState.CurrentStage++;
	Director.ForceNextStage();
}

Msg("Assault Game Mode Realised Sucessfull!!!\n");