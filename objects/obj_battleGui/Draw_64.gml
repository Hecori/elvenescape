getInput()

//Variáveis
	turn = system.turn
	characters = system.characters
	currentCharacter = characters[turn]
	listEnemies = system.listEnemies
	listAllies = system.listAllies
	playerGui = system.playerGui 
	fxClock ++
	
	var _playerRepeatAnimation = true
	
	draw_set_color(c_white)
	draw_set_font(fnt_quickSand)
	
	var backgroundHasBeenDraw = false
	
//Frame dos Inimigos
	var spritePos = [300,350]
	var amountEnemies = array_length(listEnemies)
	
	//Centralizar
	spritePos[0] -= (64*amountEnemies-1)/2
	
	for (var i = 0; i < amountEnemies ;i++){
		var _repeatAnimation = true
		var enemy = system.getEnemy(i)
		enemy.sprite.current = enemy.sprite.idle
		
		var frameSize = [sprite_get_width(enemy.sprite.current)*scaling,sprite_get_height(enemy.sprite.current)*scaling]
		
		//Fundo
			if backgroundHasBeenDraw = false{
				backgroundHasBeenDraw = true
				draw_sprite_ext(spr_battleBackground,global.enemyActor.background,0,0,4,4,0,c_white,1)
				}
        
		//Se estiver vivo, mostrar nome
			if enemy.hp > 0{
				draw_set_font(fnt_openSans)
				draw_set_halign(fa_center)
			
				//Cor baseada na vida
				var _v = 255*(enemy.hp/enemy.hpMax)
				draw_set_color(make_color_rgb(255,_v,_v))
			
				if turn = system.getEnemy(i,true){
					draw_set_alpha(1)}
				else{
					draw_set_alpha(fxEnemiesNameAlpha)
					}
			
				draw_text(enemy.x,enemy.y-frameSize[1]/2-24,enemy.name)
			
				draw_set_color(c_white)
				draw_set_halign(fa_left)
				draw_set_alpha(1)
				}
            else{
                enemy.alpha = max(0,enemy.alpha-0.01)
            }
        
		
		//Linka a posição do visual com a posição virtual do inimigo
		enemy.x = spritePos[0]
		enemy.y = spritePos[1]-frameSize[1]/2
		
		//Debug
		if global.modeDebug {
			draw_rectangle(spritePos[0]-frameSize[0]/2,spritePos[1],spritePos[0]+frameSize[0]/2,spritePos[1]-frameSize[1],true) //Desenha a borda
			draw_text(spritePos[0]-frameSize[0]/2,spritePos[1]-frameSize[1]-8,string("HP: {0}",enemy.hp))
            draw_text(spritePos[0]-frameSize[0]/2,spritePos[1]-frameSize[1]-8+16,string("imageIndex: {0}",enemy.imageIndex))
            draw_text(spritePos[0]-frameSize[0]/2,spritePos[1]-frameSize[1]-8+32,string("alpha: {0}",enemy.alpha))
			}
		
		//Selecionar alvo
		if system.currentAction[1] = "target" and i = targetSelected{
			draw_sprite_ext(spr_guiIconsSmall,8,spritePos[0],spritePos[1]-frameSize[1]+sin(fxClock/10)-30,scaling,scaling,0,c_white,1)
			}
		
		//Ação de ataque	
		if system.currentAction[0] = "attack"{
			fxEnemiesNameAlpha=min(fxEnemiesNameAlpha+0.1,1)
			
			if targetSelected = i{
				
				switch(system.currentAction[1]){
				
					case "phase3":
						if obj_guiTextBox.dialogueHasEnded{
							
							//Valor do dano
							obj_battleEffects.particleAdd("damageEnemyComplex",spritePos[0]-100,spritePos[1]-frameSize[1]+32,obj_battleSystem.lastDamage)
						
							//Textbox com dano
							var _text = string("E causou {0} de dano normal",max(0,system.lastDamage.final-system.lastDamage.magic.dmg))
							
							//Se houve dano elemental
							if system.lastDamage.magic.dmg> 0{
								var _element = elementInfo(system.lastDamage.magic.type)
								_text = string("{0} e {1} de dano {2}",_text,system.lastDamage.magic.dmg,_element.dano)
								}
								
							_text += "."
							
							//Se causou dano ou nao
							if system.lastDamage.final > 0{
								obj_guiTextBox.loadDialogue(new Dialogue(_text,.5,"","none"),30)}
							else{
								var _tempIndex = irandom(array_length(noDamagePhrases)-1), _tempText = noDamagePhrases[_tempIndex] 
								obj_guiTextBox.loadDialogue(new Dialogue(string("{0} {1}",system.getEnemy(targetSelected).name,_tempText),.5,"","none"),30)
								}
							
							enemy.imageIndex = 0
							
							system.currentAction[1] = "phase4"
							system.currentAction[2] = 30
							}
						break
					
					case "phase4":
						//Sprite
						_repeatAnimation = false
						enemy.sprite.current = enemy.sprite.hit
						
						if system.currentAction[2] > 0 system.currentAction[2]--
						else{
							if obj_guiTextBox.dialogueHasEnded system.currentAction[1] = "phase5"
							}
						break
					}
				}			
			}
			
		else if system.currentAction[0] = "skill"{
			fxEnemiesNameAlpha=min(fxEnemiesNameAlpha+0.1,1)
			
			if targetSelected = i{
				
				switch(system.currentAction[1]){
					case "phase3":
						//Sprite
						_repeatAnimation = false
						enemy.sprite.current = enemy.sprite.hit
						
						if system.currentAction[2] > 0 system.currentAction[2]--
						else{
							if obj_guiTextBox.dialogueHasEnded system.currentAction[1] = "phase4"
							}
						break
					}
				}			
			}
		else fxEnemiesNameAlpha=max(fxEnemiesNameAlpha-0.01,0.2)
		
		//Desenha o inimigo piscando se for seu turno ou estiver morrendo
		if (turn = system.getEnemy(i,true) and system.currentAction[0] = "enemyChoose"){
			shader_set(shd_flashWhite)
			var _light = shader_get_uniform(shd_flashWhite,"light")
			shader_set_uniform_f(_light,abs(sin(current_time/200))/2)
			draw_sprite_ext(enemy.sprite.current,enemy.imageIndex,spritePos[0],spritePos[1],scaling,scaling,0,c_white,1)
			
			shader_reset()
			}
		
		//Desenha o inimigo fora de seu turno
		else if enemy.hp > 0 draw_sprite_ext(enemy.sprite.current,enemy.imageIndex,spritePos[0],spritePos[1],scaling,scaling,0,c_white,1)
		
        else draw_sprite_ext(enemy.sprite.current,enemy.imageIndex,spritePos[0],spritePos[1],scaling,scaling,0,c_white,enemy.alpha)
		
		//Animação se o inimigo estiver vivo
		if enemy.hp > 0 enemy.imageIndex = animation_animate(enemy.sprite.current,enemy.imageIndex,_repeatAnimation)
		
		spritePos[0]+=frameSize[0]
		}
		
//Desenha o personagem principal
	playerGui.sprite.current = playerGui.sprite.idle
	var _posShift = 0
	
	//Sprites
	switch(system.currentAction[0]){
		case "enemyAttack":
			switch(system.currentAction[1]){
				case "phase2":
					playerGui.imageIndex = 0
					break
				case "phase3":
					if playerGui.hasBeenDamaged = false break
					playerGui.sprite.current = playerGui.sprite.hit
					//playerGui.imageIndex = min(playerGui.imageIndex,4)
					_playerRepeatAnimation = false
					_posShift = sin(current_time/20)*4/(playerGui.imageIndex*5+1)
					break
				}
		break
		}
		
	//Animação
	draw_sprite_ext(playerGui.sprite.current,playerGui.imageIndex,playerGui.spritePos[0]+_posShift,playerGui.spritePos[1]+_posShift,scaling,scaling,0,c_white,1)

	playerGui.imageIndex = animation_animate(playerGui.sprite.current,playerGui.imageIndex,_playerRepeatAnimation)
	
	//Nome
	
	draw_set_font(fnt_openSans)
	draw_set_halign(fa_center)
			
	//Cor baseada na vida
	var _v = 255*(obj_player.hp/obj_player.hpMax)
	draw_set_color(make_color_rgb(255,_v,_v))
			
	draw_text(790,425,obj_player.name)
			
	draw_set_color(c_white)
	draw_set_halign(fa_left)
	draw_set_alpha(1)
	
//Botões de Ação
	if system.currentAction[0] = "choose"{
	    var tempX = 16
	    var tempY = screenSize[1]-16
		var buttonWidth = 230
		var buttonHeight = 30
		var buttonMargin = 6
		var textPaddingLeft = 8
		var optionsNumber = array_length(optionList[optionListType])
		var fxTextGrow = [4,32]
		var textHeightShift = 3
        
	    //Para cada opção
	    for (var i = optionsNumber-1; i >= 0;i--){
			draw_set_font(fnt_quickSand)
			draw_set_valign(fa_bottom)
			
			if optionSelected = i{
				fxButtonWidthExtra[i] = clamp(fxButtonWidthExtra[i]+fxTextGrow[0],0,fxTextGrow[1])
				draw_rectangle(tempX,tempY-sin(fxClock/10),tempX+buttonWidth+fxButtonWidthExtra[i],tempY-buttonHeight-sin(fxClock/10),false)
				draw_text_color(tempX+textPaddingLeft+fxButtonWidthExtra[i]/2,tempY-sin(fxClock/10)-textHeightShift,optionList[optionListType][i],c_black,c_black,c_black,c_black,1)
				
				if optionListType = 2 drawSkillWindow(tempX,tempY-sin(fxClock/10),i)
				
				}
			else{
				fxButtonWidthExtra[i] = clamp(fxButtonWidthExtra[i]-fxTextGrow[0],0,fxTextGrow[1])
				draw_set_alpha(0.7)
				draw_rectangle_color(tempX,tempY,tempX+buttonWidth+fxButtonWidthExtra[i],tempY-buttonHeight,c_black,c_black,c_black,c_black,false)
				draw_set_alpha(1)
				draw_rectangle(tempX,tempY,tempX+buttonWidth+fxButtonWidthExtra[i],tempY-buttonHeight,true)
				
				draw_text(tempX+textPaddingLeft+fxButtonWidthExtra[i]/2,tempY-textHeightShift,optionList[optionListType][i])
				}

			tempY-=buttonHeight+buttonMargin
	    }
		draw_set_valign(fa_top)
        
	    //Mudar de opção
	    if obj_console.state = 0 optionSelected = clamp(optionSelected+keyDownPressed-keyUpPressed,0,optionsNumber-1)    
	}

//Debug
	if global.modeDebug{
		
		if currentCharacter.id != "player" draw_text(0,0,string("Turno atual: {0}-{1} | Ação: {2}",system.turn,currentCharacter.name,system.currentAction))
		else {
			draw_text(0,0,string("Turno atual: {0}-{1} | Ação: {2}",system.turn,obj_player.name,system.currentAction))
			}
		draw_text(0,32,string("Inimigos: {0}",system.listEnemies))
		draw_text(0,64,string("Timer to next turn: {0}",system.timerUntilNextTurn))
		draw_text(0,64+32,string("Recompensas: {0}",system.rewardPool))
		draw_text(0,128,string("Focus: {0}",obj_player.skillFocus))
		}