/*
findsurvivors.nut
author: Lee Pumphret
http://www.leeland.net

The survivors table, once initialized, holds an entity reference to all survivors
To reference a specific survivor, you can say
survivors.nick (etc...)
*/

IncludeScript("map_lonley_city_series/thsdev_warning_system_core.nut", this)

//thsdev_counters
nick_counter <- Entities.FindByName(null, "!nick")
coach_counter <- Entities.FindByName(null, "!coach")
ellis_counter <- Entities.FindByName(null, "!ellis")
rochelle_counter <- Entities.FindByName(null, "!rochelle")

PriorityReaction <- 1;

survivors <-
{
   coach = "models/survivors/survivor_coach.mdl",
   ellis = "models/survivors/survivor_mechanic.mdl",
   nick = "models/survivors/survivor_gambler.mdl",
   rochelle = "models/survivors/survivor_producer.mdl"
}

survivors_found <- 0 // flag set to true once survivors are found

/*
Find survivors, this needs to be called after a delay. If you call it immediately,
it will fail as they have not been loaded yet, 10 sec after map load should be good.
You can call it with a logic_auto output, runscriptcode FindSurvivors()
*/
function FindSurvivors()
{
   foreach(s,m in survivors)
   {
    printl ("looking for "+s+" mdl:"+m);
    survivor <- Entities.FindByModel(null, m)
    if (survivor)
    {
      printl(s+" found: "+survivor);
      survivors[s] = survivor
      survivors_found++
    }
    else
    {
      printl(s+" NOT FOUND!: "+survivor);
      survivors[s] = null
    }
   }
}