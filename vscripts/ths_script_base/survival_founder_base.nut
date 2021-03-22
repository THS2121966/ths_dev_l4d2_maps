/*
findsurvivors.nut
author: Lee Pumphret
http://www.leeland.net

The survivors table, once initialized, holds an entity reference to all survivors
To reference a specific survivor, you can say
survivors.nick (etc...)
*/

IncludeScript("ths_script_base/thsdev_warning_system_core.nut", this)

//thsdev_counters
nick_counter <- 0;
coach_counter <- 0;
ellis_counter <- 0;
rochelle_counter <- 0;

nick_health <- null;
coach_health <- null;
ellis_health <- null;
rochelle_health <- null;

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
if(nick_counter)
{
nick_health <- nick_counter.GetHealth()
if(nick_health == -1)
{
  nick_counter <- 0
}
}
coach_counter <- Entities.FindByName(null, "!coach")
if(coach_counter)
{
coach_health <- coach_counter.GetHealth()
if(coach_health == -1)
{
  coach_counter <- 0
}
}
ellis_counter <- Entities.FindByName(null, "!ellis")
if(ellis_counter)
{
ellis_health <- ellis_counter.GetHealth()
if(ellis_health == -1)
{
  ellis_counter <- 0
}
}
rochelle_counter <- Entities.FindByName(null, "!rochelle")
if(rochelle_counter)
{
rochelle_health <- rochelle_counter.GetHealth()
if(rochelle_health == -1)
{
  rochelle_counter <- 0
}
}
if(debug_enable == 1)
{
  printl("Nick Health is -"+nick_health)
  printl("Coach Health is -"+coach_health)
  printl("Ellis Health is -"+ellis_health)
  printl("Rochelle Health is -"+rochelle_health)
  msg_warning <- "[THS_Script] Actors Health - Initialised!!!"
  Warning(WarningS_MSG_Number, 1)
}
}

function ResetSurvivorsList()
{
survivors_found <- 0 // flag set to true once survivors are found
survivors_found_named <- 0 // flag set to true once survivors are found
ReloadSurvivorList()
}