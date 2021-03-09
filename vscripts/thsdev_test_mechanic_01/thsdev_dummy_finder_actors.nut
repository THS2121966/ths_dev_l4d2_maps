//******************************************************************************************************
//thsdev_dummy_finder_actors.nut is called to thsdev_dummy_finder_actors security...
//******************************************************************************************************
printl("==== calling thsdev_dummy_finder_actors.nut")
printl("==== [THS] Loading thsdev_dummy_finder_actors Logic...")

IncludeScript("ths_script_base/survival_founder_base.nut", this)


function KillDeadPlayerDummys(debug_enable)
{
    if (nick_counter)
    {
        if(debug_enable == 1)
        {
            printl(EntityGroup[0].GetName()+"Nick - was Allived!!!")
        }
        if(nick_health > 100 || nick_health <= 30)
        {
            EntFire(EntityGroup[0].GetName(), "SetAnimation", "incap_crawl")
            if(debug_enable == 1)
            {
               printl(EntityGroup[0].GetName()+"Nick - was Damaged!!!") 
            }
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
        if(coach_health > 100 || coach_health <= 30)
        {
            EntFire(EntityGroup[1].GetName(), "SetAnimation", "incap_crawl")
            if(debug_enable == 1)
            {
               printl(EntityGroup[1].GetName()+"Coach - was Damaged!!!") 
            }
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
        if(ellis_health > 100 || ellis_health <= 30)
        {
            EntFire(EntityGroup[2].GetName(), "SetAnimation", "incap_crawl")
            if(debug_enable == 1)
            {
               printl(EntityGroup[2].GetName()+"Ellis - was Damaged!!!") 
            }
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
        if(rochelle_health > 100 || rochelle_health <= 30)
        {
            EntFire(EntityGroup[3].GetName(), "SetAnimation", "incap_crawl")
            if(debug_enable == 1)
            {
               printl(EntityGroup[3].GetName()+"Rochelle - was Damaged!!!") 
            }
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