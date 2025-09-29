if obj_console.state = 0 getInput()
draw_set_font(fnt_sourceSans)

delayInput --
var enemy = getEnemy(Gui.targetSelected)

//Combate
switch (currentAction[0]){
	
	case "attack": 
		//Dealing damage
		switch(currentAction[1]){
			case "phase2":
			
				//Dano físico base
				var _dmg = irandom_range(obj_player.dmg.min,obj_player.dmg.max) + obj_player.skillFocus[1] + obj_player.atribStr
				
				//Dano mágico
				var _dmgMagic = {
								type:obj_player.dmgMagic.type,
								dmg:irandom_range(obj_player.dmgMagic.min,obj_player.dmgMagic.max)
								}
											
				lastDamage = enemy.takeDamage({dmg:_dmg ,magic:_dmgMagic})
			
				currentAction[1] = "phase3"	
			break
				
			case "phase5":
				currentAction = ["next","phase1"]
			break
		}
	break
		
	case "next":
		if currentAction[1] = "phase1"{
			turnNext()
			Gui.optionListType = 0
			global.isTextBoxOpen = false
			break
			}
	break
	
	case "enemyAttack":
		var _enemy = characters[turn]
		
		switch(currentAction[1]){
			case "phase1":
				//Efeito de ataque
				obj_battleEffects.attackAdd(_enemy.sprite.attack,playerGui.spritePos[0]+64,playerGui.spritePos[1]+64)
				currentAction[1] = "phase2"
			break
				
			case "phase2":
				if obj_guiTextBox.dialogueHasEnded{
					var _dmg = _enemy.actionAttack(obj_player,playerGui.spritePos[0]-8,playerGui.spritePos[1]-16)
					
					//Se causou dano
					if _dmg.final > 0{
						//Tipo de dano
						if _enemy.dmg.type = "normal"{
							obj_guiTextBox.loadDialogue(new Dialogue(string(_enemy.msg.hit[0],_enemy.name,obj_player.name,_dmg.final),1),30)
							}
						else if _enemy.dmg.type = "magic"{
							obj_guiTextBox.loadDialogue(new Dialogue(string(_enemy.msg.hit[0],_enemy.name,obj_player.name,_dmg.final,elementInfo(_dmg.magic.type).dano)),30)
							}
						else{
							var _dmgNormal = max(0,_dmg.final-_dmg.magic.dmg)
							obj_guiTextBox.loadDialogue(new Dialogue(string(_enemy.msg.hit[0],_enemy.name,obj_player.name,_dmgNormal,_dmg.final,elementInfo(_dmg.magic.type).dano)),30)
							}
						}
						
					//Se o player evitou o dano	
					else{
						obj_guiTextBox.loadDialogue(new Dialogue(string(_enemy.msg.miss[0],_enemy.name,obj_player.name,_dmg.final)),30)
						}
					
					currentAction[1] = "phase3"
					}
			break
			}
	break
		
	case "win":
		switch(currentAction[1]){
			case "phase1":
				if !instance_exists(obj_battleFinalScreen){
					obj_player.addXp(rewardPool.xp)
					
					
					//Recompensas de itens
					//Rolar pra cada item
					for(var i = 0;i<array_length(rewardPool.items);i++){
						var _item = rewardPool.items[i], _chance = rewardPool.chances[i], _roll = irandom(100), _result = [false]
						
						//Se rolar o valor do item
						if _roll <= _chance _result = obj_itemManager.addItemInventory(_item,1)
						
						//Se o item foi adicionado com sucesso, adicionar aos itens ganhos
						if _result[0] = true {
							var _sep = ""
							if array_length(rewardPool.won) > 0 _sep = " + "
							array_push(rewardPool.won,_sep+obj_itemManager.getItemName(_item))
							}
						
						show_debug_message(string("Rolou {0} para {1}:  {2}",_roll,_item,_result))
						}
						
					
					with instance_create_depth(0,0,depth,obj_battleFinalScreen){
						state = 0
						newSkill = obj_player.newSkill
						obj_player.newSkill = ""
						}
					}
			break
			
			case "phase2":
				global.enemyActor.state = -1
				currentAction = ["exit","phase1"]
			break
			}
	break
	
	case "lose":
		switch(currentAction[1]){
			case "phase1":
				if !instance_exists(obj_battleFinalScreen){
					with instance_create_depth(0,0,depth,obj_battleFinalScreen) state = 1
					obj_player.hp = 1
					}
			break
			
			case "phase2":
				currentAction = ["exit","phase1"]
			break
			}
	break

	case "exit":
		switch(currentAction[1]){
			case "phase1":
				if obj_guiTextBox.dialogueHasEnded{
					currentAction[1] = "phase2"
					with instance_create_depth(x,y,-1,obj_fxRoomTransition){
						type = "fadeOut"
						action = "exitBattle"
						timeCurrent = 0
						timeEnd = 30
						}
					}
				break
				
			case "phase3":
				obj_player.hasLevedUp = false
				with instance_create_depth(x,y,-1,obj_fxRoomTransition){
					type = "fadeIn"
					action = "none"
					timeCurrent = 0
					timeEnd = 30
					}
				global.enemyList = []
				clearEffects()
				room_goto(rm_cellsA1)
			break
			}
	break
	}