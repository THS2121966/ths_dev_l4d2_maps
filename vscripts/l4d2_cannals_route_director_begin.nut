/* Ivan Suvorov and THS inc 2024 */
/* Start COOP Map Director Silent Mode */


g_consts_state <- IncludeScript("IVScriptsManager/IVConstParms/iv_consts_init.nut");

if(!g_consts_state)
{
    Msg("Failed To Load IV Consts for Director Script!!!");
    return;
}


Msg(THS_LOGO + " Initiating Director Silent COOP Mode\n");

DirectorOptions <-
{
    CommonLimit = 0
    ProhibitBosses = true
	MaxSpecials = 0
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
