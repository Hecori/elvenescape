draw_set_color(c_black)
	
//Ficar escuro
if type = "fadeOut"{
	var alpha = timeCurrent/timeEnd
	draw_set_alpha(alpha)
	draw_rectangle(0,0,screenSize[0],screenSize[1],false)
	}

//Sair do escuro
else if type = "fadeIn"{
	var alpha = 1-timeCurrent/timeEnd
	draw_set_alpha(alpha)
	draw_rectangle(0,0,screenSize[0],screenSize[1],false)
	}

draw_set_alpha(1)
draw_set_color(c_white)

//Ações após a transição
if timeCurrent < timeEnd timeCurrent+=1
else{
	switch (action){
		case "none":
			instance_destroy()
		break
		
		case "rest":
			if type = "fadeOut"{
				timeCurrent = 0
				type = "fadeIn"
				}
			else{
				action = "none"
				}
		break
		
		case "enterBattle":
			if type = "fadeOut"{
				room_goto(rm_battle)
				type = "fadeIn"
				obj_player.visible = false
				timeCurrent = 0
				}
			else action = "none"
		break
			
		case "exitBattle":
			obj_player.visible = true
			obj_battleSystem.currentAction[1] = "phase3"
			action = "none"
		break
		}	
	}