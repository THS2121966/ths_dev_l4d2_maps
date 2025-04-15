//////////////////////////////////////////////////////////Created by Ivan Suvorov.//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////Assault Game Mode Manager////////////////////////////////////////////////////////

assault_base_script_state <- IncludeScript("as_logic/as_logic_base.nut", this);

if(!assault_base_script_state)
{
    printl("Invalid Assault Base Logic Load State!!! Aborting Assault Manager Load...");
    return;
}

g_ModeScript.IV_Realise_AS_Manager(this);

function IV_Realise_Start_Tutorial()
{
    printl("Realising Start Assault Mode Tutorial...");
    EntFire("@Assault_Tutorial_Start", "Trigger", 0, 1.5);
    printl("Done Realising Assault Mode Tutorial!!!");
}

relay_reserved_1 <- EntityGroup[0];

function Realise_Tutorial_End()
{
    printl("Assault Mode Tutorial was Ended!!! Realising End State...");
    if(relay_reserved_1 != null)
    EntFire(relay_reserved_1.GetName(), "Trigger", 0, 0)

    g_ModeScript.IV_Assault_Mode_Begin();
}

function IV_Assault_Mode_Next_Stage()
{
    g_ModeScript.IV_Realise_Next_Stage();
}
