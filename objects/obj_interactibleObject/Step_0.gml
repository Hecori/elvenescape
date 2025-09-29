getInput()

//Interação
	if state = 1{
		state = 0
		obj_guiTextBox.loadDialogue(dialoguesCurrent)
		
		//Pega o próximo diálogo com base no nextDialogue do diálogo atualvvvvv
		if dialoguesCurrent.next != "none"{
			dialoguesCurrent = ds_map_find_value(dialogues,dialoguesCurrent.next)
			}
		}
		
	else{
		if getInteraction(keyZ) state = 1
		}