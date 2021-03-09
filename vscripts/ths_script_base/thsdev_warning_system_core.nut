//******************************************************************************************************
//thsdev_warning_system_core.nut is called to thsdev_warning_system_core security...
//******************************************************************************************************
printl("==== calling thsdev_warning_system_core.nut")
printl("==== [THS] Loading thsdev_warning_system_core Logic...")


//thsdev_debug_parms
debug_enable <- 0;
msg_helper <- 0;
Crashed <- 0;
WarningS_MSG_Number <- null;
WarningLevel <- 1;
msg_warning <- "FIXME!!!"


function SelfDestructOnFalse(Crased, debug_enable, msg_helper)
{
    if(Crased == 1)
    {
        EntFire("!self", "Kill", "", 1)
    }
    if(debug_enable == 1 && msg_helper == 0)
    {
        printl("[THS_Script] Error!!! Aborting...")
    }
    else if (msg_helper == 1 && debug_enable == 1)
    {
        printl("[THS_Script] Shutdown Core System...")
    }
}

function Warning(WarningS_MSG_Number, WarningLevel)
{
/*if(WarningS_MSG_Number == null)
{
    SelfDestructOnFalse(1,1)
}*/

if (debug_enable == 1)
{
    EntFire(EntityGroup[WarningS_MSG_Number].GetName(), "PlaySound", "", 0)
    printl(msg_warning)
}
    if(WarningLevel == 5)
    {
    debug_enable <- 1;
    EntFire(EntityGroup[WarningS_MSG_Number.GetName()], "PlaySound", "", 1)
    EntFire(EntityGroup[WarningS_MSG_Number.GetName()], "PlaySound", "", 2)
    EntFire(EntityGroup[WarningS_MSG_Number.GetName()], "PlaySound", "", 3)
    EntFire(EntityGroup[WarningS_MSG_Number.GetName()], "PlaySound", "", 4)
    printl("Error!!!"+msg_warning)
    printl("Error!!!"+msg_warning)
    printl("Error!!!"+msg_warning)
    SelfDestructOnFalse(1, 1, 0)
    }
}

function TestSound()
{
if(WarningS_MSG_Number == null)
{
    WarningS_MSG_Number <- 4; //for_preload_test
}
    Warning(WarningS_MSG_Number, 1)
}


function Debug_Disable()
{
    debug_enable <- 0;
}

function Debug_Enable()
{
    debug_enable <- 1;
    msg_warning <- "[THS_Script] Debug System - Enabled!!!"
    Warning(WarningS_MSG_Number, 1)
}