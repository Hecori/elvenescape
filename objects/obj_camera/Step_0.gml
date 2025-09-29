//Checa se o jogador existe
	if instance_exists(obj_player){
		
		//Pegar o centro verdadeiro do objeto
		var _xx = obj_player.x - sprite_get_xoffset(obj_player.sprite_index) + sprite_get_width(obj_player.sprite_index)/2
		var _yy = obj_player.y - sprite_get_yoffset(obj_player.sprite_index) + sprite_get_height(obj_player.sprite_index)/2
		
		//Seguir o jogador
		var diffX = (_xx-x)
		var diffY = (_yy-y)
		
		x = x + diffX/dampness
		y = y + diffY/dampness
	}