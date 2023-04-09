IV_SAFE_ZONE_SCRIPT_NAME <- "@VipSafeZone";

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
        EntFire(IV_SAFE_ZONE_SCRIPT_NAME, "RunScriptCode", "IV_END_Rescure()");
        IV_VIP_ENTERED = true;

        DoEntFire("!self", "Kill", "", 0, null, IV_VIP_TARGET_HANDLE);
    }
    else if(developer())
    printl("Survivor Bot touching that trigger...");
}

self.ConnectOutput("OnStartTouch", "IV_Check_Vip_Target");
