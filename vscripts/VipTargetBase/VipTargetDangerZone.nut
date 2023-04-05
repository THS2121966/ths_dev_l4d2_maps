IV_VIP_TARGET_DUMMY <- EntityGroup[0];
IV_ZOMBIES_RUN_MARK <- EntityGroup[1];
IV_RESCURE_AREA <- EntityGroup[2];

function IV_Realise_Danger_Zone()
{
    DoEntFire("!self", "Enable", "", 0, null, IV_ZOMBIES_RUN_MARK);
    EntFire("info_director", "Panic Event", "", 0.5);
}

function IV_Survivor_Danger_Ended()
{
    DoEntFire("!self", "Disable", "", 0, null, IV_ZOMBIES_RUN_MARK);
    DoEntFire("!self", "Kill", "", 0, null, IV_RESCURE_AREA);
    DoEntFire("!self", "Kill", "", 1, null, IV_ZOMBIES_RUN_MARK);

    if(developer())
    printl("Dummy Name - '" + IV_VIP_TARGET_DUMMY.GetName() + "'");

    g_ModeScript.IV_Create_Vip(IV_VIP_TARGET_DUMMY.GetName());
}
