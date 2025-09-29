event_inherited();

label = "Mago Cogumelo"

//Diálogo random
	texts = ["Um prisioneiro escapou?","Espero que esteja pronto para isso-","QUEM É VOCÊ-","Prepare-se-","DE ONDE VOCÊ VEIO???-","Isso vai ser interessante..."]

//Dialogo
	dialogues = ds_map_create()
	
	new Dialogue(texts[irandom(array_length(texts)-1)],1,label,"battle").add(dialogues,"msg1")
	
	dialoguesCurrent = ds_map_find_value(dialogues,"msg1")
