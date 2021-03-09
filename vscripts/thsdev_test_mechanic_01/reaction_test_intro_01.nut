//******************************************************************************************************
//reaction_test_intro_01.nut is called to reaction_test_intro_01 security...
//******************************************************************************************************
//WarningS_MSG_Number <- 0;
printl("==== calling reaction_test_intro_01.nut")
printl("==== [THS] Loading reaction_test_intro_01 Logic...")


IncludeScript("ths_script_base/reaction_voice_select_base.nut", this)

function SetSoundChannel()
{
  WarningS_MSG_Number <- 0;
}

function PreLoadSceneUnnPlace()
{
SetSoundChannel()
//Debug_Disable()
NickScene <- EntityGroup[1].GetName();
CoachScene <- EntityGroup[4].GetName();
EllisScene <- EntityGroup[2].GetName();
RochelleScene <- EntityGroup[3].GetName();
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

function ReleaseSceneUnn()
{
  Release(debug_enable)
DeleteUnusedScenesUnn(debug_enable)
SelfDestructOnFalse(1, debug_enable, 1)
}