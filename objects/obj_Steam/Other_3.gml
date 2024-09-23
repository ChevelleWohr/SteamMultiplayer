/// @description Insert description here
// You can write your code in this editor

//We want steam to know not to shutdown its service when we restart the game

// if game is ending and we are not restarting then we do want to shut down the steam server safely
if (is_game_restarting == false){
	steam_shutdown(); 	
}