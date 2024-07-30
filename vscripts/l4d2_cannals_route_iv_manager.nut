/* Ivan Suvorov and THS inc 2024 */
/* IV Manager Mission Init */


g_manager_state <- IncludeScript("IVScriptsManager/iv_manager.nut");

if(!g_manager_state)
Msg("Failed to Load IV Manager for Currient Mission!!!\n");


LOUIS_MODEL_NAME <- "survivors/survivor_manager.mdl";


function IV_Louis_Model_Precache()
{
    local precache_state = PrecacheModel(LOUIS_MODEL_NAME);
    if(developer() && precache_state)
    Msg(THS_LOGO + " Louis Model was Precached Sucessfull!!!\n");
    else
    Msg(THS_LOGO + " Louis Model Precache was Failed!!! If Map Haven't Louis Model - Engine was Crashed!!!");
}

IV_Louis_Model_Precache();

function IV_Gameplay_Started()
{
    Msg(THS_LOGO + " Gameplay Was Started Sucessfull!!!\n");
}
