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

survivors_by_name <-
{
   coach = "!coach",
   ellis = "!ellis",
   nick = "!nick",
   rochelle = "!rochelle"
}

survivors_found <- 0 // flag set to true once survivors are found
survivors_found_named <- 0 // flag set to true once survivors are found
survivor_by_name <- 0


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
      ReloadSurvivorList()
    }
    else
    {
      printl(s+" NOT FOUND!: "+survivor);
      survivors[s] = null
    }
   }
}

function FindSurvivorsByNames()
{
   foreach(s,n in survivors_by_name)
   {
    printl ("looking for "+s+" Name:"+n);
    survivor_n <- Entities.FindByName(null, n)
    if (survivor_n)
    {
      printl(s+" found: "+survivor_n);
      survivors_by_name[s] = survivor_n
      survivors_found_named++
      ReloadSurvivorList()
    }
    else
    {
      printl(s+" NOT FOUND!: "+survivor_n);
      survivors_by_name[s] = null
    }
   }
}

function CallSurvivorsBy(survivor_by_name)
if(survivor_by_name == 1)
{
  FindSurvivorsByNames()
}
else
{
  FindSurvivors()
}

function ReloadSurvivorList()
{
nick_counter <- Entities.FindByName(null, "!nick")
coach_counter <- Entities.FindByName(null, "!coach")
ellis_counter <- Entities.FindByName(null, "!ellis")
rochelle_counter <- Entities.FindByName(null, "!rochelle")
}

function ResetSurvivorsList()
{
survivors_found <- 0 // flag set to true once survivors are found
survivors_found_named <- 0 // flag set to true once survivors are found
ReloadSurvivorList()
}