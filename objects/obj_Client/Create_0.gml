/// @description Init Client Variables

playerList = []; 

steamID = steam_get_user_steam_id(); 
steamName = steam_get_persona_name(); 
lobbyMemberID = undefined; 

character = undefined; 

//base buffer to be used for listening and will be modified over and over again...
	//because we will always be listening and it will always change
inbuf = buffer_create(16, buffer_grow, 1);

playerList[0] = {
	steamID			: steamID,
	steamName		: steamName,
	character		: undefined,
	startPos		: grab_spawn_point(0),
	lobbyMemberID	: undefined
}