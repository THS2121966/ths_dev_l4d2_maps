////////////////////////////////////////// THS inc 2021. //////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////// This script created for base choreo selecting priority... //////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//IV note: Includes presented and added down below
IncludeScript("maps/l4d_cannals_series_shared/ths_scripts_base/iv_warning_msg_system.nut", this) //MSG and Core Script manager (base commands and Start, Shutdow system)
logic_script_system <- true

//IV note: Init Main Core.
iv_core_startup <- IVCoreStartup(debug_enabled, "iv_modified_ep1_character_select.nut")


if(iv_core_startup == true)
{
//IV note: Main Parms
choreo_scened_nick <- null
choreo_scened_coach <- null
choreo_scened_ellis <- null
choreo_scened_rochelle <- null
/*choreo_scened_bill <- null
choreo_scened_francis <- null
choreo_scened_louis <- null
choreo_scened_zoey <- null*/ //Disabled in this script...

priority_table <- {
scened_nick = false
scened_coach = false
scened_ellis = false
scened_rochelle = false
}

order1 <- EntityGroup[1].GetName() //Use EntityGroup in hammer logic_script entity info
order2 <- EntityGroup[2].GetName()
order3 <- EntityGroup[3].GetName()
order4 <- EntityGroup[4].GetName()


function SafeRelease()
{
    if(l4d_s_mode == 1)
    {
    EntFire(choreo_scened_nick, "kill", "", 5)
    EntFire(choreo_scened_coach, "kill", "", 5)
    EntFire(choreo_scened_ellis, "kill", "", 5)
    EntFire(choreo_scened_rochelle, "kill", "", 5)
    }
    /*else if(l4d_s_mode == 2)
    {
    EntFire(choreo_scened_bill, "kill", "", 5)
    EntFire(choreo_scened_francis, "kill", "", 5)
    EntFire(choreo_scened_louis, "kill", "", 5)
    EntFire(choreo_scened_zoey, "kill", "", 5)
    }*/
IVCoreSafeShutdown("iv_choreo_character_select.nut")
}

function InitChoreoPersons(debug_enabled) //Old InitChoreoPersons(debug_enabled, persons_from_l4d_or_l4d2)
{
    //IV note: Init Main Core.
    //IVCoreStartup(debug_enabled, "iv_choreo_character_select.nut")
    local persons_set = 1 //Forced to 1, Because Used ONLY L4D2 Persons
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

function AddUserIOConnections() {
    self.ConnectOutput("OnUser1", "InitChoreoOrderNick")
    self.ConnectOutput("OnUser2", "InitChoreoOrderCoach")
    self.ConnectOutput("OnUser3", "InitChoreoOrderEllis")
    self.ConnectOutput("OnUser4", "InitChoreoOrderRochelle")
}

function InitChoreoOrderNick() {
    priority_table.scened_nick == true
}
function InitChoreoOrderCoach() {
    priority_table.scened_coach == true
}
function InitChoreoOrderEllis() {
    priority_table.scened_ellis == true
}
function InitChoreoOrderRochelle() {
    priority_table.scened_rochelle == true
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
    /*else if(l4d_s_mode == 2)
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
    }*/
}

function ReleaseChoreoOrderSpeak(debug_enabled) //Old ReleaseChoreoOrderSpeak(debug_enabled, persons_from_l4d_or_l4d2_local)
{
    InitChoreoPersons(debug_enabled)
    TakeChors(debug_enabled, l4d_s_mode)

    if(priority_table.scened_nick == true)
    {
        EntFire(choreo_scened_nick, "Start")
    }
    else if(priority_table.scened_coach == true)
    {
        EntFire(choreo_scened_coach, "Start")
    }
    else if(priority_table.scened_ellis == true)
    {
        EntFire(choreo_scened_ellis, "Start")
    }
    else if(priority_table.scened_rochelle == true)
    {
        EntFire(choreo_scened_rochelle, "Start")
    }
    else if(priority_table.scened_nick == false && priority_table.scened_coach == false && priority_table.scened_ellis == false && priority_table.scened_rochelle == false)
    {
        ReleaseWarnigMessage(1, "Persons not founded... Tell a programmer!!!")
        assert("Persons not founded... Tell a programmer!!!")
    }
SafeRelease()
}
}
else
{
    ReleaseErrorMessage(debug_enabled, "Script system core Failed to startup!!! Aborting...")
}

