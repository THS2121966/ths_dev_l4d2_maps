/* Assault Mode Script File. Created by THS inc 2023 and Ivan Suvorov. */

local map_tasks_list =
[
    [
        "Bridge Generator"
        "Start the Bridge Generator!!!"
    ],
    [
        "Press Next Door Button"
        "..."
    ],
    [
        "Escape!!!"
        "Move!!!"
    ]
]

function OnGameEvent_round_start_post_nav(params)
{
    g_ModeScript.IV_ADD_Tasks_List(map_tasks_list);
    printl("Task List Post Spawn Sended!!!");
}

