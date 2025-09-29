event_inherited()

//Diálogos
	dialogues = ds_map_create()
	ds_map_add(dialogues,"table1",new Dialogue("Uma mesa de madeira relativamente velha. Não parece haver nada útil para você sob ela.",1,"Mesa de Madeira"))
	dialoguesCurrent = ds_map_find_value(dialogues,"table1")
	
depthSet(4)

showKeyTip = false