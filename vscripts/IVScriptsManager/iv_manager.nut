/* Ivan Suvorov and THS inc 2024 */
/* IV Manager Init Logic */


function IV_Base_Assert(state, text)
{
    if(state)
    return;

    for (next_index <- 0; next_index < 3; next_index++ )
    {
        Msg("[ERROR] Invalid Logic State - '" + text + "'; Tell a Programmer!!!\n");
    }
}


IV_Base_Assert(IncludeScript("IVScriptsManager/IVConstParms/iv_consts_init.nut"), "'iv_consts_init.nut' was NOT FOUNDED!!!");
IV_Realise_Assert_Logic(IV_Base_Assert);

if(developer())
Msg(THS_LOGO + " IV Manager was Inited Sucessfull!!!\n");
