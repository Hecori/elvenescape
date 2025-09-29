//Sistema
	system = obj_battleSystem
	
	turn = system.turn
	
	characters = system.characters
	listEnemies = system.listEnemies
	listAllies = system.listAllies

//Opções
	optionList = [["Atacar","Especial","Inventário","Fugir"],["Habilidades","Checar"]]
	optionListType = 0
	optionSelected = -1

	targetSelected = 0

//Habilidade 
	skillCurrent = ""
	skillShakeWindow = 0

//Visual
	depth = 110
	scaling = 3
	
	instance_create_depth(x,y,depth-1,obj_battleEffects)
	screenSize = [view_get_wport(view_current),view_get_hport(view_current)]
	
	fxButtonWidthExtra = array_create(10,0)
	fxClock = 0
	fxEnemiesNameAlpha = 0
	
	noDamagePhrases = system.noDamagePhrases
	
//Funções
	function getSkillByIndex(_i){
		var _skillKey = ds_map_keys_to_array(obj_player.skills)[_i], _skill = ds_map_find_value(obj_player.skills,_skillKey)
		return _skill
		}
	
	function sendAction(_action){
		switch (_action){
			case 0:
				//Main
				if optionListType = 0{
					system.currentAction = ["attack","target"]
					obj_guiTextBox.loadDialogue(new Dialogue("Selecione um alvo para sofrer o ataque...",4,"","none"))
					}
				
				//Habilidades
				else if optionListType = 1 {
					optionListType = 2
					var _skills = obj_player.skills, _skillsAmount = ds_map_size(_skills)
				
					
					//Carregar habilidades como botões
					optionList[2] = []
					for(var i = 0;i<_skillsAmount;i++){
						var _skillKey = ds_map_keys_to_array(_skills)[i], _skill = ds_map_find_value(_skills,_skillKey)
						array_push(optionList[2],_skill.name)
						}					
					}
				
			break
			
			case 1:
				//Special
				if optionListType = 0 optionListType = 1
				
				//Checar
				else if optionListType = 1{
					system.currentAction = ["check","target"]
					obj_guiTextBox.loadDialogue(new Dialogue("Escolha um alvo para checar",4,"","none"))
					}
				
			break
				
			case 2:
				system.currentAction = ["inventory","phase1"]
			break
			
			case 3:
				system.currentAction = ["exit","phase1"]
				obj_guiTextBox.loadDialogue(new Dialogue("Você conseguiu escapar....",3,"","none"),30)
			break		
		}
	}
	
	function drawSkillWindow(_x,_y,_skillNumber){
		var _spacing = 16, _outlineWidth = 450, _outlineHeight = 200
		skillCurrent = getSkillByIndex(_skillNumber); _y-= 198; _x+= 270
		draw_set_color(c_black)
		
		//Tremer janela ao selecionar uma skill que não tem PE o suficiente
		if skillShakeWindow > 0{
			
			//Tremer
			_x += sin(skillShakeWindow)*1.5
			
			//Cor de fundo vermelha
			draw_set_color(make_colour_rgb(skillShakeWindow*3,0,0))
			
			skillShakeWindow --
			}
		
		//Fundo
		draw_rectangle(_x,_y,_x+_outlineWidth,_y+_outlineHeight,false)
		
		//Outline
		draw_set_color(c_white)
		draw_rectangle(_x,_y,_x+_outlineWidth,_y+_outlineHeight,true)
		
		//Informações da habilidade
		draw_set_font(fnt_sourceSans)
		draw_set_valign(fa_top)
		_y += 10; _x += 10
		
		draw_text_ext(_x,_y,string("Habilidade: {0}\nCusto: {1} \nSeus PE: {2}/{3}\nDescrição:\n {4}",skillCurrent.name,skillCurrent.cost,obj_player.sp,obj_player.spMax,skillCurrent.description),-1,_outlineWidth-_spacing*2)
		
		//Status
		_y += 160
		
		if obj_player.sp >= skillCurrent.cost draw_text(_x,_y,"Pressione Z para usar.")
		else{
			draw_set_color(c_red)
			draw_text(_x,_y,"Você não tem Pontos de Energia o suficiente...")
			draw_set_color(c_white)
			}
			
		}