event_inherited()

//Diálogos
	dialogues = ds_map_create()
	label = "Cama Velha"; if ID = 1 label = "Sua Cama"
	
	//Cama genérica
    new Dialogue("Uma cama velha e meio suja",1,label,"bedA1").add(dialogues,"bedA1")
	
	//Sua cama
	new Dialogue("Uma cama velha, você não lembra quanto tempo esteve dormindo aqui mas parece ser sua. \nVocê pode interagir com a SUA cama quando estiver machucado para recuperar todos os seus pontos de vida e de energia. \nNo entanto você aumenta a quantidade de dias em +1 e perde 1 de experiência. Use apenas quando necessário",1,label,"rest").add(dialogues,"bedB1")
	
	//Dialogo ao dormir
	new Dialogue("Você se deita em sua cama para descançar e recuperar seus recursos...",2,label).add(dialogues,"bedC1")
	
//Per object
    switch(ID){
        case 1:
            dialoguesCurrent = ds_map_find_value(dialogues,"bedB1")
            break
        default:
            dialoguesCurrent = ds_map_find_value(dialogues,"bedA1")
    }
depthSet(6)