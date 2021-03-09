//******************************************************************************************************
//reaction_f18_voice_select_01_rooftop.nut is called to reaction_f18_voice_select_01_rooftop security...
//******************************************************************************************************
//WarningS_MSG_Number <- 4;
printl("==== calling reaction_f18_voice_select_01_rooftop.nut")
printl("==== [THS] Loading reaction_f18_voice_select_01_rooftop Logic...")


IncludeScript("ths_script_base/reaction_voice_select_base.nut", this)

function SetSoundChannel()
{
  WarningS_MSG_Number <- 4;
}

function PreLoadSceneF18RoofTop()
{
SetSoundChannel()
Debug_Disable()
NickScene <- EntityGroup[0].GetName();
CoachScene <- EntityGroup[3].GetName();
EllisScene <- EntityGroup[2].GetName();
RochelleScene <- EntityGroup[1].GetName();
PriorityReaction <- 1;
  StartUp(debug_enable)
}

function DeleteUnusedScenesRoofTop(debug_enable)
{
  EntFire(EntityGroup[0].GetName(), "Kill", "", 15)
  if(debug_enable == 1)
  {
    printl(EntityGroup[0].GetName()+"Sucessfuly Deleted!!!")
  }
  EntFire(EntityGroup[1].GetName(), "Kill", "", 15)
  if(debug_enable == 1)
  {
    printl(EntityGroup[1].GetName()+"Sucessfuly Deleted!!!")
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

function ReleaseSceneF18RoofTop()
{
  Release(debug_enable)
DeleteUnusedScenesRoofTop(debug_enable)
}