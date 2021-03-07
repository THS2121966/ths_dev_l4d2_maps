//********************************************************************************************
//debug_flyby_spawner.nut is called to debug_flyby_spawner security...
//********************************************************************************************
printl("==== calling debug_flyby_spawner.nut")
printl("==== [THS] Loading debug_flyby_spawner Logic...")

IncludeScript("map_lonley_city_series/thsdev_warning_system_core.nut", this)

//ths_dev_add_outputs
self.ConnectOutput ("OnEntitySpawned", "debug_create_msg")

function debug_create_msg()
{
if(debug_enable == 1)
{
 EntFire (self.GetName(), "FireUser1")
printl("==== ths_dev_msg_f18_spawned!!!")
}
}