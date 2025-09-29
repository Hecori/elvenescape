event_inherited();

label = "General Cogumelo"

//Dialogo
	dialogues = ds_map_create()
	
	new Dialogue(["Vejo que conseguiu escapar de sua cela com certa facilidade...\nSe quiser ter sua liberdade terá que mostrar que é capaz de sobreviver lá fora..."],1,label,"battle").add(dialogues,"msg1")
	new Dialogue(["Deseja tentar de novo...?"],1,label,"battle").add(dialogues,"msg2")
	
	dialoguesCurrent = ds_map_find_value(dialogues,"msg1")
