////////////////////////////////////////// THS inc 2021. //////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////// This is BASE for iv script projects... Start and Shutdown logic. ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//IV Parms:
thsdev_logo <- "[IV Script System] "
thsdev_warning_logo <- "[Warning] "
thsdev_error_logo <- "[Error!!!] "

debug_enabled <- false
iv_core_error <- false
iv_warning_to_debug_count <- 5
iv_warning_to_debug_initial_count <- 0

z_strign <- "0..."
z_string_function <- "FIXME!!!"
test_load_first <- true
zero_to_ten <- 0

survivor_l4d2_list <- [
survivor_nick <- null
survivor_coach <- null
survivor_ellis <- null
survivor_rochelle <- null
]

l4d_s_mode <- 1 // use 1 for l4d2 survivors or 2 for l4d
l4d_s_count <- 0 // added more then survivors has spawned

survivor_l4d_list <- [
survivor_bill <- null
survivor_francis <- null
survivor_louis <- null
survivor_zoey <- null
]

    function TestLoad(z_string_function_local)
    {
        if(zero_to_ten < 10)
        {
            if(test_load_first == true)
            {
                test_load_first = false
                z_string_function = z_string_function_local
                zero_to_ten++
                z_strign = z_string_function+": "+z_strign+zero_to_ten+"..."
            }
            else
            {
                zero_to_ten++
                z_strign = z_strign+zero_to_ten+"..."
            }
            if(debug_enabled = true)
            {
                printl(z_strign)
            }
            TestLoad(z_string_function)
        }
        else if(zero_to_ten == 10)
        {
            zero_to_ten = 0
			test_load_first = true
            z_strign = z_strign+" - Done!!!"
            z_string_function = "Nope..."
            printl(z_strign)
            z_strign = "0..."
            return true
        }
    }


function IVCoreErrorShutdown()
{
    printl(thsdev_logo+thsdev_error_logo+"Core system Sutdown with ERROR!!! State...")
    TestLoad("IVCoreErrorShutdown()")
    EntFire("!self", "Kill")
}

function IVCoreSafeShutdown(UsedScriptName)
{
    if(debug_enabled == true)
    {
        printl(thsdev_logo+"Shutdown that Script System... "+UsedScriptName)
    }
    TestLoad("IVCoreSafeShutdown("+UsedScriptName+")")
    EntFire("!self", "Kill", "", 1)
}

function IVCoreStartup(debug_enabled, UsedScriptName)
{
    if (debug_enabled == true)
    {
        printl(thsdev_logo+"Startup Main IV Core Logic for... "+UsedScriptName)
    }
    if(iv_core_error == true)
    {
        IVCoreErrorShutdown()
        return false
    }
    else
    {
        TestLoad("IVCoreStartup("+debug_enabled+", "+UsedScriptName+")")
        if(debug_enabled == true)
        {
            printl(thsdev_logo+"Testing Core complete!!!")
        }
    }
    return true
}


//IV note: Find player functions
function FindSurvivorAndTakeIT()
{
/* Should return something like this in console
models/survivors/survivor_teenangst.mdl
models/survivors/survivor_namvet.mdl
models/survivors/survivor_biker.mdl
models/survivors/survivor_manager.mdl
*/

//taked_from: https://developer.valvesoftware.com/wiki/L4D2_Vscript_Examples

local player = null
local l4d_s_count_local = 0
while( player = Entities.FindByClassname(player, "player") )
{
    if(debug_enabled == true)
    {
        printl( thsdev_logo+"Survivor Named: "+player.GetModelName()+" - Initialised Sucessful!!! Taking order..." )
    }
    if(l4d_s_mode == 1)
    {
        if(player.GetModelName() == "models/survivors/survivor_gambler.mdl")
        {
            survivor_l4d2_list[0] = player.GetModelName()
            if(survivor_l4d2_list[0] != null)
            {
                printl( thsdev_logo+"Taking order for: "+survivor_l4d2_list[0]+" - Initialised Sucessfull!!!" )
            }
            l4d_s_count_local = l4d_s_count_local + 1
        }
        else if(player.GetModelName() == "models/survivors/survivor_coach.mdl")
        {
            survivor_l4d2_list[1] = player.GetModelName()
            if(survivor_l4d2_list[1] != null)
            {
                printl( thsdev_logo+"Taking order for: "+survivor_l4d2_list[1]+" - Initialised Sucessfull!!!" )
            }
            l4d_s_count_local = l4d_s_count_local + 1
        }
        else if(player.GetModelName() == "models/survivors/survivor_mechanic.mdl")
        {
            survivor_l4d2_list[2] = player.GetModelName()
            if(survivor_l4d2_list[2] != null)
            {
                printl( thsdev_logo+"Taking order for: "+survivor_l4d2_list[2]+" - Initialised Sucessfull!!!" )
            }
            l4d_s_count_local = l4d_s_count_local + 1
        }
        else if(player.GetModelName() == "models/survivors/survivor_producer.mdl")
        {
            survivor_l4d2_list[3] = player.GetModelName()
            if(survivor_l4d2_list[3] != null)
            {
                printl( thsdev_logo+"Taking order for: "+survivor_l4d2_list[3]+" - Initialised Sucessfull!!!" )
            }
            l4d_s_count_local = l4d_s_count_local + 1
        }
    }
    else if(l4d_s_mode == 2)
    {
        if(player.GetModelName() == "models/survivors/survivor_namvet.mdl")
        {
            survivor_l4d_list[0] = player.GetModelName()
            if(survivor_l4d_list[0] != null)
            {
                printl( thsdev_logo+"Taking order for: "+survivor_l4d_list[0]+" - Initialised Sucessfull!!!" )
            }
            l4d_s_count_local = l4d_s_count_local + 1
        }
        else if(player.GetModelName() == "models/survivors/survivor_biker.mdl")
        {
            survivor_l4d_list[1] = player.GetModelName()
            if(survivor_l4d_list[1] != null)
            {
                printl( thsdev_logo+"Taking order for: "+survivor_l4d_list[1]+" - Initialised Sucessfull!!!" )
            }
            l4d_s_count_local = l4d_s_count_local + 1
        }
        else if(player.GetModelName() == "models/survivors/survivor_manager.mdl")
        {
            survivor_l4d_list[2] = player.GetModelName()
            if(survivor_l4d_list[2] != null)
            {
                printl( thsdev_logo+"Taking order for: "+survivor_l4d_list[2]+" - Initialised Sucessfull!!!" )
            }
            l4d_s_count_local = l4d_s_count_local + 1
        }
        else if(player.GetModelName() == "models/survivors/survivor_teenangst.mdl")
        {
            survivor_l4d_list[3] = player.GetModelName()
            if(survivor_l4d_list[3] != null)
            {
                printl( thsdev_logo+"Taking order for: "+survivor_l4d_list[3]+" - Initialised Sucessfull!!!" )
            }
            l4d_s_count_local = l4d_s_count_local + 1
        }
    }
}
TestLoad("FindSurvivorAndTakeIT()")
l4d_s_count = l4d_s_count_local
if(debug_enabled == true)
{
    printl(thsdev_logo+"Total Survivor Count = "+l4d_s_count)
    printl(thsdev_logo+"Total Survivor Count = "+l4d_s_count)
    printl(thsdev_logo+"Total Survivor Count = "+l4d_s_count)
    printl(thsdev_logo+"Total Survivor Count = "+l4d_s_count)
    printl(thsdev_logo+"Total Survivor Count = "+l4d_s_count)
}
return l4d_s_count
}

