//******************************************************************************************************
//reaction_test_intro_01.nut is called to reaction_test_intro_01 security...
//******************************************************************************************************
//WarningS_MSG_Number <- 0;
printl("==== calling reaction_test_intro_01.nut")
printl("==== [THS] Loading reaction_test_intro_01 Logic...")


IncludeScript("map_lonley_city_series/reaction_voice_select_base.nut", this)

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
  EntFire(NickScene, "Kill", "", 15)
  if(debug_enable == 1)
  {
    printl(NickScene+"Sucessfuly Deleted!!!")
  }
  EntFire(CoachScene, "Kill", "", 15)
  if(debug_enable == 1)
  {
    printl(CoachScene+"Sucessfuly Deleted!!!")
  }
  EntFire(EllisScene, "Kill", "", 15)
  if(debug_enable == 1)
  {
    printl(EllisScene+"Sucessfuly Deleted!!!")
  }
  EntFire(RochelleScene, "Kill", "", 15)
  if(debug_enable == 1)
  {
    printl(RochelleScene+"Sucessfuly Deleted!!!")
  }
}

function ReleaseSceneUnn()
{
  Release(debug_enable)
DeleteUnusedScenesUnn(debug_enable)
}

function NextTestScenePreloadAndLoad()
{
NickScene <- Entities.FindByName(null, "map_chor_next_found_nick");
CoachScene <- Entities.FindByName(null, "map_chor_next_found_coach");
EllisScene <- Entities.FindByName(null, "map_chor_next_found_ellis");
RochelleScene <- Entities.FindByName(null, "map_chor_next_found_rochelle");

NickScene <- NickScene.GetName();
CoachScene <- CoachScene.GetName();
EllisScene <- EllisScene.GetName();
RochelleScene <- RochelleScene.GetName();

if(debug_enable == 1)
{
printl(NickScene)
printl(CoachScene)
printl(EllisScene)
printl(RochelleScene)
}

  StartUp(debug_enable)
  ReleaseSceneUnn()
}