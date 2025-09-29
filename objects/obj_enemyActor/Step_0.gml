getInput()

//Interação
	switch(state){
		//Idle
		case 0:
			if getInteraction(keyZ) state = 1
		break
		
		//Interagindoo
		case 1:
			state = 0
			
			//Mostrar o diálogo atual
			obj_guiTextBox.loadDialogue(dialoguesCurrent)
		
			//Começar uma batalha ou avançar o diálogo
	        if dialoguesCurrent.next = "battle" state = 2
			if dialoguesCurrent.next != "none" and dialoguesCurrent.next != "battle" {dialoguesCurrent = ds_map_find_value(dialogues,dialoguesCurrent.next)}
        
		break
		
		//Iniciar batalha
		case 2:
			if obj_guiTextBox.dialogueHasEnded{
				state = 0
				startBattle(enemyList,self)
				}
		break
		
		//Derrotado
		case -1:
			if !immortal {
				instance_destroy(self)
				instance_destroy(collision)
				}
			else state = 0
			
		break
		
		} 

		