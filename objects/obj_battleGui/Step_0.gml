if obj_console.state = 0 getInput()


//Variaveis
var _enemySelected = obj_battleSystem.getEnemy(targetSelected)
var _enemyCurrent = system.getCurrentCharacter()

//Escolher alvos
if system.currentAction[1] = "target"{
	targetSelected = warp(targetSelected+keyRightPressed-keyLeftPressed,0,array_length(system.listEnemies)-1)
					
	//Pular alvos já mortos
	while(system.getEnemy(targetSelected).state = 0){
		var _temp = targetSelected
		targetSelected = warp(targetSelected+1,0,array_length(system.listEnemies)-1)
		
		if _temp != targetSelected audio_play_sound(snd_optionHover,0,0,global.volumeEffects)
		}
	
	//Voltar pro menu principal
	if keyX {
		system.currentAction = ["choose","none"]
		global.isTextBoxOpen = 0
		obj_guiTextBox.clearCurrentText()
	}
		
	//Alvo escolhido
	else if keyZ {
			if system.currentAction[0] = "attack" system.currentAction[1] = "phase1"
			else if system.currentAction[0] = "skill" system.currentAction[1] = "phase2"}
	}

//Ação principal
	switch(system.currentAction[0]){ 
		case "choose": //Escolher ação
			
			//Escolheu uma opção
			if keyZ and optionSelected > -1 {
				
				//Opções normais
				if optionListType != 2 {
					sendAction(optionSelected) 
					
					//Reseta a posição
					optionSelected = 0
					}
					
				//Usar habilidade
				else if obj_player.sp >= skillCurrent.cost{	
					//Inicia o uso da skill
					obj_battleSystem.currentAction = ["skill","phase1"]
						
					skillCurrent.use()
					}
				
				//Usar habilidade sem ter pontos
				else{
					skillShakeWindow = 30
					}
				
				}
			
			//Voltar um menu atrás
			else if keyX {
				optionListType = max(optionListType-1,0)
				optionSelected = 0
				}
			break 
		
		case "attack":
			switch(system.currentAction[1]){
		//Texto da ação e efeito do ataque
				case "phase1":
					
					
					//Tipo de arma sendo usada no ataque
					if obj_itemManager.equipment.weapon = ""{
						obj_guiTextBox.loadDialogue(new Dialogue(string("{0} desferiu um golpe desarmado contra {1}...",obj_player.name,characters[listEnemies[targetSelected]].name)),30)
						}
					else{
						var _weaponName = obj_itemManager.getItemName(obj_itemManager.equipment.weapon)
						obj_guiTextBox.loadDialogue(new Dialogue(string("{0} atacou {1} usando \"{2}\"...",obj_player.name,characters[listEnemies[targetSelected]].name,_weaponName)),30)
					}
					
					//Tipo de efeito do ataque
					var _effect = "slash"
					switch(obj_itemManager.equipment.weapon){
						case "swordFlaming":
							_effect = "slashFire"
						break
						}
						
					fxAttackAnimation = obj_battleEffects.attackAdd(_effect,_enemySelected.x,_enemySelected.y)
					
					system.currentAction[1] = "phase2"
					break	
				}
			break
			
		case "enemyChoose":
			switch (system.currentAction[1]){
				case "phase1":
					obj_guiTextBox.loadDialogue(new Dialogue(string("É a vez de '{0}' agir...",_enemyCurrent.name),.5),30)
					system.currentAction[1] = "phase2"
					break
					
				case "phase2":
					if obj_guiTextBox.dialogueHasEnded system.currentAction = _enemyCurrent.getAction()
					break
				}
		break
			
		case "enemyAttack":
			switch (system.currentAction[1]){
				case "phase3":
					if obj_guiTextBox.dialogueHasEnded{
						if obj_player.hp > 0 system.currentAction = ["next","phase1"]
						else system.currentAction = ["lose","phase1"]
						playerGui.hasBeenDamaged = false
						}
					break
				}
		break
		
		case "enemyNothing":
			switch (system.currentAction[1]){
				case "phase1":
					if obj_guiTextBox.dialogueHasEnded{
						//Mensagem de que o alvo não fez nada
						var _name = _enemyCurrent.name,_phrase = choose("{0} não faz nada em seu turno...","{0} ficou parado...")
						obj_guiTextBox.loadDialogue(new Dialogue(string(_phrase,_name),.5),30)
						system.currentAction[1] = "phase2"
						}
				break
				
				case "phase2":
					if obj_guiTextBox.dialogueHasEnded{
						system.currentAction = ["next","phase1"]
						}
				break
				}
		break
		
		case "check":
			switch (system.currentAction[1]){
				case "phase1":
					if obj_guiTextBox.dialogueHasEnded{
						
						//Texto de checagem base
						var _checkTextList = ["Após passar algum tempo analisando o alvo, você nota que:","Analisando a forma de como este inimigo age, você vê que:","Com base em seu conhecimento sobre esse tipo de inimigo, você analisa que:"]
						var _checkText = _checkTextList[irandom(2)]
						var _itemCarried = "."
						
						//Se carregar um item
						if _enemySelected.rewards.item != "" _itemCarried = string(" e tem uma chance de {0}% de largar um(a) {1}.",_enemySelected.rewards.itemChance,obj_itemManager.getItemName(_enemySelected.rewards.item))
						
						//Texto de chacagem final%-666666
						_checkText =string("{0}\nEste alvo é um \"{1}\" que possui um dano base que varia entre {2} a {3}, além de possuir uma defesa de {4} a {5}. \nAtualmente possui {6} pontos de vida{7}",_checkText,_enemySelected.name,_enemySelected.dmg.min,_enemySelected.dmg.max,_enemySelected.def.min,_enemySelected.def.max,_enemySelected.hp,_itemCarried) 
						
						obj_guiTextBox.loadDialogue(new Dialogue([_checkText,"Dica: \n"+_enemySelected.checkTip],.5))
						system.currentAction[1] = "phase2"
						}
				break
				
				case "phase2":
					if obj_guiTextBox.dialogueHasEnded {
						optionListType = 0
						system.currentAction = ["next","phase1"]
						}
				break
				}
		break
		
		case "skill":
			switch (system.currentAction[1]){
				case "phase2":
					var _skillVars = skillCurrent.use()
					
					
					//Tipo de efeito do ataque
					fxAttackAnimation = obj_battleEffects.attackAdd(_skillVars.effect,_enemySelected.x,_enemySelected.y)
					
					//Valor do dano
					obj_battleEffects.particleAdd("damageEnemyComplex",_enemySelected.x-100,_enemySelected.y-100,_skillVars.dmg)
						
					_enemySelected.imageIndex = 0
					
					system.currentAction[1] = "phase3"
					system.currentAction[2] = 30
					
				break
				
				case "phase4":
					system.currentAction[1] = "phaseEnd"
				break
				
				case "phaseEnd":
					if obj_guiTextBox.dialogueHasEnded {
						system.currentAction = ["next","phase1"]
						obj_player.sp -= skillCurrent.cost
						}
				break
			}
		break 
		
		case "inventory":
			switch (system.currentAction[1]){
				case "phase1":
					global.isMenuOpen = 1
					system.currentAction[1] = "phase2"
				break
				
				//Esperar para uma ação
				case "phase2":
					//Fechar o menu/voltar
					if keyX{
						global.isMenuOpen = 0
						system.currentAction = ["choose","phase1"]
						obj_gui.inventorySelectedItem = 0
						}
				break
				
				//Se um item foi utilizado
				case "phase3":
				
					//Se o item for usado mas algo deu errado (beber uma poção com vida cheia)
					if system.currentAction[2][2] = "fail"{
						system.currentAction[1] = "phase2"
						break
						}
					
					global.isMenuOpen = 0
					system.currentAction[1] = "phase4"
					
					//Mostrar o que foi feito com o item
					var _actionName = string_lower(system.currentAction[2][0]), _itemName = system.currentAction[2][1]
					var _wordEnding = string_copy(_actionName,string_length(_actionName)-1,2)
					_actionName = string_delete(_actionName,string_length(_actionName)-1,2)
					var _extraInfo = system.currentAction[2][2]
					
					//Mudar pro passado
					if _wordEnding = "ar" _wordEnding = "ou"
					else if _wordEnding = "er" _wordEnding = "eu"
					else if _wordEnding = "ir" _wordEnding = "iu"
					
					obj_guiTextBox.loadDialogue(new Dialogue(string("Após acessar seu inventário, você {0}{1} \"{2}\".\n{3}",_actionName,_wordEnding,_itemName,_extraInfo),1),120)
				break
				
				case "phase4":
					if obj_guiTextBox.dialogueHasEnded system.currentAction = ["next","phase1"]
				break
			}
		break
		}
