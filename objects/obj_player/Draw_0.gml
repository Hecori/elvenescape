//Variáveis
	depth = -y //Profundidade
	image_speed = 1

//Mudar sprite com a direção
	if isTryingToMove = 0{ //Parado
		
		if facingDirection[1] = 1 sprite_change(spr_finemIdleFront)
		else if facingDirection[1] = -1 sprite_change(spr_finemIdleBack)
		else{
			sprite_change(spr_finemIdleSide)
			image_xscale = facingDirection[0]
			}
		}
		
	else{ //Em movimento
		if move_dir[0] * move_dir[1] = 0{
		image_speed = abs(vsp)}
		else image_speed = 0.3+abs(vsp)
		
		if facingDirection[1] = 1 sprite_change(spr_finemWalkingFront)
		else if facingDirection[0] != 0{
			image_speed = abs(hsp)
			sprite_change(spr_finemWalkingSide)
			image_xscale = facingDirection[0]
			}
		else sprite_change(spr_finemWalkingBack)
		}

draw_self()

//Se estiver em modo debug
	if global.modeDebug{
		//Mostra o spot de interação
		draw_point(interactionSpot[0],interactionSpot[1])
		}