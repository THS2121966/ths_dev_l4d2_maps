/* Ivan Suvorov and THS inc 2024 */
/* Map Director Simple Ambient */


g_consts_state <- IncludeScript("IVScriptsManager/IVConstParms/iv_consts_init.nut");

if(!g_consts_state)
{
    Msg("Failed To Load IV Consts for Director Script!!!");
    return;
}


Msg(THS_LOGO + " Initiating Director Simple Ambient Mode\n");

DirectorOptions <-
{
    CommonLimit = 12
	MaxSpecials = 2

    MobSpawnMinTime = 120
	MobSpawnMaxTime = 180

    MobMinSize = 8
    MobMaxSize = 15

    SpecialRespawnInterval = 12
    SmokerLimit = 0
    BoomerLimit = 0
    HunterLimit = 2
    SpitterLimit = 0
    JockeyLimit = 0
    ChargerLimit = 0

    TankLimit = 0
    WitchLimit = 3

    PreferredMobDirection = SPAWN_BEHIND_SURVIVORS
	ZombieSpawnRange = 2800

    BileMobSize = 23
}


if(developer())
{
    Msg(THS_LOGO + " Starting Check Director Parms List...\n");
    Msg("===================================================\n");
    foreach ( index, checked_parm in DirectorOptions )
    {
        Msg("(" + index + ") = " + checked_parm + "\n");
    }
    Msg("===================================================\n");
    Msg(THS_LOGO + " Done!!!\n");
}

Director.ResetMobTimer()
