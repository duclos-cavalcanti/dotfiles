#FreeRTOS-Pacman todo
-[] Finish State Machine.

Description/Idea:
Currently states in the SM have a pointer a stack called active handles and another one called inactive handles. 

States should maybe hold a dictionary of Keycodes -> Events, so that if a specific keycode
has been pressed, we can then know what is the state_name that should be executed next.
Then send it to the corresponding queue.

Problem:
How can I implement a dictionary in C?

    

