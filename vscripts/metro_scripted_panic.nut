/* Ivan Suvorov and THS inc 2023 */
/* Logic for Initialising Controlled Panic Evend */

PANIC_EVENT_WAVES <- 4;
PANIC_EVENT_DELAY <- 5;

DIRECTOR_BASE_GAMEMODE <- Director.GetGameModeBase().tolower();
DIRECTOR_DIFFICULTY <- Convars.GetStr( "z_difficulty" ).tolower();

if(DIRECTOR_BASE_GAMEMODE == "coop" || DIRECTOR_BASE_GAMEMODE == "realism")
{
    local addive_value = 0;

    if(DIRECTOR_DIFFICULTY == "hard" || DIRECTOR_DIFFICULTY == "expert")
    addive_value = 2;

    PANIC_EVENT_WAVES -= addive_value;
    PANIC_EVENT_DELAY += addive_value;
}
else
{
    PANIC_EVENT_WAVES = 2;
    PANIC_EVENT_DELAY <- 3;
}

const ERROR = -1;
const PANIC = 0;
const TANK = 1;
const DELAY = 2;
const SCRIPTED = 3;

DirectorOptions <-
{
	//-----------------------------------------------------
	A_CustomFinale_StageCount = PANIC_EVENT_WAVES // Number of stages. Used for calculating the Versus score.

	A_CustomFinale1 = PANIC
	A_CustomFinaleValue1 = 1	// Two panic waves.

	A_CustomFinale2 = DELAY
	A_CustomFinaleValue2 = PANIC_EVENT_DELAY 	// Delay for five seconds in addition to stage delay.

	//-----------------------------------------------------

	CommonLimit = 15
	SpecialRespawnInterval = 8
}

	if(PANIC_EVENT_WAVES >= 3)
    {
        DirectorOptions.A_CustomFinale3 <- TANK
        DirectorOptions.A_CustomFinaleValue3 <- 2 	// 2 tanks! Start rescue for Finale Type A after this wave ends too.
    }
	if(PANIC_EVENT_WAVES >= 4)
    {
        DirectorOptions.A_CustomFinale4 <- PANIC
        DirectorOptions.A_CustomFinaleValue4 <- 1	// Two panic waves.
    }
	if(PANIC_EVENT_WAVES >= 5)
    {
        DirectorOptions.A_CustomFinale5 <- DELAY
        DirectorOptions.A_CustomFinaleValue5 <- PANIC_EVENT_DELAY 	// Delay for five seconds in addition to stage delay.
    }

function OnBeginCustomFinaleStage( num, type ) // This function is run at the beginning of every stage.
{
	printl( "Beginning custom Panic stage #" + num + " of type: " + type )
	if( DirectorOptions.CommonLimit >= 15 )
		DirectorOptions.CommonLimit = num + 5 // Increase commons by 5 linearly with stages.
}

