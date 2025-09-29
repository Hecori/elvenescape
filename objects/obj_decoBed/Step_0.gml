getInput()

//Cama normal
if ID = 0{
	//Interação
	if state = 1{
		state = 0
		obj_guiTextBox.loadDialogue(dialoguesCurrent)
	}
		
	else{
		if getInteraction(keyZ) state = 1
		}
	}

//Sua cama
else{
	//Interagir com a cama pela primeira vez
	if state = 0 and getInteraction(keyZ){
		state = 1
		obj_guiTextBox.loadDialogue(dialoguesCurrent)
		}
		
	//Descançar	
	else if state = 1 and getInteraction(keyZ){
		state = 2
		rest()
		//Texto
		obj_guiTextBox.loadDialogue(ds_map_find_value(dialogues,"bedC1"),60,false)
	}
	
	//Transição
	else if state = 2 and obj_guiTextBox.dialogueHasEnded{
		state = 3
		with instance_create_depth(x,y,-9999,obj_fxRoomTransition){
			timeEnd = 60
			type = "fadeOut"
			action = "rest"
			}
		}
	
	//Texto
	else if state = 3 and !instance_exists(obj_fxRoomTransition){
		state = 4
		obj_guiTextBox.loadDialogue(new Dialogue("Você se sente revigorado. Seus pontos de vida e energia foram totalmente recuperados!"))
		}
	else if state = 4 and obj_guiTextBox.dialogueHasEnded state = 1
	}
