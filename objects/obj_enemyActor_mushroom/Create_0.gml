event_inherited();

label = "Zumbi Cogumelo"

//Dialogo
	dialogues = ds_map_create()
	
	new Dialogue(["GRRRRRRRRRRRRRRRRRR!!!!!!!!!!!"],1,label,"battle").add(dialogues,"msg1")
	
	dialoguesCurrent = ds_map_find_value(dialogues,"msg1")
