//******************************************************************************************************
//reaction_f18_voice_select_01_rooftop.nut is called to reaction_f18_voice_select_01_rooftop security...
//******************************************************************************************************
//WarningS_MSG_Number <- 4;
printl("==== calling reaction_f18_voice_select_01_rooftop.nut")
printl("==== [THS] Loading reaction_f18_voice_select_01_rooftop Logic...")


IncludeScript("map_lonley_city_series/reaction_voice_select_base.nut", this)

function SetSoundChannel()
{
  WarningS_MSG_Number <- 4;
}

function PreLoadSceneF18RoofTop()
{
SetSoundChannel()
NickScene <- EntityGroup[0].GetName();
CoachScene <- EntityGroup[3].GetName();
EllisScene <- EntityGroup[2].GetName();
RochelleScene <- EntityGroup[1].GetName();
PriorityReaction <- 1;
  StartUp(0)
}

function ReleaseSceneF18RoofTop()
{
  Release(0)
  SelfDestructOnFalse(1, 0)
}