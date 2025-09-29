getInput()

//Variaveis
	var _xx = screenCenter[0], _yy = screenCenter[1] - 100, _spacing = 32

//Fundo
	draw_set_alpha(_alpha)
	_alpha = min(_alpha+0.01,0.8)
	draw_set_color(c_black)
	draw_rectangle(0,0,1000,1000,false)
	draw_set_color(c_white)
	draw_set_halign(fa_center)

//Vitória
if state = 0{
	//Mensagem de vitória
	draw_set_font(fnt_quickSand)
	draw_text(_xx,_yy,"Você venceu!!!")
	_yy+=_spacing
	
	//Se passou de nível
	if obj_player.hasLevedUp = true{
		//Mensagem de nivel
		draw_set_font(fnt_quickSand)
		draw_text(_xx,_yy,"Você subiu de nível!!!")
		_yy+=_spacing
		
		
		//Habilidade ao passar de Nível
		if newSkill != ""{
			draw_text(_xx,_yy,string("+ {0}",newSkill))
			_yy+=_spacing
			}
		
		//Nível atual
		draw_set_font(fnt_sourceSans)
		draw_text(_xx,_yy,string("NÍVEL {0}",obj_player.level))
		_yy+=_spacing
		}

	//Recompensas genéricas
	draw_set_font(fnt_sourceSans)
	draw_text(_xx,_yy,string("+ Pontos de Experiência ganhos: {0} XP",obj_battleSystem.rewardPool.xp))

	
	//Ao ganhar um item
	if array_length(obj_battleSystem.rewardPool.won) > 0 {
		_yy+=_spacing
		var _listItems = ""
		for(var i = 0; i < array_length(obj_battleSystem.rewardPool.won);i++){_listItems+=obj_battleSystem.rewardPool.won[i]+" "}

		draw_text(_xx,_yy,string("+ Você encontrou: {0}",_listItems))
		
		}
	
	
	_yy+=_spacing*10
	draw_text(_xx,_yy,"Pressione Z para voltar ao mundo principal")
	}
	
else{
	//Mensagem de vitória
	draw_set_font(fnt_quickSand)
	draw_text(_xx,_yy,"Você perdeu...")
	_yy+=_spacing

	//Recompensas genéricas
	draw_set_font(fnt_sourceSans)
	//draw_text(_xx,_yy,"")
	_yy+=_spacing
	draw_text(_xx,_yy,"Pressione Z para voltar ao mundo principal")
	}

draw_set_alpha(1)
draw_set_halign(fa_left)

//Fechar a tela de derrota/vitória e sair pro mundo principal
if keyZ and obj_battleSystem.currentAction[1] = "phase1"{
	obj_battleSystem.currentAction[1] = "phase2"
	}