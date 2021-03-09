//******************************************************************************************************
//reaction_test_intro_03_scavenge.nut is called to reaction_test_intro_03_scavenge security...
//******************************************************************************************************
//WarningS_MSG_Number <- 0;
printl("==== calling reaction_test_intro_03_scavenge.nut")
printl("==== [THS] Loading reaction_test_intro_03_scavenge Logic...")


IncludeScript("ths_script_base/reaction_voice_select_base.nut", this)
IncludeScript("ths_script_base/thsdev_game_timer_to_ent_timer.nut", this)

function SetSoundChannel()
{
  WarningS_MSG_Number <- 0;
  debug_enable <- 1;
  ResetGameTimer()
}

function PreLoadSceneUnnPlace()
{
SetSoundChannel()
Debug_Enable()
NickScene <- EntityGroup[1].GetName();
CoachScene <- EntityGroup[2].GetName();
EllisScene <- EntityGroup[3].GetName();
RochelleScene <- EntityGroup[4].GetName();
PriorityReaction <- 1;
  StartUp(debug_enable)
}

function DeleteUnusedScenesUnn(debug_enable)
{
  EntFire(EntityGroup[1].GetName(), "Kill", "", 15)
  if(debug_enable == 1)
  {
    printl(EntityGroup[1].GetName()+"Sucessfuly Deleted!!!")
  }
  EntFire(EntityGroup[4].GetName(), "Kill", "", 15)
  if(debug_enable == 1)
  {
    printl(EntityGroup[4].GetName()+"Sucessfuly Deleted!!!")
  }
  EntFire(EntityGroup[2].GetName(), "Kill", "", 15)
  if(debug_enable == 1)
  {
    printl(EntityGroup[2].GetName()+"Sucessfuly Deleted!!!")
  }
  EntFire(EntityGroup[3].GetName(), "Kill", "", 15)
  if(debug_enable == 1)
  {
    printl(EntityGroup[3].GetName()+"Sucessfuly Deleted!!!")
  }
}

function NextTestScenePreloadAndLoad()
{
PreLoadSceneUnnPlace()
Release(debug_enable)
DeleteUnusedScenesUnn(debug_enable)
SelfDestructOnFalse(1, debug_enable, 1)
}