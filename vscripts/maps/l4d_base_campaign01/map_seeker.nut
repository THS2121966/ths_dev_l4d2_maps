////////////////////////////////////////// THS inc 2021. //////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////// This script created for map controlling and bug fixing... //////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//IV note: Includes presented and added down below
IncludeScript("ths_scripts_base/iv_warning_msg_system.nut", this) //MSG and Core Script manager (base commands and Start, Shutdow system)
logic_script_system <- true
IVCoreStartup(debug_enabled, "map_seeker.nut")

map_ver <- 412;

//IV Note: Class "MapSeekerMain" Created for main stability check functions... And Calculator.
class MapSeekerMain
{
    map_ver = 0;
    thsdev_logo = "null"
    thsdev_warning_logo = "null"
    thsdev_map_seeker_logo = "[Map Seeker] "

    drawtime_enabled = false;

    function CheckMapVersion() {
       if(map_ver != null && map_ver > 0)
       {
           printl(thsdev_logo+thsdev_map_seeker_logo+"Currient map version is - "+map_ver)
           return map_ver
       }
       else
       {
           ::ReleaseWarnigMessage(true, thsdev_map_seeker_logo+"Map Version is Unknow!!! Debug Mode forced Enabled!!!")
       }
       return null;
    }
    function CurrientTime(drawtime_enabled) {
        local TimeIn = Time()
        if(TimeIn != 0)
        {
            if(drawtime_enabled == true)
            {
                printl(thsdev_logo+thsdev_map_seeker_logo+"Currient map time is: "+TimeIn)
            }
            return TimeIn
        }
    }
}

map_seeker_m <- MapSeekerMain()
map_seeker_m.map_ver = map_ver
map_seeker_m.thsdev_logo = thsdev_logo
map_seeker_m.thsdev_warning_logo = thsdev_warning_logo

function EnableDrawTime(state) {
    if(state == true)
    {
        map_seeker_m.drawtime_enabled = true
    }
    else
    {
        map_seeker_m.drawtime_enabled = false
    }
return map_seeker_m.drawtime_enabled
}

function CheckTime() {
    map_seeker_m.CurrientTime(map_seeker_m.drawtime_enabled)
}

function ReleasePostSpawn() {
    local ver_init = map_seeker_m.CheckMapVersion()
    if ( ver_init && ver_init != null )
    {
        printl(thsdev_logo+map_seeker_m.thsdev_map_seeker_logo+"Map Seeker Version Check was Done!!!")
        AddThinkToEnt(self, "CheckTime")
        //EnableDrawTime(true)
    }
}

ReleasePostSpawn()

