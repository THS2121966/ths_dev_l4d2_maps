////////////////////////////////////////// THS inc 2021. //////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////// This script created for base core system messaging... //////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//IV note: Includes presented and added down below
IncludeScript("ths_scripts_base/IV_core.nut", this) //Core Script manager (base commands and Start, Shutdow system)


//IV note: Init Main Core.
IVCoreStartup(debug_enabled, "iv_warning_msg_system.nut")


//IV note: MSG System parms
logic_script_system <- false
msg_sound_channel <- "null name"

msg_warning_messages <- [
msg01 <- null
msg02 <- null
msg03 <- null
msg04 <- null
msg05 <- null
]
msg_w_state_count <- 0
msg_error_message <- null

function SMessageInitAgain()
{
if(logic_script_system == true)
{
    msg_sound_channel <- EntityGroup[0].GetName()
    return logic_script_system
}
else
{
    msg_sound_channel <- "null name"
}
return false
}

//IV note: Main functions
function ReleaseWarnigMessage(debug_enabled, warning_msg)
{
    SMessageInitAgain()
    msg_warning_messages[msg_w_state_count] = warning_msg
    msg_w_state_count++
    iv_warning_to_debug_initial_count++
    if(iv_warning_to_debug_initial_count == iv_warning_to_debug_count)
    {
        debug_enabled = true
        printl(thsdev_logo+thsdev_warning_logo+"Warning nuber state - "+iv_warning_to_debug_initial_count+". Debug mode enabled!!! Tell a programmer!!!")
        printl(thsdev_logo+thsdev_warning_logo+"List of last "+iv_warning_to_debug_initial_count+" problems:")
        printl(msg_warning_messages[0])
        printl(msg_warning_messages[1])
        printl(msg_warning_messages[2])
        printl(msg_warning_messages[3])
        printl(msg_warning_messages[4])
    }
    if(msg_w_state_count > 4)
    {
        msg_w_state_count = 0
    }
    if(debug_enabled == true)
    {
        EntFire(msg_sound_channel, "PlaySound")
        if(iv_warning_to_debug_initial_count == iv_warning_to_debug_count)
        {
            EntFire(msg_sound_channel, "PlaySound", "", 1)
            EntFire(msg_sound_channel, "PlaySound", "", 2)
            EntFire(msg_sound_channel, "PlaySound", "", 3)
            EntFire(msg_sound_channel, "PlaySound", "", 4)
        }
        printl(thsdev_logo+thsdev_warning_logo+"Found a problem - "+warning_msg)
    }
}

function ReleaseErrorMessage(debug_enabled, error_msg)
{
    SMessageInitAgain()
    debug_enabled = true
    iv_core_error = true
    EntFire(msg_sound_channel, "PlaySound", "")
    EntFire(msg_sound_channel, "PlaySound", "", 1)
    EntFire(msg_sound_channel, "PlaySound", "", 2)
    printl(thsdev_logo+thsdev_error_logo+"Error sended - "+error_msg)
    IVCoreStartup(debug_enabled, "iv_warning_msg_system.nut")
}

function TestSurvivorsMSG()
{
    SMessageInitAgain()
    FindSurvivorAndTakeIT()
    if(l4d_s_mode == 1)
    {
        if(survivor_l4d2_list[0] != null)
        {
            EntFire(msg_sound_channel, "PlaySound", "")
            EntFire(msg_sound_channel, "PlaySound", "", 1)
            EntFire(msg_sound_channel, "PlaySound", "", 2)
            EntFire(msg_sound_channel, "PlaySound", "", 3)
        }
        else if (survivor_l4d2_list[1] != null)
        {
            EntFire(msg_sound_channel, "PlaySound", "")
            EntFire(msg_sound_channel, "PlaySound", "", 1)
            EntFire(msg_sound_channel, "PlaySound", "", 2)
        }
        else if (survivor_l4d2_list[2] != null)
        {
            EntFire(msg_sound_channel, "PlaySound", "")
            EntFire(msg_sound_channel, "PlaySound", "", 1)
        }
        else if (survivor_l4d2_list[3] != null)
        {
            EntFire(msg_sound_channel, "PlaySound", "")
        }
    }
    else if(l4d_s_mode == 2)
    {
        if(survivor_l4d_list[0] != null)
        {
            EntFire(msg_sound_channel, "PlaySound", "")
            EntFire(msg_sound_channel, "PlaySound", "", 1)
            EntFire(msg_sound_channel, "PlaySound", "", 2)
            EntFire(msg_sound_channel, "PlaySound", "", 3)
        }
        else if (survivor_l4d_list[1] != null)
        {
            EntFire(msg_sound_channel, "PlaySound", "")
            EntFire(msg_sound_channel, "PlaySound", "", 1)
            EntFire(msg_sound_channel, "PlaySound", "", 2)
        }
        else if (survivor_l4d_list[2] != null)
        {
            EntFire(msg_sound_channel, "PlaySound", "")
            EntFire(msg_sound_channel, "PlaySound", "", 1)
        }
        else if (survivor_l4d_list[3] != null)
        {
            EntFire(msg_sound_channel, "PlaySound", "")
        }
    }
}