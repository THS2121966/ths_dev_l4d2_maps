/* Assault Mode Script File. Created by THS inc 2023 and Ivan Suvorov. */

printl("Initialising Assault Gamemode...")

GamemodeCoreState <- IncludeScript("AssaultModeBase.nut")

if(!GamemodeCoreState)
{
    printl("Assault Gamemode Core Logic not Initialised!!! Aborting...");
    return;
}