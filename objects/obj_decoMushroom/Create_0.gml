event_inherited()

label = "Cogumelo Azul"

//Diálogos
	dialogues = ds_map_create()
	ds_map_add(dialogues,"msg1",new Dialogue(["Uma espécie de cogumelo azul, parece emitir um brilho fraco...\nProvavelmente não é comestível."],1,label,"msg1"))
	dialoguesCurrent = ds_map_find_value(dialogues,"msg1")
	
depthSet(16)
