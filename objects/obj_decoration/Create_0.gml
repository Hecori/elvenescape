event_inherited()

//Variação na animação
	image_speed *= random_range(0.9,1.1)

//Diálogos
	dialogues = ds_map_create()
	ds_map_add(dialogues,"deco1",new Dialogue(["Decoração generica"],[1],"Generic Decoration"))
	dialoguesCurrent = ds_map_find_value(dialogues,"deco1")

		
