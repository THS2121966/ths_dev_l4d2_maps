/* Ivan Suvorov and THS inc 2024 */
/* Consts Logic and Parms Init */


IncludeScript("IVScriptsManager/IVConstParms/iv_logo.nut");


//IV Note: Assert Func. Must be Realised in iv_manager.nut!!!
IV_Assert <- null;

//IV Note: Function only have (BOOL and STRING PARMS)
function IV_Realise_Assert_Logic(sended_assert_func)
{
    IV_Assert <- sended_assert_func;
}

if(developer())
Msg(THS_LOGO + " Consts was Inited Sucessfull!!!\n");
