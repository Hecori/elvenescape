event_inherited();

label = "ATOR INIMIGO"
immortal = false

//Dialogo
	dialogues = ds_map_create()
	
	new Dialogue(["MENSAGEM ANTES DE INICAR A LUTA"],1,label,"battle").add(dialogues,"msg1")
	
	dialoguesCurrent = ds_map_find_value(dialogues,"dummy1")

//Adicionar inimigos na luta
	enemyList = []
	
	//Inimigo main
	repeat(amount) array_insert(enemyList,array_length(enemyList),enemyMain)
	
	if array_length(enemyType) > 0{
		for(var i = 0; i< array_length(enemyType);i++){
			if enemyType[i] != enemyMain array_insert(enemyList,array_length(enemyList),enemyType[i])
			}
		}
	
//Colisao extra
	if colShiftH != 0{
		var size = sprite_get_width(spr_collision_box)
		
		collision = instance_create_depth(x+(size*other.colShiftX),y+(size*other.colShiftY),depth,obj_collider)
		with collision{
			image_xscale = other.colShiftH
			image_yscale = other.colShiftV
			}
	}