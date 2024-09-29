/// @description Listening for Activity as Client

// Receiving Packets
while(steam_net_packet_receive()){
	
	//who is sending the information
	var _sender = steam_net_packet_get_sender_id(); 
	//set this information into a buffer that we have
	steam_net_packet_get_data(inbuf); 
	//start at the very beginning of the buffer
	buffer_seek(inbuf, buffer_seek_start, 0); 
	
	//read the packet sent from obj_Server Async-Steam
	var _type = buffer_read(inbuf, buffer_u8); 
	
	
	switch(_type){ 
		case NETWORK_PACKETS.SYNC_PLAYERS: 
			var _playerList = buffer_read(inbuf, buffer_string); 
			//turn the string into a readable json 
			_playerList = json_parse(_playerList);
			
			//now we can sync our players on this newly acquired list
			sync_players(_playerList); 
		break; 

	}
	
}