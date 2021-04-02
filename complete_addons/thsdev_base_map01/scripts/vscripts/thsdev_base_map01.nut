Msg(" thsdev_base_map01 map script "+"\n")

// number of cans needed to escape.

if ( Director.IsSinglePlayerGame() )
{
	NumCansNeeded <- 8
}
else
{
	NumCansNeeded <- 12
}

// This script is called on MapSpawn, so the CommonLimit is for play before the finale start.
DirectorOptions <-
{
	
CommonLimit = 8

}

NavMesh.UnblockRescueVehicleNav() // Unblock so humans can be rescued when incapped near nozzle

EntFire( "scavenge_display", "SetTotalItems", NumCansNeeded ) //Set number of cans with scavenge_display
EntFire( "math_scavenge_display", "SetHitMax", NumCansNeeded ) //Set number of cans with math_scavenge_display


function GasCanPoured(){} // Declaration of function, but was moved to main finale script