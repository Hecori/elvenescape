getInput()

//Interação
	if state = 1{
		state = 0
		
		if locked{
			//Desbloquear
			if obj_itemManager.removeItemByKey("key"){ 
				locked = 0
				showKeyTip = false
				collisionIsEnabled = false
				dialoguesCurrent = ds_map_find_value(dialogues,dialoguesCurrent.next)
				obj_guiTextBox.loadDialogue(dialoguesCurrent)
				image_index+=1
			}
		}
		
		else{
			dialoguesCurrent = ds_map_find_value(dialogues,dialoguesCurrent.next)
			}
		
		//Dialogo normal
		obj_guiTextBox.loadDialogue(dialoguesCurrent)
	}
		
	else{
		if getInteraction(keyZ) state = 1
		}