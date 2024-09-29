///@self obj_Server
	//^ We only want these functions evoked by the server object
function send_player_sync(_steam_id){
	//Need to send data to the client through Steam
	var _b = buffer_create(1, buffer_grow, 1); 
	buffer_write(_b, buffer_u8, NETWORK_PACKETS.SYNC_PLAYERS); 
	buffer_write(_b, buffer_string, shrink_player_list()); 
	//send the buffer data to the steam player ID
	steam_net_packet_send(_steam_id, _b); 
	//be sure to clean the buffer now that it has been sent
	buffer_delete(_b); 
}

///@self obj_Server
function send_player_spawn(_steam_id, _slot){
	var _pos = grab_spawn_point(_slot);
	//5 because (1st byte = purpose of packet) (2nd byte = x) (3rd byte = y) 
	var _b = buffer_create(5, buffer_fixed, 1); 
	buffer_write(_b, buffer_u8, NETWORK_PACKETS.SPAWN_SELF);
	//#CHANGE_THIS buffer_u16 should be changed if player can spawn outside the room size of 640x360
	buffer_write(_b, buffer_u16, _pos.x); 
	buffer_write(_b, buffer_u16, _pos.y);
	steam_net_packet_send(_steam_id, _b);
	buffer_delete(_b); 
	//new functions to tell where we're to spawn and where other players are to spawn
	server_player_spawn_at_pos(_steam_id, _pos); 
	send_other_player_spawn(_steam_id, _pos); 
}

///@self obj_Server
function send_other_player_spawn(_steam_id, _pos){
	//including the steam id so that other players can know when a player is being spawned whose steamID belongs to it
	// (1st packet equals this is spawning someone else) (2nd equals x pos) (3rd equals y pos) (last equals steamID)
	var _b = buffer_create(13, buffer_fixed, 1);  
	buffer_write(_b, buffer_u8, NETWORK_PACKETS.SPAWN_OTHER); 
	buffer_write(_b, buffer_u16, _pos.x); 
	buffer_write(_b, buffer_u16, _pos.y);
	//u64 because steam id includes 17 characters)
	buffer_write(_b, buffer_u64, _steam_id); 
	//we want to send this to everyone in the lobby except for the player that joined and us because we already know
	//because we dont need to send to us setting var _i = 1; 
	for(var _i = 1; _i < array_length(playerList); _i++){
		//if the steamID does not match the steam id of the player that joined then do the following
		if(playerList[_i].steamID != _steam_id){
			//send buffer of data to other players about the new player that just joined
			steam_net_packet_send(playerList[_i].steamID, _b);
		}
	}
	//delete buffer so space isn't taken up in storage of game
	buffer_delete(_b); 
}

///@self obj_Server
	//Making a function shrink_player_list() to remove the character from the playerList
	//This is to just send basic stuff like position and playerID
function shrink_player_list(){
	//copy the PlayerList
	var _shrunkList = playerList; 
	//iterate through entire playerList
	for (var _i = 0; _i < array_length(_shrunkList); _i++){
		//take the character variable and make it undefined
		_shrunkList[_i].character = undefined; 
	}
	//return the modified shrunken playerList
	return json_stringify(_shrunkList);
	
}

///@self obj_Server
function server_player_spawn_at_pos(_steam_id, _pos){
	var _layer = layer_get_id("Instances"); 
	
	for (var _i = 0; _i < array_length(playerList); _i++){
		//if the index of our player steam ID equals the _steam_id we were given in this particular function...
			// we want to actually spawn the player so let's go ahead and spawn the player
		if(playerList[_i].steamID == _steam_id){
			var _inst = instance_create_layer(_pos.x, _pos.y, _layer, obj_Player, {
				steamName: playerList[_i].steamName,
				steamID: _steam_id,
				lobbyMemberID: _i
			});
			
			//need to reference the player list and give them the instance so their character is no longer undefined
			playerList[_i].character = _inst;
			
		}
	}
}
