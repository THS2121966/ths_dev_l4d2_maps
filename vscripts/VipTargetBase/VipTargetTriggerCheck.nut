IV_VIP_TARGET_HANDLE <- null;

IV_VIP_ENTERED <- false;

function IV_Check_Vip_Target()
{
    if(IV_VIP_ENTERED)
    return;

    if(IV_VIP_TARGET_HANDLE == null)
    IV_VIP_TARGET_HANDLE = g_ModeScript.IV_VIP_PLAYER

    if(IV_VIP_TARGET_HANDLE == null)
    {
        printl("Vip Target not Founded!!! Tell a Programmer!!!");
        return;
    }
    if(self.IsTouching(IV_VIP_TARGET_HANDLE))
    {
        Timers.AddTimer(60, false, IV_Rescure_Event_End);
        IV_VIP_ENTERED = true;

        EntFire("info_director", "EndScript");
        EntFire("info_director", "ForcePanicEvent");
        EntFire("info_director", "BeginScript", "c2m4_barns_onslaught2", 0.2);
    }
    else if(developer())
    printl("Survivor Bot touching that trigger...");
}

function IV_Rescure_Event_End(params)
{
    EntFire("info_director", "EndScript");
    EntFire("info_director", "BeginScript", "ivdev_vip_target_test01_main_d_rules", 0.2);

    EntFire(g_ModeScript.IV_SAFE_ZONE_SCRIPT_NAME, "RunScriptCode", "IV_END_Rescure()");
    SendToServerConsole("kick " + g_ModeScript.IV_VIP_TARGET_NAME);
}

self.ConnectOutput("OnStartTouch", "IV_Check_Vip_Target");
