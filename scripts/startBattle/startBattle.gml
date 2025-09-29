function startBattle(_enemyList,_enemyActor){
	array_copy(global.enemyList,0,_enemyList,0,array_length(_enemyList))	
	
	//Remover o inimigo no mundo principal depois
	global.enemyActor = _enemyActor
	
	with instance_create_depth(x,y,-1,obj_fxRoomTransition){
		type = "fadeOut"
		action = "enterBattle"
		timeCurrent = 0
		timeEnd = 30	
	}
}