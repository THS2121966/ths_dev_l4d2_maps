////////////////////////////////////////// THS inc 2021. //////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////// This script created for base choreo selecting priority... //////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//IV note: Includes presented and added down below
IncludeScript("maps/l4d_base_campaign01/ths_scripts_base/iv_warning_msg_system.nut", this) //MSG and Core Script manager (base commands and Start, Shutdow system)
logic_script_system <- true

//IV note: Main Parms
choreo_scened_nick <- null
choreo_scened_coach <- null
choreo_scened_ellis <- null
choreo_scened_rochelle <- null
choreo_scened_bill <- null
choreo_scened_francis <- null
choreo_scened_louis <- null
choreo_scened_zoey <- null

order1 <- EntityGroup[1].GetName() //Use EntityGroup in hammer logic_script entity info
order2 <- EntityGroup[2].GetName()
order3 <- EntityGroup[3].GetName()
order4 <- EntityGroup[4].GetName()

/*priority_trigger_order_enabled <- false;
priority_trigger_order <- null;*/


function SafeRelease()
{
    if(l4d_s_mode == 1)
    {
    EntFire(choreo_scened_nick, "kill", "", 5)
    EntFire(choreo_scened_coach, "kill", "", 5)
    EntFire(choreo_scened_ellis, "kill", "", 5)
    EntFire(choreo_scened_rochelle, "kill", "", 5)
    }
    else if(l4d_s_mode == 2)
    {
    EntFire(choreo_scened_bill, "kill", "", 5)
    EntFire(choreo_scened_francis, "kill", "", 5)
    EntFire(choreo_scened_louis, "kill", "", 5)
    EntFire(choreo_scened_zoey, "kill", "", 5)
    }
IVCoreSafeShutdown("iv_choreo_character_select.nut")
}

function InitChoreoPersons(debug_enabled, persons_from_l4d_or_l4d2)
{
    //IV note: Init Main Core.
    IVCoreStartup(debug_enabled, "iv_choreo_character_select.nut")
    local persons_set = persons_from_l4d_or_l4d2
    l4d_s_mode = persons_set
    if(debug_enabled == true)
    {
        TestSurvivorsMSG()
    }
    else
    {
        FindSurvivorAndTakeIT()
    }
}

function TakeChors(debug_enabled, l4d_s_mode)
{
    if(order1 == null || order2 == null || order3 == null || order4 == null)
    {
        ReleaseWarnigMessage(debug_enabled, "Some chors not released!!! Release all of characters, because all of that will be precached!!!")
    }
    if(l4d_s_mode == 1)
    {
        choreo_scened_nick = order1
        choreo_scened_coach = order2
        choreo_scened_ellis = order3
        choreo_scened_rochelle = order4
        if(debug_enabled == true)
        {
            printl(thsdev_logo+"list of chors for l4d2 mode:")
            printl("choreo_scened_nick - "+choreo_scened_nick)
            printl("choreo_scened_coach - "+choreo_scened_coach)
            printl("choreo_scened_ellis - "+choreo_scened_ellis)
            printl("choreo_scened_rochelle - "+choreo_scened_rochelle)
        }
    }
    else if(l4d_s_mode == 2)
    {
        choreo_scened_bill = order1
        choreo_scened_francis = order2
        choreo_scened_louis = order3
        choreo_scened_zoey = order4
        if(debug_enabled == true)
        {
            printl(thsdev_logo+"list of chors for l4d mode:")
            printl("choreo_scened_bill - "+choreo_scened_bill)
            printl("choreo_scened_francis - "+choreo_scened_francis)
            printl("choreo_scened_louis - "+choreo_scened_louis)
            printl("choreo_scened_zoey - "+choreo_scened_zoey)
        }
    }
}

function function ReleaseChoreoOrderSpeak(debug_enabled, persons_from_l4d_or_l4d2_local) //ReleaseChoreoOrderSpeak(debug_enabled, persons_from_l4d_or_l4d2_local, priority_trigger_order_enabled)
{
    InitChoreoPersons(debug_enabled, persons_from_l4d_or_l4d2_local)
    TakeChors(debug_enabled, l4d_s_mode)
/*    if(priority_trigger_order_enabled == true)
    {
        priority_trigger_order <- EntityGroup[5]
    }
    else
    {
        priority_trigger_order = null;
    }*/
    if(l4d_s_mode == 1)
    {
        /*if(priority_trigger_order == null)
        {*/
        if(survivor_l4d2_list[0] != null && choreo_scened_nick != null)
        {
           EntFire(choreo_scened_nick, "Start")
           if (debug_enabled == true)
           {
               printl(thsdev_logo+"Started Choreo "+choreo_scened_nick+" for Actor "+survivor_l4d2_list[0])
           }
        }
        else if(survivor_l4d2_list[1] != null && choreo_scened_coach != null)
        {
           EntFire(choreo_scened_coach, "Start")
           if (debug_enabled == true)
           {
               printl(thsdev_logo+"Started Choreo "+choreo_scened_coach+" for Actor "+survivor_l4d2_list[1])
           }
        }
        else if(survivor_l4d2_list[2] != null && choreo_scened_ellis != null)
        {
           EntFire(choreo_scened_ellis, "Start")
           if (debug_enabled == true)
           {
               printl(thsdev_logo+"Started Choreo "+choreo_scened_ellis+" for Actor "+survivor_l4d2_list[2])
           }
        }
        else if(survivor_l4d2_list[3] != null && choreo_scened_rochelle != null)
        {
           EntFire(choreo_scened_rochelle, "Start")
           if (debug_enabled == true)
           {
               printl(thsdev_logo+"Started Choreo "+choreo_scened_rochelle+" for Actor "+survivor_l4d2_list[3])
           }
        }
        /*}
        else
        {
            local nick = Entities.FindByName(null, "!nick")
            local coach = Entities.FindByName(null, "!coach")
            local ellis = Entities.FindByName(null, "!ellis")
            local rochelle = Entities.FindByName(null, "!rochelle")
        if(survivor_l4d2_list[0] != null && priority_trigger_order.IsTouching(nick))
        {
           EntFire(choreo_scened_nick, "Start")
           if (debug_enabled == true)
           {
               printl(thsdev_logo+"Started Choreo "+choreo_scened_nick+" for Actor "+survivor_l4d2_list[0])
           }
        }
        else if(survivor_l4d2_list[1] != null && priority_trigger_order.IsTouching(coach))
        {
           EntFire(choreo_scened_coach, "Start")
           if (debug_enabled == true)
           {
               printl(thsdev_logo+"Started Choreo "+choreo_scened_coach+" for Actor "+survivor_l4d2_list[1])
           }
        }
        else if(survivor_l4d2_list[2] != null && priority_trigger_order.IsTouching(ellis))
        {
           EntFire(choreo_scened_ellis, "Start")
           if (debug_enabled == true)
           {
               printl(thsdev_logo+"Started Choreo "+choreo_scened_ellis+" for Actor "+survivor_l4d2_list[2])
           }
        }
        else if(survivor_l4d2_list[3] != null && priority_trigger_order.IsTouching(rochelle))
        {
           EntFire(choreo_scened_rochelle, "Start")
           if (debug_enabled == true)
           {
               printl(thsdev_logo+"Started Choreo "+choreo_scened_rochelle+" for Actor "+survivor_l4d2_list[3])
           }
        }
        }*/
    }
    else if(l4d_s_mode == 2)
    {
        if(survivor_l4d_list[0] != null && choreo_scened_bill != null)
        {
           EntFire(choreo_scened_bill, "Start")
           if (debug_enabled == true)
           {
               printl(thsdev_logo+"Started Choreo "+choreo_scened_bill+" for Actor "+survivor_l4d_list[0])
           }
        }
        else if(survivor_l4d_list[1] != null && choreo_scened_francis != null)
        {
           EntFire(choreo_scened_francis, "Start")
           if (debug_enabled == true)
           {
               printl(thsdev_logo+"Started Choreo "+choreo_scened_francis+" for Actor "+survivor_l4d_list[1])
           }
        }
        else if(survivor_l4d_list[2] != null && choreo_scened_louis != null)
        {
           EntFire(choreo_scened_louis, "Start")
           if (debug_enabled == true)
           {
               printl(thsdev_logo+"Started Choreo "+choreo_scened_louis+" for Actor "+survivor_l4d_list[2])
           }
        }
        else if(survivor_l4d_list[3] != null && choreo_scened_zoey != null)
        {
           EntFire(choreo_scened_zoey, "Start")
           if (debug_enabled == true)
           {
               printl(thsdev_logo+"Started Choreo "+choreo_scened_zoey+" for Actor "+survivor_l4d_list[3])
           }
        }
    }
//if(priority_trigger_order_enabled != true)
//{
SafeRelease()
//}
}

