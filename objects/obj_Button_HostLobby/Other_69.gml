/// @description Listening for Lobby Creation

switch(async_load[?"event_type"]){
	
	case "lobby_created":
		show_debug_message("Lobby created: " + string(steam_lobby_get_lobby_id())); 
		steam_lobby_join_id(steam_lobby_get_lobby_id()); 
	break;
	
	case "lobby_joined":
		if (steam_lobby_is_owner()){
			//isGamemakerTest is a default search word used for specifically gamemaker and steam do not edit this text
			steam_lobby_set_data("isGameMakerTest", "true"); 	
			steam_lobby_set_data("Creator", steam_get_persona_name()); 
			//Can store basic information within steam but not much 
			//steam_lobby_set_data("map", "rm_GameRoom");
		}
		room_goto(rm_GameRoom); 
	break;
}