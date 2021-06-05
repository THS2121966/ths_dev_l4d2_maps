////////////////////////////////////////// THS inc 2021. //////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////// This script created for map controlling and bug fixing... //////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//IV note: Includes presented and added down below
IncludeScript("maps/l4d_cannals_series_shared/ths_scripts_base/iv_warning_msg_system.nut", this) //MSG and Core Script manager (base commands and Start, Shutdow system)
logic_script_system <- true
iv_core <- IVCoreStartup(debug_enabled, "map_seeker.nut")

map_ver <- 129;
debug_enabled <- true //Disable before RELEASE!!!

//IV Note: Class "MapSeekerMain" Created for main stability check functions... And Calculator.
class MapSeekerMain
{
    map_ver = 0;
    z_strign = "0..."
    zero_to_ten = 0
    thsdev_logo = "null"
    thsdev_warning_logo = "null"
    thsdev_map_seeker_logo = "[Map Seeker] "

    iv_debug_enabled = false;

    function CheckMapVersion() {
       if(map_ver != null && map_ver > 0)
       {
           ::printl(thsdev_logo+thsdev_map_seeker_logo+"Currient map version is - "+map_ver)
           return map_ver
       }
       else
       {
           ::ReleaseWarnigMessage(true, thsdev_map_seeker_logo+"Map Version is Unknow!!! Debug Mode forced Enabled!!!")
       }
       return null;
    }
    function TestLoad()
    {
        if(zero_to_ten < 10)
        {
            zero_to_ten++
            z_strign = z_strign+zero_to_ten+"..."
            ::printl(z_strign)
            TestLoad()
        }
        else if(zero_to_ten == 10)
        {
            zero_to_ten = 0
            z_strign = z_strign+" - Done!!!"
            printl(z_strign)
            z_strign = "0..."
            return true
        }
    }
}

map_seeker_m <- MapSeekerMain()
map_seeker_m.map_ver = map_ver
map_seeker_m.iv_debug_enabled = debug_enabled
map_seeker_m.thsdev_logo = thsdev_logo
map_seeker_m.thsdev_warning_logo = thsdev_warning_logo


function ReleasePostSpawn() {
    local ver_init = map_seeker_m.CheckMapVersion()
    if ( ver_init && ver_init != null )
    {
        printl(thsdev_logo+map_seeker_m.thsdev_map_seeker_logo+"Map Seeker Version Check was Done!!!")
        local check_state_done = map_seeker_m.TestLoad()
        if(check_state_done = true)
        {
            printl(thsdev_logo+map_seeker_m.thsdev_map_seeker_logo+"Map Seeker Startup was Done!!!")
        }
        if(debug_enabled == true)
        {
           local test_button01 = EntityGroup[1]
           EntFire(test_button01.GetName(), "Unlock")
        }
    }
}

ReleasePostSpawn()

