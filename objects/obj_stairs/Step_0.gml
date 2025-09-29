//Mudar de estado
switch(phase){
	
	//Idle
	case 0:
		if place_meeting(x,y,obj_player) phase = 1
	break
	
	//Criar transição pra sala de vitória
	case 1:
		with instance_create_depth(x,y,-9999,obj_fxRoomTransition){
			timeEnd = 120
			type = "fadeOut"
			}
		phase = 2
	break
	
	//Mover o jogador pra cima como se ele estivess subindo as escadas
	case 2:
		obj_player.move_dir = [0,-1]
		obj_player.isTryingToMove = 1
		obj_player.facingDirection = [0,-1]
		obj_player.vsp = -.2
		
		//Quando acabar a transição
		if !instance_exists(obj_fxRoomTransition){
			
			//Remover player e UI
			obj_player.persistent = false
			instance_destroy(obj_gui)
		
			room_goto(rm_win)
		
			//Pontuação
			global.score = {
				xp: obj_player.xp[2],
				level: obj_player.level,
				hp: obj_player.hp,
				hpMax: obj_player.hpMax
				}
			}
	break
	
	case 3:
		//Mudar pra última tela sem o jogador
		
	break
	
	}