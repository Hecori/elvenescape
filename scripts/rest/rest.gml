function rest(){
	//Restaura vida e energia
	obj_player.hp = obj_player.hpMax
	obj_player.sp = obj_player.spMax
	
	//Aumenta 1 dia
	global.days ++
	
	//Remove 1 de XP
	obj_player.xp[0] = max(obj_player.xp[0]-1,0)
}