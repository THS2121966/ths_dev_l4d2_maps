//********************************************************************************************
//timer_indentificator.nut is called to timer_indentificator system...
//********************************************************************************************
printl("==== calling timer_indentificator.nut")
printl("==== [THS] Loading timer_indentificator Logic...")

//ths_dev_add_outputs
self.ConnectOutput ("OnTimer", "timers_reset")

//thsdev_check_timer_map_names
timer_flyby_sky_vehicle_group_01_15_sec_local <- Entities.FindByName(null, "timer_flyby_sky_vehicle_group_01_15_sec");
timer_flyby_sky_vehicle_group_01_30_sec_local <- Entities.FindByName(null, "timer_flyby_sky_vehicle_group_01_30_sec");
timer_flyby_sky_vehicle_group_01_60_sec_local <- Entities.FindByName(null, "timer_flyby_sky_vehicle_group_01_60_sec");
timer_flyby_sky_vehicle_group_01_120_sec_local <- Entities.FindByName(null, "timer_flyby_sky_vehicle_group_01_120_sec");


function timer_check()
{
 EntFire (self.GetName(), "Enable")
 if (self.GetName() == timer_flyby_sky_vehicle_group_01_15_sec_local.GetName() )
 {
  printl("==== [Radio Informer] F18 Group is will arrive to point at 15 sec.\n")
 }
 else if (self.GetName() == timer_flyby_sky_vehicle_group_01_30_sec_local.GetName() )
 {
  printl("==== [Radio Informer] F18 Group is will arrive to point at 30 sec.\n")
 }
 else if (self.GetName() == timer_flyby_sky_vehicle_group_01_60_sec_local.GetName() )
 {
  printl("==== [Radio Informer] F18 Group is will arrive to point at 1 min.\n")
 }
 else if (self.GetName() == timer_flyby_sky_vehicle_group_01_120_sec_local.GetName() )
 {
  printl("==== [Radio Informer] F18 Group is will arrive to point at 2 min.\n")
 }
}

function timers_reset()
{
 EntFire ("case_time_flyby_sky_vehicle_group_01", "PickRandom", "0", 15)
printl("==== [Radio Informer] Relax in progress, wait 15 sec.\n")
}