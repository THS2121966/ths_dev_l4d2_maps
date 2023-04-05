IV_EVENT_START <- EntityGroup[0];
IV_EVENT_END <- EntityGroup[1];

function IV_BEGIN_Rescure()
{
    DoEntFire("!self", "Trigger", "", 0, null, IV_EVENT_START);
}

function IV_END_Rescure()
{
    DoEntFire("!self", "Trigger", "", 0, null, IV_EVENT_END);
}
