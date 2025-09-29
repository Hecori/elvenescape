function Skill(_key,_name,_cost,_description,_dmgType="none",_dmgMin=0,_dmgMax=0) constructor {
  
    key = _key
	name = _name
	cost = _cost
	description = _description
	dmg = {
		type: _dmgType,
		min: _dmgMin,
		max: _dmgMax
		}
	
	//Adds as a skill that the player can use
	function add(){
		ds_map_add(obj_player.skills,key,self)
		}
		
	function use(){
		var _playerGui = obj_battleGui.playerGui
					
		switch(key){
			case "heal":
				if obj_battleSystem.currentAction[1] = "phase1"{
					var _heal = obj_player.level*3
					obj_player.skillHeal = [1,0]
					obj_player.hp += _heal
				
					//Ícone
					obj_battleEffects.skillAdd(key,_playerGui.spritePos[0]+128,_playerGui.spritePos[1]-16,obj_player.skillHeal[1],obj_player.skillHeal)
				
					obj_guiTextBox.loadDialogue(new Dialogue(string("Você trata seus ferimentos rapidamente e cura {0} PV!",_heal),1),30)
					
					//Fim da ação
					obj_battleSystem.currentAction = ["skill","phaseEnd"]
					}
				
				
			break
			
			case "block":
				if obj_battleSystem.currentAction[1] = "phase1"{
					obj_player.skillBlock = [3,1]
				
					//Ícone
					obj_battleEffects.skillAdd(key,_playerGui.spritePos[0]+128,_playerGui.spritePos[1]-16,obj_player.skillBlock[1],obj_player.skillBlock)	
				
					obj_guiTextBox.loadDialogue(new Dialogue(string("Você se concentra em bloquear os ataques durante as próximas três rodadas. \nSua defesa aumentou em +1 temporariamente."),1),30)
					
					//Fim da ação
					obj_battleSystem.currentAction = ["skill","phaseEnd"]
					}
			break
			
			case "focus":
				if obj_battleSystem.currentAction[1] = "phase1"{
					obj_player.skillFocus = [3,obj_player.level-1]
				
					//Ícone
					obj_battleEffects.skillAdd(key,_playerGui.spritePos[0]+128,_playerGui.spritePos[1]-16,obj_player.skillFocus[1],obj_player.skillFocus)	
	
					obj_guiTextBox.loadDialogue(new Dialogue(string("Você se concentra nos alvos a sua volta, recebendo um bônus de +{0} no dano \ndurante as próximas três rodadas.",obj_player.level-1),1),30)
					
					//Fim da ação
					obj_battleSystem.currentAction = ["skill","phaseEnd"]
					}
			break
			
			case "fireBlast":
				//Inicial
				if obj_battleSystem.currentAction[1] = "phase1"{
					obj_guiTextBox.loadDialogue(new Dialogue(string("Escolha um alvo..."),1))
					obj_battleSystem.currentAction = ["skill","target"]}
				
				//Após escolher um alvo
				else if obj_battleSystem.currentAction[1] = "phase2"{
					
					//Dano
					var _dmg = irandom_range(dmg.min,dmg.max), _enemy = obj_battleSystem.getEnemy(obj_battleGui.targetSelected)
					
					//Texto de conjuração
					var _text = string("Você conjura \"{0}\" e causa {1} de dano em {2}!",name,_dmg,_enemy.name)
					obj_guiTextBox.loadDialogue(new Dialogue(_text,1),30)
					
					//Dano no alvo
					_dmg = _enemy.takeDamage({dmg:0,magic:{dmg:_dmg,type:"fire"}})
					return {dmg:_dmg,effect:"fireBlast"}
					}
			break
			
			case "rest":
				if obj_battleSystem.currentAction[1] = "phase1"{
					var _restHp = irandom(1), _restSp = irandom(1)
					obj_player.skillRest = [1,0]
					
					obj_player.hp += _restHp
					obj_player.sp += _restSp
					
					//Se conseguiu descançar
					if _restHp+_restSp > 0 {
						//Ícone
						obj_battleEffects.skillAdd(key,_playerGui.spritePos[0]+128,_playerGui.spritePos[1]-16,obj_player.skillRest[1],obj_player.skillRest)
						obj_guiTextBox.loadDialogue(new Dialogue(string("Você descança um pouco e recupera {0} HP e {1} PE",_restHp,_restSp),1),30)
						}
						
					else obj_guiTextBox.loadDialogue(new Dialogue("Infelizmente, você não recuperou pontos...",1),30)
					
					//Fim da ação
					obj_battleSystem.currentAction = ["skill","phaseEnd"]
					}
				
				
			break
			
			}
		}

}