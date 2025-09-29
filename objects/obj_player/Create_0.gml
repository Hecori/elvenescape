//Status
	hpMax = 10
	hp = hpMax

	spMax = 3
	sp = spMax

    atribStr = 1
	dmg={min:0,max:1}  //Min e Max, bônus e quanto do bônus ele perde no começo de cada turno
	
	dmgMagic={min:0,max:0,type:"none"}
	
    atribCon = 1
	
	def = {min:0,max:1}

	level = 1
	xp = [0,5,0]
	
	name = "Finem"

//Variáveis de movimento
	move_dir = [0,0]	
	spdAcc = 0.2
	maxSpd = 1.2

	vsp = 0
	hsp = 0

	isTryingToMove = 0
	
//Habilidades
	skills = ds_map_create()
	newSkill = "" //Habilidade ganha ao passar de nível

	getNewSkill("rest").add()
	getNewSkill("block").add()

	skillHeal = [0,0]
	skillRest = [0,0]
	skillBlock = [0,0]
	skillFocus = [0,0]

//Flag
	hasLevedUp = false

//Variáveis de Interação
	facingDirection = [0,1] // 1 direita, -1 esquerda | 1 baixo, -1 cima

	interactionRange = 6
	interactionSpot = [x,y+interactionRange]

//Debug
	global.modeDebug = -1

//Ajuda
	dialogues = ds_map_create()
	
	new Dialogue(["Controles:\n(Z) Para interagir com o ambiente, confirmar uma ação e avançar para o próximo diálogo.\n(X) Volta em uma ação e acelera o diálogo para passar mais rápido.\n(C) Abre e fecha o inventário com as informações do personagem.",
				"(A) ou (Seta Esquerda): Andar para a esquerda.\n(D) ou (Seta Direita): Andar para Direita.\n(W) ou (Seta para Cima): Andar para cima.\n(S) ou (Seta para Baixo) Andar para baixo.\n",
				"Objetivo:\nO seu objetivo é explorar as diferentes salas subterrâneas, coletar equipamentos e derrotar oponentes para conseguir escapar. Seu personagem possui um número limitado de pontos de vida, que diminuem sempre que sofre dano. Ao derrotar inimigos você coleta pontos de experiência, que ao passar de um certo limite, aumentam o nível do",
				"personagem, tornando-o mais forte. \nAlém disso você pode abrir o inventário (Botão C) para equipar ou remover diferentes equipamentos, usar itens de cura e conferir o status do personagem. Interaja com baús para conseguir itens, use a sua cama que fica no canto superior direito da cela inicial para se curar quando necessário e derrote os oponentes para que você consiga avançar no jogo.","Você pode usar o botão de ajuda (H) para mostrar essa mensagem novamente caso deseje. Aperte (ESC) para abrir o menu. Leia as placas sempre que possível e boa sorte! :)"],).add(dialogues,"help1")
	
	dialoguesCurrent = ds_map_find_value(dialogues,"help1")

//Other
	global.enemyList = []
	global.days = 1

//Inventário
	if !instance_exists(obj_itemManager) instance_create_depth(x,y,depth,obj_itemManager)

//Funções
	function sprite_change(_sprite) {if _sprite != sprite_index sprite_index = _sprite}
	
	function addXp(_amount){
		//Soma o xp
		xp[0] += _amount
		xp[2] += _amount
		
		while xp[0] >= xp[1]{
			hasLevedUp = true
			level+=1
			xp[0] = xp[0] - xp[1]
			xp[1] = level*5
			
			//Ganhar uma skill nova quando atingir um novo nível 
			newSkill = getNewSkill(level)
			show_debug_message(newSkill)
			
			//Vida
			var _hpBonus = 4
			hpMax += _hpBonus; hp = hpMax
			
			var _spBonus = 2
			spMax += _spBonus; sp = spMax
			}
	}