event_inherited()

	image_speed = 0
	locked = 1

//Diálogo
	label = "Cela Velha"

	dialogues = ds_map_create()
	
	ds_map_add(dialogues,"doorLocked",new Dialogue(["A porta da cela está fechada...","Você precisa da chave..."],[1,1],label,"doorUnlocking"))
	ds_map_add(dialogues,"doorUnlocking",new Dialogue("A porta da cela foi destrancada!",1,label,"doorUnlocked"))
	ds_map_add(dialogues,"doorUnlocked",new Dialogue("Uma cela aberta",1,label,"doorUnlocked"))
	
	dialoguesCurrent = ds_map_find_value(dialogues,"doorLocked")