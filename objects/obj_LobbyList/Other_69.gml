/// @description Listen for Server List Response

switch(async_load[?"event_type"]){
	
	case "lobby_list":
		resetLobbyList();
		if(steam_lobby_list_get_count() == 0){
			lobbyList[0] = instance_create_depth(x, bbox_top+40, -20, obj_LobbyItem);	
		} else {
			for (var availableLobbies = 0; availableLobbies < steam_lobby_list_get_count(); availableLobbies++){
				var _ins = instance_create_depth(x, bbox_top+40+80*availableLobbies, -20, obj_LobbyItem, {
					lobby_index : availableLobbies, 
					lobby_id : steam_lobby_list_get_lobby_id(availableLobbies),
					lobby_creator : steam_lobby_list_get_data(availableLobbies, "Creator")
				});
				array_push(lobbyList, _ins); 
			}
			
		}
		

	break;
}