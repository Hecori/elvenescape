event_inherited();

label = "Baú Mímico"

//Dialogo
	dialogues = ds_map_create()
	
	new Dialogue("Grrrrr... EHH??!!\n(Este baú claramente era uma armadilha)",1,label,"battle").add(dialogues,"msg1")
	
	dialoguesCurrent = ds_map_find_value(dialogues,"msg1")
