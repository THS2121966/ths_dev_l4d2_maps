/* Ivan Suvorov and THS inc 2024 */
/* Start COOP Map Director Silent Mode */

Msg("[THS] Initiating Director Silent COOP Mode\n");

DirectorOptions <-
{
    CommonLimit = 0
    ProhibitBosses = true
	MaxSpecials = 0
}


if(developer())
{
    Msg("Starting Check Director Parms List...\n");
    Msg("===================================================\n");
    foreach ( index, checked_parm in DirectorOptions )
    {
        Msg("(" + index + ") = " + checked_parm + "\n");
    }
    Msg("===================================================\n");
    Msg("Done!!!\n");
}
