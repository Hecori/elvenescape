event_inherited()

//Diálogo
	label = "Placa de Madeira"
	dialogues = ds_map_create()
	
	
	
	new Dialogue(["Ao interagir com baús (Z) você adquire um item caso você tenha espaço em seu inventário. Baús ficaram abertos quando não houverem mais itens, caso um baú continue fechado mesmo após você pegar o item dele, significa que este ainda contém algum item que pode ser útil.","Armas e armaduras devem ser equipadas para que seus efeitos sejam aplicados ao seu personagem. Itens como como Poções de Cura são gastos ao consumidos, esses em específico só podem ser usados quando você tiver sofrido dano.\nAs celas da prisão só podem ser abertas quando você possuir uma Chave em seu inventário, estas não podem ser largadas pois são itens especiais.","Ao derrotar inimigos, existe uma chance que estes deixem itens para trás quando forem derrotados. Você ganha esse item quando você você ganha uma luta e tem espaço sobrando no inventário para guardar tal item. Caso você não tenha espaço, o item desaparece.","Para saber qual item um inimigo pode largar, use a ação especial \"Checar\", a mesma mostra também a chance que tem daquele inimigo largar o item. Caso mais de um inimigo largue o mesmo tipo de item na mesma batalha, você recebe um bônus de +10% de chance de receber aquele item para cada inimigo extra derrotado."],1,label,"msgA").add(dialogues,"msgA")
	new Dialogue(["Derrote inimigos para liberar o caminho e conseguir acessar outras áreas e ganhar experiência para subir de nível. \nPara causar dano, use a ação de Ataque, o dano é aleatorizado dentro do intervalo de dano mínimo e máximo que pode ser visto no seu inventário.",
				"O nome dos inimigos começa em branco mas se torna mais vermelho quanto mais próximo de zero.\nO seu nome também segue a mesma lógica, antes de agir confira seus status.\nPara isso, abra seu inventário durante a luta."],1,label,"msgB").add(dialogues,"msgB")
	new Dialogue(["Use as chaves para abrir as portas e conseguir equipamento para se tornar mais forte.\nNão se esqueça, se enfrentar um inimigo muito forte, você tem sempre a opção de fugir do combate para se curar e pensar em outras estratégias."],1,label,"msgC").add(dialogues,"msgC")
	
	new Dialogue(["Ao seguir o corredor a frente, você sente que a saída está próxima\nMas também que mais inimigos estão por esse caminho, talvez seja uma boa ideia possuir itens de cura e equipamento o suficiente."],1,label,"msgD2").add(dialogues,"msgD")
	new Dialogue(["Pegue itens fortes o bastante para prosseguir..."],1,label,"msgD2").add(dialogues,"msgD2")
	
	new Dialogue(["Acima desta cela, uma criatura diferente das vistas até agora, possivelmente o Líder desses monstros vistos até agora. Não é uma boa ideia passar daqui com pouca vida... ","Este é o seu último aviso..."],1,label,"msgE").add(dialogues,"msgE")
	new Dialogue(["Essa área está PREENCHIDA com inimigos, parece não ser uma boa ideia entrar sem ter formas de se curar ou equipamento bom o suficiente...","Mas provavelmente deve ter algum tesouro que pode ser útil no final...","A decisão é sua :)"],1,label,"msgF").add(dialogues,"msgF")
	
	new Dialogue(["Placa sem texto"],1,label,"msgZ").add(dialogues,"msgZ")
	
	if ID = "itens" dialoguesCurrent = ds_map_find_value(dialogues,"msgA")
	else if ID = "enemies" dialoguesCurrent = ds_map_find_value(dialogues,"msgB")
	else if ID = "keys" dialoguesCurrent = ds_map_find_value(dialogues,"msgC")
	else if ID = "caution" dialoguesCurrent = ds_map_find_value(dialogues,"msgD")
	else if ID = "last" dialoguesCurrent = ds_map_find_value(dialogues,"msgE")
	else if ID = "Challenge1" dialoguesCurrent = ds_map_find_value(dialogues,"msgF")
	
	else dialoguesCurrent = ds_map_find_value(dialogues,"msgZ")