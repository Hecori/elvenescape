event_inherited();

label = "Boneco de Treinamento"
immortal = true

//Dialogo
	dialogues = ds_map_create()
	
	new Dialogue(["Parece ser um tipo de boneco de madeira usado para treinamento.\nTermine este diálogo para entender como o sistema de batalha funciona."],1,label,"battle").add(dialogues,"msg1")
	
	dialoguesCurrent = ds_map_find_value(dialogues,"msg1")
