////////////////////////////////////////// THS inc 2021. //////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////// This script created for thsdev_simple gamemode init... /////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//IV note: Includes presented and added down below
IncludeScript("ths_scripts_base/iv_warning_msg_system.nut", this) //MSG and Core Script manager (base commands and Start, Shutdow system)
logic_script_system <- false


//IV note: Init Main Core.
iv_core_init <- IVCoreStartup(debug_enabled, "thsdev_simple.nut")


if(iv_core_init == true)
{
    st_spawned_s <- FindSurvivorAndTakeIT()
	if(st_spawned_s == 0)
	{
		st_spawned_s = 2
	}
    MutationOptions <-
    {
        CommonLimit = 12 * st_spawned_s // Maximum number of common zombies alive in the world at the same time
        MegaMobSize = 15 * st_spawned_s // Total number of common zombies in a mob. (never more than CommonLimit at one time)
        WanderingZombieDensityModifier = 0 // lets get rid of the wandering zombies
        MaxSpecials  = 0
        TankLimit    = 0
        WitchLimit   = 0
        BoomerLimit  = 0
        ChargerLimit = 0
        HunterLimit  = 0
        JockeyLimit  = 0
        SpitterLimit = 0
        SmokerLimit  = 0
    }
    MutationState <-
    {
        CurrentStage = -1
    }

    SanitizeTable <-
    [
    	{ classname = "info_changelevel", input = "kill"},
        { classname = "prop_door_rotating_checkpoint", input = "kill"}
    ]

    function GetNextStage()
    {
        local p_a_c = FindSurvivorAndTakeIT()
        SessionState.CurrentStage++
        
        printl(thsdev_logo+" *** GetNextStage() called, my current stage is: " + SessionState.CurrentStage )
        
        switch ( SessionState.CurrentStage )
        {
            case 0: // setup stage
            SessionOptions.ScriptedStageType = STAGE_SETUP
            SessionOptions.ScriptedStageValue = 15 - p_a_c // seconds to stay in this stage
			break
            case 1: // common zombie attack!
			SessionOptions.ScriptedStageType = STAGE_PANIC
			SessionOptions.ScriptedStageValue = p_a_c
			break
            case 2: // clear out the stragglers
			SessionOptions.ScriptedStageType = STAGE_CLEAROUT
			SessionOptions.ScriptedStageValue = 8 + p_a_c // Wait 8 seconds once all infected are dead
			break
            case 3:
            SessionOptions.ScriptedStageType = STAGE_ESCAPE
            if( "g_RescueManager" in g_RoundState )
            g_RoundState.g_RescueManager.ForceSummonRescueChopper()
            else // I guess they didn't include a chopper - set STAGE_RESULTS
            SessionOptions.ScriptedStageType = STAGE_RESULTS
            break
        }
    }
    function OnGameplayStart()
    {
        // gameplay start code goes here!
        // Teleport players out of the start room to their start positions
        TeleportPlayersToStartPoints( "thsdev_simple_playerstart_*")
        local p1_spawn = Entities.FindByName(null, "thsdev_simple_playerstart_001")
        local p2_spawn = Entities.FindByName(null, "thsdev_simple_playerstart_002")
        local p3_spawn = Entities.FindByName(null, "thsdev_simple_playerstart_003")
        local p4_spawn = Entities.FindByName(null, "thsdev_simple_playerstart_004")
        printl(thsdev_logo+"Force Released Players spawn points at: \n"+p1_spawn.GetName()+"\n"+p2_spawn.GetName()+"\n"+p3_spawn.GetName()+"\n"+p4_spawn.GetName())
    }
}
else
{
    printl(thsdev_logo+thsdev_error_logo"IV Script System loaded with Error State!!! Aborting...")
    return -1
}