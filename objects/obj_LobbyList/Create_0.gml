/// @description Setup lobby_list

lobbyList = []

image_xscale = xScale; 
image_yscale = yScale; 

lobbyList[0] = instance_create_depth(x, bbox_top+40, -20, obj_LobbyItem); 

//When we spawn this object we want to search for lobbies
//the data set inside steam_lobby_list_add_string_filter can be found in obj_Button_HostLobby Async-Steam
steam_lobby_list_add_string_filter("isGameMakerTest", "true", steam_lobby_list_filter_eq);

//pulls and asks for lobbies and when the request comes back we use it in obj_LobbyList Async-Steam
steam_lobby_list_request(); 

resetLobbyList = function (){
	for (var _i = 0; _i < array_length(lobbyList); _i++){
		show_debug_message("Deleting: "+ string(lobbyList[_i]));
		instance_destroy(lobbyList[_i]); 
	}	
	lobbyList = [];	
}