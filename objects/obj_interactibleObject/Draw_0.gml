draw_self()

if getInteraction() = 0 and showKeyTip{
	draw_sprite(spr_guiIconsSmall,0,interationPosition[0],interationPosition[1]-interactionRange[1]-(interactionRange[1]/2)+tipShift)
	}

if global.modeDebug{
	draw_set_color(c_red)
	
	
	//Muda a cor da colisão
	switch (getInteraction()){
		case -1:  draw_set_color(c_red);break
		case 0:  draw_set_color(c_yellow);break
		case 1:  draw_set_color(c_green);break
		}
		
	//Mostrar colisão
	draw_rectangle(interationPosition[0]-interactionRange[0],interationPosition[1]-interactionRange[1],interationPosition[0]+interactionRange[0]-1,interationPosition[1]+interactionRange[1],true)
	}
