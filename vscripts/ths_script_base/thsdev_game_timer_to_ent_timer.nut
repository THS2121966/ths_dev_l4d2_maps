//thsdev_timer_created_by_s.i.a_ths
printl("Executing - thsdev_game_timer_to_ent_timer.nut")

IncludeScript("ths_script_base/thsdev_warning_system_core.nut", this)

//thsdev_parms
time_s <- 0;
time_m <- 0;
time_h <- 0;

time_check_s <- null;
time_check_m <- null;
time_Check_h <- null;

//thsdev_outputs
!self.ConnectOutput("OnTimer", "Release_Timer")

function Release_Timer()
{
    Collect_Time(debug_enable, time_check_every_s, time_check_s, time_check_m, time_Check_h)
}

//thsdev_gametime_function
function Collect_Time(debug_enable, time_check_every_s, time_check_s, time_check_m, time_Check_h)
{
    if(time_s == 60)
    {
        time_s <- 0;
        time_m++
        if(time_check_m && debug_enable)
        {
            DrawTimeAuto()
        }
    }
    if(time_m == 60)
    {
        time_m <- 0;
        time_h++
        if(time_Check_h && debug_enable)
        {
            DrawTimeAuto()
        }
    }
time_s++
if(time_check_s && debug_enable)
{
    DrawTimeAuto()
}
}

function DrawTimeAuto()
{
    printl("[THS_Script] Currient Game Time -"+time_h+"_H_"+time_m+"_M_"+time_s+"_S")
}

function draw_only_seconds_msg()
{
time_check_s <- 1;
time_check_m <- null;
time_Check_h <- null;
}

function draw_only_minutes_msg()
{
time_check_s <- null;
time_check_m <- 1;
time_Check_h <- null;
}

function draw_only_hours_msg()
{
time_check_s <- null;
time_check_m <- null;
time_Check_h <- 1;
}

function ResetGameTimer()
{
time_s <- 0;
time_m <- 0;
time_h <- 0;
if(debug_enable)
{
    printl("[THS_Script] Game timer has reseted!!!")
}
}