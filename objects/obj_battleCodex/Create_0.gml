//Sistema
	system = obj_battleSystem
	initialSetup = true
	state = "menu"
	
//Criaturas
	function player() constructor{
	    id = "player"
		x = 0
		y = 0
		
		spritePos = [700,445] //450
		imageIndex = 0
		sprite={idle:spr_finemBatle_idle,hit:spr_finemBatle_hurt}
		hasBeenDamaged = false
	}

	function enemy(_id) constructor{
		id = _id
		x = 0
		y = 0
		state = 1
		checkTip = "Nenhuma informação adicional."
		imageIndex = 0
		alpha = 1
        
		//0-Nome do inimigo 1-Nome do player 2- dano total normal 3- dano magico 4- tipo de dano magico
		msg = {hit:["{0} ataca {1} e causa {2} de dano..."],
				miss:["{0} tentou atacar {1} mas errou..."]}
		
		//Stats
		hp = 7
		def = {min:0,max:0,bonus:0}
		dmg = {min:0,max:1,bonus:0,type:"normal"}
		dmgMagic = {type:"",min:0,max:0}
		
		
        
		//Zumbi cogumelo
		if _id = "mushroom1"{
		    name = "Zumbi Cogumelo"
			sprite = {idle:spr_enemyMushroomIdle,hit:spr_enemyMushroomHit,attack:"slash"}
            checkTip = "Um inimigo relativamente fraco quando não está em grupos."
			dmg.min=0; dmg.max = 3
			def.max = 1
			
			//Recompensas
			rewards = {xp:irandom_range(1,2),item:choose("potionHealthLesser","potionHealthLesser","potionHealth","potionHealth","potionEnergy"),
								itemChance:20}
			
			//Mensagem
			msg = {hit:["{0} atacou {1} com suas garras. Você sofre {2} de dano físico."],
				miss:["{0} tentou atacar com suas garras, mas {1} bloqueou..."]}
			
			//Aleatoriedade
			hp += irandom_range(-1,1)
			}
			
		else if _id = "dummy1"{
		    name = "Boneco de Treinamento"
			sprite = {idle:spr_enemyDummyIdle,hit:spr_enemyDummyHit,attack:"slash"}
            checkTip = "Um tipo de manequim inanimado de madeira com um elmo antigo."
			hp = 999
			
			//Recompensas
			rewards = {xp:1000,item:"",itemChance:20}
			}
			
		else if _id = "boss1"{
		    name = "General Cogumelo"
			sprite = {idle:spr_enemyBossIdle,hit:spr_enemyBossHit,attack:"slash"}
            checkTip = "Portando uma Alabarda Dourada, a mesma está envolta de uma aura sombria. Possuindo dano elemental que consegue EVITAR a sua defesa, causando dano direto. Não esqueça de se curar quando possível."

			//Mensagem
			msg = {hit:["{0} realizou um ataque rápido contra {1} e causou {2} de dano Físico. Você sente um efeito extra do ataque, sofrendo mais {3} de dano {4}."],
			miss:["{0} tentou acertar {1} com magia, mas não acertou..."]}
			
			//Status de batalha
			hp = 50
			def.min = 0; def.max = 4
			dmg.min = 1; dmg.max = 5; dmg.type = "mixed"
			dmgMagic.type = "dark"; dmgMagic.min = 0 dmgMagic.max = 2
			
			rewards={xp:30,item:"halberdGolden",itemChance:100}
			}
		
		else if _id = "mage"{
		    name = "Mago Cogumelo"
			sprite = {idle:spr_enemyMushroomMageIdle,hit:spr_enemyMushroomMageHit,attack:"fireBlast"}
            checkTip = "Seus ataques não podem ser reduzidos por serem mágicos, porém este inimigo possui pouca vida."
			
			rewards={
				xp:irandom_range(1,4),
				item:choose("tomeFireBlast","potionEnergy","potionEnergy","potionEnergy","potionEnergy","potionEnergy"),
				itemChance:40}
			//Mensagem
			msg = {hit:["{0} conjurou uma magia de fogo explosiva. {1} sofreu {2} de dano {3}."],
			miss:["{0} tentou acertar {1} com magia, mas não acertou..."]}
			
			//Aleatoriedade
			dmg.max = 0; dmg.min = 0; dmg.type = "magic"
			dmgMagic.min = 0; dmgMagic.max = 2+irandom(1);	dmgMagic.type = "fire"
			
			hp = 10 + irandom_range(-1,2)
			}
			
		else if _id = "mimic"{
		    name = "Baú Mímico"
			sprite = {idle:spr_enemyMimicIdle,hit:spr_enemyMimicHit,attack:"slash"}
            checkTip = "Um baú de madeira antigo consumido pelos cogumelos amaldiçoados desse lugar. Não é muito forte mas possui bastante defesa..."
			
			rewards={xp:irandom_range(1,4),
				item:choose("potionHealth","tomeFireBlast","daggerIce","swordFlaming","katanaElectric","potionHealthLesser","potionHealth","potionEnergy","bag","armorLeather"),
				itemChance:50}
			
			//Mensagemzxz
			msg = {hit:["{0} mordeu {1} e causou {2} de dano Físico e {3} de dano {4}."],
			miss:["{0} tentou morder {1} mas errou."]}
			
			//Aleatoriedade
			dmg.mmin = 1; dmg.max = 4; dmg.type = "mixed"
			dmgMagic.min = 0; dmgMagic.max = 2; dmgMagic.type = "dark"
			
			def.min = 0; def.max = 3
			hp = 8
			}
		
		hpMax = hp
		sprite.current = sprite.idle
			
		//IA/Pensar na ação	
		function getAction(){
			if id = "mushroom1" return ["enemyAttack","phase1"]
			else if id = "dummy1" return ["enemyNothing","phase1"]
			else if id = "boss1" return ["enemyAttack","phase1"]
			else if id = "mage" return ["enemyAttack","phase1"]
			else if id = "mimic" return ["enemyAttack","phase1"]
			}
		//Atacar
		function actionAttack(_player,_x,_y){
			var _dmgBase = irandom_range(dmg.min,dmg.max), _dmgReduction = irandom_range(_player.def.min,_player.def.max)+_player.skillBlock[1], _dmgMagic = {type:dmgMagic.type,dmg:irandom_range(dmgMagic.min,dmgMagic.max)}
			
			//Dano inicial, redução do dano, dano final(sem o mágico) , dano magico
			var _dmg = {
									base:_dmgBase,
									block:_dmgReduction,
									final:max(_dmgBase - _dmgReduction,0)+_dmgMagic.dmg,
									magic:_dmgMagic
									}
			
			_player.hp -= _dmg.final 
			if _dmg.final > 0 obj_battleGui.playerGui.hasBeenDamaged = true
			
			obj_battleEffects.particleAdd("damagePlayer",_x,_y,_dmg)
			return _dmg
			}
		//Sofrer dano
		function takeDamage(_dmg){
			var _dmgBlock = irandom_range(def.min,def.max), _trueDmg = max(_dmg.dmg-_dmgBlock,0) + _dmg.magic.dmg
			
			//Somar o dano mágico
			hp = max(hp-_trueDmg,0)
			
			//Death
			if hp = 0 {
				state = 0
				
				with(obj_battleSystem){
					numberOfEnemies --
					rewardPool.xp+= other.rewards.xp
					
					 //Adicionar item a tabela de possíveis premios
					array_push(rewardPool.items,other.rewards.item)
					array_push(rewardPool.chances,other.rewards.itemChance)
					}
				}
			return {base:_dmg.dmg,block:_dmgBlock,final:_trueDmg,magic:_dmg.magic}
			}	
	 }
	 
//Funções
	function getCreature(_id){
		switch(_id){
			case "player":
				var playerTemp = new player()
				system.playerGui = playerTemp 
				return playerTemp
			default:
				system.numberOfEnemies ++
				return new enemy(_id)
			}
		}
		
	function addCreature(_id,_amount = 1){
		for(var i = 0; i<_amount; i++){
			var creature = getCreature(_id)
			//Adiciona um número ao nome se houverem criaturas repetidas 
			if _amount > 1{
				creature.name+=" "+string(i+1)} 
				
			array_push(system.characters,creature)
			}
		}