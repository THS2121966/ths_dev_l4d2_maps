////////////////////////////////////////// THS inc 2021. //////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////// This script created for Director pre search scenario state... //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//IV note: Includes presented and added down below
IncludeScript("maps/l4d_cannals_escape_test_series/ths_scripts_base/iv_warning_msg_system.nut", this) //MSG and Core Script manager (base commands and Start, Shutdow system)
logic_script_system <- false

//IV note: Init Main Core.
iv_check <- IVCoreStartup(debug_enabled, "l4d_cannals_escape_test01_main.nut")


if(iv_check == false)
{
    return false
}
else
{
class IVDirectorInit
{
    iv_pre_release = true
    local_debug_enabled = false
    local_ths_dev_logo = "FIXME!!!"

    iv_min_scenario_p_c = 2

    iv_prohibit_bosses = false
    iv_alwaysallowwanderers = true
    iv_mob_min_max_table = {
    min = 25,
    max = 30
    }
    iv_special_infected_table = {
    l_SmokerLimit = 2,
    l_JockeyLimit = 0,
    l_BoomerLimit = 3,
    l_HunterLimit = 1,
    l_ChargerLimit = 0,
    l_SpitterLimit = 0,
    l_TankLimit = 1,
    l_WitchLimit = 3
    }

    function SetDefaultParms()
    {
        iv_prohibit_bosses = false
        iv_alwaysallowwanderers = true
        iv_mob_min_max_table.min = 25
        iv_mob_min_max_table.max = 30
        iv_special_infected_table.l_SmokerLimit = 2
        iv_special_infected_table.l_JockeyLimit = 0
        iv_special_infected_table.l_BoomerLimit = 3
        iv_special_infected_table.l_HunterLimit = 1
        iv_special_infected_table.l_ChargerLimit = 0
        iv_special_infected_table.l_SpitterLimit = 0
        iv_special_infected_table.l_TankLimit = 1
        iv_special_infected_table.l_WitchLimit = 3
        if(local_debug_enabled == true)
        {
            ::printl(local_ths_dev_logo+"List of default script parms: \n iv_prohibit_bosses = "+iv_prohibit_bosses+"\n iv_alwaysallowwanderers = "
            +iv_alwaysallowwanderers+"\n iv_mob_min_max_table = MIN - "
            +iv_mob_min_max_table.min+"\n MAX - "+iv_mob_min_max_table.max+"\n l_SmokerLimit = "
            +iv_special_infected_table.l_SmokerLimit+"\n l_JockeyLimit = "+iv_special_infected_table.l_JockeyLimit+"\n l_BoomerLimit = "+iv_special_infected_table.l_BoomerLimit
            +"\n l_HunterLimit = "+iv_special_infected_table.l_HunterLimit+"\n l_ChargerLimit = "+iv_special_infected_table.l_ChargerLimit+"\n l_SpitterLimit = "
            +iv_special_infected_table.l_SpitterLimit)
        }
    }
}


iv_director_main <- IVDirectorInit()
iv_director_main.local_ths_dev_logo = thsdev_logo

if(iv_director_main.iv_pre_release == true)
{
    debug_enabled <- true
    iv_director_main.local_debug_enabled = debug_enabled
}

iv_director_main.SetDefaultParms()


Msg("Initiating l4d_cannals_escape_test01_main\n");

function ReleaseDirectorParms()
{
    l4d_s_mode <- 1
    iv_survivor_count <- FindSurvivorAndTakeIT()
    if(iv_survivor_count && iv_survivor_count <= iv_director_main.iv_min_scenario_p_c)
    {
        iv_director_main.iv_mob_min_max_table.min = 15
        iv_director_main.iv_mob_min_max_table.max = 18
        iv_director_main.iv_special_infected_table.l_SmokerLimit = 1
        iv_director_main.iv_special_infected_table.l_JockeyLimit = 0
        iv_director_main.iv_special_infected_table.l_BoomerLimit = 1
        iv_director_main.iv_special_infected_table.l_HunterLimit = 0
        iv_director_main.iv_special_infected_table.l_ChargerLimit = 0
        iv_director_main.iv_special_infected_table.l_SpitterLimit = 1
        iv_director_main.iv_special_infected_table.l_TankLimit = 0
        iv_director_main.iv_special_infected_table.l_WitchLimit = 1
    }
    else
    {
        iv_director_main.iv_mob_min_max_table.min = 25
        iv_director_main.iv_mob_min_max_table.max = 30
        iv_director_main.iv_special_infected_table.l_SmokerLimit = 2
        iv_director_main.iv_special_infected_table.l_JockeyLimit = 0
        iv_director_main.iv_special_infected_table.l_BoomerLimit = 3
        iv_director_main.iv_special_infected_table.l_HunterLimit = 1
        iv_director_main.iv_special_infected_table.l_ChargerLimit = 0
        iv_director_main.iv_special_infected_table.l_SpitterLimit = 0
        iv_director_main.iv_special_infected_table.l_TankLimit = 1
        iv_director_main.iv_special_infected_table.l_WitchLimit = 3
    }
        if(debug_enabled == true)
        {
            printl(thsdev_logo+"List of CHANGED script parms: \n iv_prohibit_bosses = "+iv_director_main.iv_prohibit_bosses+"\n iv_alwaysallowwanderers = "
            +iv_director_main.iv_alwaysallowwanderers+"\n iv_mob_min_max_table = MIN - "
            +iv_director_main.iv_mob_min_max_table.min+"\n MAX - "+iv_director_main.iv_mob_min_max_table.max+"\n l_SmokerLimit = "
            +iv_director_main.iv_special_infected_table.l_SmokerLimit+"\n l_JockeyLimit = "+iv_director_main.iv_special_infected_table.l_JockeyLimit+"\n l_BoomerLimit = "
            +iv_director_main.iv_special_infected_table.l_BoomerLimit
            +"\n l_HunterLimit = "+iv_director_main.iv_special_infected_table.l_HunterLimit+"\n l_ChargerLimit = "+iv_director_main.iv_special_infected_table.l_ChargerLimit+"\n l_SpitterLimit = "
            +iv_director_main.iv_special_infected_table.l_SpitterLimit)
        }
DirectorOptions <-
{
	// This turns off tanks and witches (when true).
	ProhibitBosses = iv_director_main.iv_prohibit_bosses
	
	AlwaysAllowWanderers = iv_director_main.iv_alwaysallowwanderers

	NumReservedWanderers = iv_director_main.iv_mob_min_max_table.min
    
    NoMobSpawns = false

	//LockTempo = true // Locks the horde spawning to only be at the COMBAT phase.

	// Sets the time between mob spawns. Mobs can only spawn when the pacing is in the BUILD_UP state.
	MobSpawnMinTime = 120
	MobSpawnMaxTime = 180

	// How many zombies are in each mob.
	MobMinSize = iv_director_main.iv_mob_min_max_table.min
	MobMaxSize = iv_director_main.iv_mob_min_max_table.max
	MobMaxPending = iv_director_main.iv_mob_min_max_table.max

	// Modifies the length of the SUSTAIN_PEAK and RELAX states to shorten the time between mob spawns.
	SustainPeakMinTime = 5
	SustainPeakMaxTime = 10
	IntensityRelaxThreshold = 0.99
	RelaxMinInterval = 1
	RelaxMaxInterval = 5
	RelaxMaxFlowTravel = 50

	//Special infected options
	SpecialRespawnInterval = 25
        SmokerLimit = iv_director_main.iv_special_infected_table.l_SmokerLimit
        JockeyLimit = iv_director_main.iv_special_infected_table.l_JockeyLimit
        BoomerLimit = iv_director_main.iv_special_infected_table.l_BoomerLimit
        HunterLimit = iv_director_main.iv_special_infected_table.l_HunterLimit
        ChargerLimit = iv_director_main.iv_special_infected_table.l_ChargerLimit
        SpitterLimit = iv_director_main.iv_special_infected_table.l_SpitterLimit
        TankLimit = iv_director_main.iv_special_infected_table.l_TankLimit
        WitchLimit = iv_director_main.iv_special_infected_table.l_WitchLimit

	// Valid spawn locations
	PreferredMobDirection = SPAWN_NO_PREFERENCE
	ZombieSpawnRange = 2650
    CommonLimit = iv_director_main.iv_mob_min_max_table.max + iv_survivor_count
}
}


function ReleaseDScriptScenario() {
    ReleaseDirectorParms()
}


ReleaseDScriptScenario()
}

