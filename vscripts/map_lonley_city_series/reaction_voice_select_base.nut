//******************************************************************************************************
//reaction_voice_select_base.nut is called to reaction_voice_select_base security...
//******************************************************************************************************
printl("==== calling reaction_voice_select_base.nut")
printl("==== [THS] Loading reaction_voice_select_base Logic...")

IncludeScript("map_lonley_city_series/survival_founder_base.nut", this)

//thsdev_senes_variations
SceneThis <- null;
NickScene <- null;
CoachScene <- null;
EllisScene <- null;
RochelleScene <- null;

function ResetToDefault(debug_enable)
{
SceneThis <- null;
NickScene <- null;
CoachScene <- null;
EllisScene <- null;
RochelleScene <- null;
if(debug_enable)
{
    printl("Reseting to Default...")
}
ResetSurvivorsList()
}

function Priority (debug_enable)
{
    if( nick_counter )
    {
        SceneThis <- NickScene;
    if (debug_enable)
      {
          msg_warning <- "[THS_Script] Actor Scene For Nick - Initialised!!!"
          Warning(WarningS_MSG_Number, 1)
      }
    return;
    }
    else if ( coach_counter )
    {
        SceneThis <- CoachScene;
    if (debug_enable)
      {
          msg_warning <- "[THS_Script] Actor Scene For Coach - Initialised!!!"
          Warning(WarningS_MSG_Number, 1)
      }
    return;
    }
    else if ( ellis_counter )
    {
        SceneThis <- EllisScene;
    if (debug_enable)
      {
          msg_warning <- "[THS_Script] Actor Scene For Ellis - Initialised!!!"
          Warning(WarningS_MSG_Number, 1)
      }
    return;
    }
    else if ( rochelle_counter )
    {
        SceneThis <- RochelleScene;
    if (debug_enable)
      {
          msg_warning <- "[THS_Script] Actor Scene For Rochelle - Initialised!!!"
          Warning(WarningS_MSG_Number, 1)
      }
    return;
    }
}

function AddPriority(debug_enable)
{
Priority(debug_enable)

if (debug_enable)
{
    msg_warning <- "[THS_Script] All Founded Actors Initialised!!!"
    Warning(WarningS_MSG_Number, 1)
}
}

function StartUp(debug_enable)
{
    FindSurvivors()
    if(survivors_found == 0 || ellis_counter == 0 && nick_counter == 0 && rochelle_counter == 0 && coach_counter == 0)
    {
    msg_warning <- "[THS_Script] Error!!! No Survivors!!!"
    Warning(WarningS_MSG_Number, 5)
        if(debug_enable)
        {
            printl("[THS_Script] Error!!! No Survivors!!!")
        }
    }
    else
    {
        if(PriorityReaction == 1)
        {
        AddPriority(debug_enable)
        }
    }
}

function Release(debug_enable)
{
    if(SceneThis == null)
    {
        printl("Scene not Found!!! -")
        printl(SceneThis)
        msg_warning <- "[THS_Script] Scene not Found!!!"
        Warning(WarningS_MSG_Number, 5)
    }
    else
    {
        EntFire(SceneThis, "Start")
        if(debug_enable)
        {
            printl("Scene started -"+SceneThis)
        }
        ResetToDefault(debug_enable)
    }
}