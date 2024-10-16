////////////////////////////////////////// THS inc 2021. //////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////// This script created for map controlling and bug fixing... //////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//IV note: Includes presented and added down below
IncludeScript("maps/l4d_cannals_escape_test_series/ths_scripts_base/iv_warning_msg_system.nut", this) //MSG and Core Script manager (base commands and Start, Shutdow system)
logic_script_system <- true
iv_core <- IVCoreStartup(debug_enabled, "map_seeker.nut")

map_name <- Director.GetMapName();
debug_enabled <- true //Disable before RELEASE!!!

//IV Note: Class "MapSeekerMain" Created for main stability check functions... And Calculator.
class MapSeekerMain
{
    map_name = "Null... Fix Me!!!"
    thsdev_logo = "null"
    thsdev_warning_logo = "null"
    thsdev_map_seeker_logo = "[Map Seeker] "

    iv_debug_enabled = false;

    function CheckMapName() {
       if(map_name != "Null... Fix Me!!!" && map_name != null)
       {
           ::printl(thsdev_logo+thsdev_map_seeker_logo+"Currient map Name is - "+map_name)
           return map_name
       }
       else
       {
           ::ReleaseWarnigMessage(true, thsdev_map_seeker_logo+"Map Name is Unknow!!! Debug Mode forced Enabled!!!")
       }
       return null;
    }
}

map_seeker_m <- MapSeekerMain()
map_seeker_m.map_name = map_name
map_seeker_m.iv_debug_enabled = debug_enabled
map_seeker_m.thsdev_logo = thsdev_logo
map_seeker_m.thsdev_warning_logo = thsdev_warning_logo


function ReleasePostSpawn() {
    local ver_init = map_seeker_m.CheckMapName()
    if ( ver_init && ver_init != null )
    {
        printl(thsdev_logo+map_seeker_m.thsdev_map_seeker_logo+"Map Seeker Version Check was Done!!!")
        local check_state_done = TestLoad("ReleasePostSpawn()")
        if(check_state_done = true)
        {
            printl(thsdev_logo+map_seeker_m.thsdev_map_seeker_logo+"Map Seeker Startup was Done!!!")
        }
    }
}

ReleasePostSpawn()

