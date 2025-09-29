//Sistemas
	Gui = obj_battleGui
//Personagens
	
	characters = []
	
	listAllies = [] // Aliados | Inimigos
	listEnemies = []
	
	numberOfEnemies = 0
	playerGui = noone
	
//Recompensas
	rewardPool = {xp:0,items:[],chances:[],won:[]}
	
	
//Turno e Rodada
	//choose - Escolhendo uma ação a fazer
	//target - Escolhendo um alvo para sofrer a ação
	//attack - Atacar o alvo
	//enemy
	
	currentAction = ["choose","none"] //Ação atual e anterior
	
	state = "running"
	turn = 0

//Delay
	delayInput = 0
	
	timerUntilNextTurn = [0,60]


//Extra
	lastDamage = [-1,-1,-1,-1]
	
	//Frases quando o personagem não sofre dano 
	noDamagePhrases = ["bloqueou o ataque com sucesso!","evitou completamente o dano!","desviou do ataque.","não sofreu dano do ataque.","evitou o ataque sem sofrer um arranhão..."]
	
//Funções
	function turnNext(){
		//Se ainda houverem inimigos na batalha
		if numberOfEnemies > 0{
			turn = warp(turn+1,0,array_length(characters)-1)
			
			while characters[turn].id != "player"{
				if characters[turn].state = 0 turn = warp(turn+1,0,array_length(characters)-1)
				else{
					currentAction = ["enemyChoose","phase1"]
					break
					}
				}
			if characters[turn].id = "player"{
				currentAction = ["choose","phase1"]
				lowerEffects()
				}	
			}
		//Se não houverem mais inimigos
		else{
			currentAction = ["win","phase1"]
			}
	}

	function charactersUpdate(){
		listAllies = []
		listEnemies = []
		
	    for (var i = 0; i < array_length(characters); i++){
	        if characters[i].id = "player" array_push(listAllies,i)
	        else array_push(listEnemies,i)
	    }
	}

	function getEnemy(_index = 0,_characterIndex=false){
		if _characterIndex = false{return characters[listEnemies[_index]] }
	    else return listEnemies[_index]
	}
	
	function getCurrentCharacter(){
		return characters[turn] 
		}
	
	function clearEffects(){
		with obj_player{
			skillHeal = [0,0]
			skillBlock = [0,0]
			skillFocus = [0,0]
			skillRest= [0,0]
			}
		}
	
	function lowerEffects(){
		with obj_player{
			if skillHeal[0] > 0 skillHeal[0] -- else skillHeal[1] = 0
			
			if skillRest[0] > 0 skillRest[0] -- else skillRest[1] = 0
			
			if skillBlock[0] > 0 skillBlock[0] -- else skillBlock[1] = 0
			
			if skillFocus[0] > 0 skillFocus[0] -- else skillFocus[1] = 0
			}
		}
	