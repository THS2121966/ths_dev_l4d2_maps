////////////////////////////////////////// THS inc 2021. //////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////// This script created for base Player Name Detecting... //////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//IV note: Includes presented and added down below
IncludeScript("maps/l4d_cannals_series_shared/ths_scripts_base/iv_warning_msg_system.nut", this) //MSG and Core Script manager (base commands and Start, Shutdow system)
logic_script_system <- false

//IV note: Init Main Core.
iv_core_startup <- IVCoreStartup(debug_enabled, "trigger_player_tester.nut")


activator_named_nick <- Entities.FindByName(null, "!nick")
activator_named_coach <- Entities.FindByName(null, "!coach")
activator_named_ellis <- Entities.FindByName(null, "!ellis")
activator_named_rochelle <- Entities.FindByName(null, "!rochelle")

fired_entity <- "null";

function InitIO() {
    self.ConnectOutput("OnTrigger", "ReleaseUserVariable")
}

/*function ReleaseTarget(fired_entity_local) {
    if(fired_entity_local != null || fired_entity_local != "null")
    {
        fired_entity = fired_entity_local
    }
    else
    {
        ReleaseWarnigMessage(debug_enabled, "Returned a NULL Value... Mappers, please, FIX IT!!!")
    }
}*/

function TestPlayerIn() {
    if(self.IsTouching(activator_named_nick))
    {
        return activator_named_nick
    }
    else if(self.IsTouching(activator_named_coach))
    {
        return activator_named_coach
    }
    else if(self.IsTouching(activator_named_ellis))
    {
        return activator_named_ellis
    }
    else if(self.IsTouching(activator_named_rochelle))
    {
        return activator_named_rochelle
    }
return null
}

function ReleaseUserVariable() {
    local touch_user = TestPlayerIn()
    if(touch_user == null)
    {
        ReleaseWarnigMessage(debug_enabled, "No User Founded in this trigger... Tell a Programmer!!!")
        assert("No User Founded in this trigger... Tell a Programmer!!!")
    }
    else if(touch_user == activator_named_nick)
    {
        EntFire(fired_entity, "FireUser1")
    }
    else if(touch_user == activator_named_coach)
    {
        EntFire(fired_entity, "FireUser2")
    }
    else if(touch_user == activator_named_ellis)
    {
        EntFire(fired_entity, "FireUser3")
    }
    else if(touch_user == activator_named_rochelle)
    {
        EntFire(fired_entity, "FireUser4")
    }
}


InitIO()