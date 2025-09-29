event_inherited()

//Diálogos
	dialogues = ds_map_create()
	ds_map_add(dialogues,"table1",new Dialogue(["Uma mesa de madeira antiga","Está vazia"],[1,0.5],"Mesa de Madeira"))
	dialoguesCurrent = ds_map_find_value(dialogues,"table1")
	
depthSet(4)

showKeyTip = false