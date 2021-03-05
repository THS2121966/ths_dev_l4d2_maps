//********************************************************************************************
//debug_flyby_spawner.nut is called to debug_flyby_spawner security...
//********************************************************************************************
printl("==== calling debug_flyby_spawner.nut")
printl("==== [THS] Loading debug_flyby_spawner Logic...")

//ths_dev_add_outputs
self.ConnectOutput ("OnEntitySpawned", "debug_create_msg")

function debug_create_msg()
{
 EntFire (self.GetName(), "FireUser1")
printl("==== ths_dev_msg_f18_spawned!!!")
}