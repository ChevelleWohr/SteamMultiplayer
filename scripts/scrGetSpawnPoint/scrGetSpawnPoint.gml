// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrGetSpawnPoint(_player){
	var _spawnPoint = instance_find(obj_SpawnPoint, _player);
	if _spawnPoint == noone return {x:0, y:0}
	return {x: _spawnPoint.x, y: _spawnPoint.y}
}