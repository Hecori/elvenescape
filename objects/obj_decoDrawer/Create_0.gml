event_inherited()

label = "Estante de Madeira"

//Diálogos
	dialogues = ds_map_create()
	ds_map_add(dialogues,"msg1",new Dialogue(["Um armário de madeira velho.","Está cheio de pergaminhos em um idioma que você desconhece..."],1,label,"msg1"))
	dialoguesCurrent = ds_map_find_value(dialogues,"msg1")
	
depthSet(16)