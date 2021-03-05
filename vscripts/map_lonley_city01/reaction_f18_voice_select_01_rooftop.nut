//******************************************************************************************************
//reaction_f18_voice_select_01_rooftop.nut is called to reaction_f18_voice_select_01_rooftop security...
//******************************************************************************************************
printl("==== calling reaction_f18_voice_select_01_rooftop.nut")
printl("==== [THS] Loading reaction_f18_voice_select_01_rooftop Logic...")

//thsdev_debug_parms
debug_enable <- 1;

//thsdev_actor_names
Nick_Actor <- null;
Nick_Count <- 0;
Ellis_Actor <- null;
Ellis_Count <- 0;
Rochelle_Actor <- null;
Rochelle_Count <- 0;
Coach_Actor <- null;
Coach_Count <- 0;

//thsdev_begining_actor
Priority_Actor_Voiceline <- null;

function SetupActors()
{
 Nick_Actor = Entities.FindByName(null, "!nick");
 Ellis_Actor = Entities.FindByName(null, "!ellis");
 Rochelle_Actor = Entities.FindByName(null, "!rochelle")
 Coach_Actor = Entities.FindByName(null, "!coach");
}

SetupActors()

function check_actors (debug_enable)
{
 if(debug_enable == 1)
 {
  if(Nick_Actor == Entities.FindByName(null, "!nick"))
  {
   Msg ("[THS Script] Person Named" )
   Msg ( Nick_Actor )
   Msg ("- Initialised" )
   Nick_Count <- 1;
  }
  else if (Nick_Actor == null)
  {
   Msg ( Nick_Actor )
   Msg ("- Not Initialised" )
   return false;
  }
  if(Ellis_Actor == Entities.FindByName(null, "!ellis"))
  {
   Msg ("[THS Script] Person Named" )
   Msg ( Ellis_Actor )
  Msg ("- Initialised" )
   Ellis_Count <- 1;
  }
  else if (Ellis_Actor == null)
  {
   Msg ( Ellis_Actor )
   Msg ("- Not Initialised" )
   return false;
  }
  if(Rochelle_Actor == Entities.FindByName(null, "!rochelle"))
  {
   Msg ("[THS Script] Person Named" )
   Msg ( Rochelle_Actor )
  Msg ("- Initialised" )
   Rochelle_Count <- 1;
  }
  else if (Rochelle_Count == null)
  {
   Msg ( Rochelle_Actor )
   Msg ("- Not Initialised" )
   return false;
  }
  if(Coach_Actor == Entities.FindByName(null, "!coach"))
  {
   Msg ("[THS Script] Person Named" )
   Msg ( Coach_Actor )
  Msg ("- Initialised" )
   Coach_Count <- 1;
  }
  else if (Coach_Actor == null)
  {
   Msg ( Coach_Actor )
   Msg ("- Not Initialised" )
   return false;
  }
 }
   printl ("[THS Script] Voice Actors - Initialised" )
}

/*if( Nick_Actor == null && Ellis_Actor == null && Coach_Actor == null && Rochelle_Actor == null )
{
 Priority_Actor_Voiceline <- null;
}*/

function actor_play_once_reaction(Priority_Actor_Voiceline)
{
if (Priority_Actor_Voiceline == null)
{
printl ("[THS Script] NO Actors - Ending Process...")
return;
}
else
{
 EntFire (Priority_Actor_Voiceline, "Start")
// EntFire (self.GetName(), "Kill", "0", 1)
}
}

check_actors(debug_enable)

function Actor_Scene_Set()
{
SetupActors()
check_actors(debug_enable)

if(Nick_Count == 1)
{
 Priority_Actor_Voiceline <- EntityGroup[0].GetName()
}
else if(Coach_Count == 1 && Nick_Actor == null )
{
 Priority_Actor_Voiceline <- EntityGroup[3].GetName()
}
else if(Ellis_Count == 1 && Nick_Actor == null && Coach_Actor == null)
{
 Priority_Actor_Voiceline <- EntityGroup[2].GetName()
}
else if(Rochelle_Count == 1 && Nick_Actor == null && Coach_Actor == null && Ellis_Actor == null)
{
 Priority_Actor_Voiceline <- EntityGroup[1].GetName()
}
else if( Nick_Actor == null && Ellis_Actor == null && Coach_Actor == null && Rochelle_Actor == null )
{
Msg("Error Playing scene File -")
Msg(Priority_Actor_Voiceline)
 return;
}

Msg("Playing Scene Ent Name - ")
Msg( Priority_Actor_Voiceline )
actor_play_once_reaction(Priority_Actor_Voiceline)
}