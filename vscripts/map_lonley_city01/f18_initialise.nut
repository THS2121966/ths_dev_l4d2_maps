//********************************************************************************************
//f18_initialise.nut is called to f18_initialise system...
//********************************************************************************************
printl("==== calling f18_initialise.nut")
printl("==== [THS] Loading f18_initialise Logic...")

//ths_dev_add_outputs
self.ConnectOutput ("OnTrigger", "f18_sartup")

function f18_sartup()
{
 EntFire ("case_time_flyby_sky_vehicle_group_01", "PickRandom")
}