//Adicionar os inimigos apenas no começo da batalha
if initialSetup{
	//Criar inimigos caso nenhum seja definid, apenas para testes  
	if array_equals(global.enemyList,[]){
		initialSetup = false
	
		addCreature("player")
		addCreature("mushroom1",2)
	
		system.charactersUpdate()
	
		}
	
	//Em caso de uma batalha real com inimigos pré-definidos	
	else{
		show_debug_message(global.enemyList)
		initialSetup = false
		addCreature("player")
	
		while (array_length(global.enemyList) > 0){	
			var _enemy = array_shift(global.enemyList)
			addCreature(_enemy)
			}
		system.charactersUpdate()
	
	}
}