//******************************************************************************************************
//thsdev_dummy_finder_actors.nut is called to thsdev_dummy_finder_actors security...
//******************************************************************************************************
printl("==== calling thsdev_dummy_finder_actors.nut")
printl("==== [THS] Loading thsdev_dummy_finder_actors Logic...")

IncludeScript("map_lonley_city_series/survival_founder_base.nut", this)


function KillDeadPlayerDummys(debug_enable)
{
    if (nick_counter)
    {
        if(debug_enable == 1)
        {
            printl(EntityGroup[0].GetName()+"Nick - was Allived!!!")
        }
    }
    else
    {
        EntFire(EntityGroup[0].GetName(), "Kill")
    }
    if (coach_counter)
    {
        if(debug_enable == 1)
        {
            printl(EntityGroup[1].GetName()+"Coach - was Allived!!!")
        }
    }
    else
    {
        EntFire(EntityGroup[1].GetName(), "Kill")
    }
    if (ellis_counter)
    {
        if(debug_enable == 1)
        {
            printl(EntityGroup[2].GetName()+"Ellis - was Allived!!!")
        }
    }
    else
    {
        EntFire(EntityGroup[2].GetName(), "Kill")
    }
    if (rochelle_counter)
    {
        if(debug_enable == 1)
        {
            printl(EntityGroup[3].GetName()+"Rochelle - was Allived!!!")
        }
    }
    else
    {
        EntFire(EntityGroup[3].GetName(), "Kill")
    }
}

function SelectFinalSceneAlivedActors()
{
    CallSurvivorsBy(1)
    KillDeadPlayerDummys(debug_enable)
    SelfDestructOnFalse(1, debug_enable, 1)
}