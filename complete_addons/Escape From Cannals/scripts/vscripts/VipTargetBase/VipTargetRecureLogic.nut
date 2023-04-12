IV_EVENT_START <- EntityGroup[0];
IV_EVENT_END <- EntityGroup[1];

IV_RESCURE_POINT <- EntityGroup[2];

function IV_BEGIN_Rescure()
{
    DoEntFire("!self", "Trigger", "", 0, null, IV_EVENT_START);

    g_ModeScript.IV_BOT_RESCURE_POINT = IV_RESCURE_POINT;

    EntFire("worldspawn", "RunScriptCode", "g_ModeScript.IV_Rescure_Bot_Move_Event()");
}

function IV_END_Rescure()
{
    DoEntFire("!self", "Trigger", "", 0, null, IV_EVENT_END);
}
