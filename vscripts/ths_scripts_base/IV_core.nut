////////////////////////////////////////// THS inc 2021. //////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////// This is BASE for iv script projects... Start and Shutdown logic. ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//IV Parms:
thsdev_logo <- "[IV Script System] "
thsdev_warning_logo <- "[Warning] "
thsdev_error_logo <- "[Error!!!] "

debug_enabled <- false
iv_core_error <- false
iv_core_shutdown <- false
iv_warning_to_debug_count <- 5
iv_warning_to_debug_initial_count <- 0


function IVCoreStartup(debug_enabled, UsedScriptName)
{
    if (debug_enabled == true)
    {
        printl(thsdev_logo+"Startup Main IV Core Logic for... "+UsedScriptName)
    }
    if(iv_core_error == true)
    {
        return iv_core_shutdown = true
    }
    else
    {
        if(debug_enabled == true)
        {
            printl(thsdev_logo+"Testing Core complete!!!")
        }
    }
}