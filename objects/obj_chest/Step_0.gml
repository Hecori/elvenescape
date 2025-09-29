getInput()

if getInteraction(keyZ){
	
	//Fechado
	if state = 0{
		
		//Pega o primeiro ítem do baú
		var item = ds_list_find_value(itens,0)
		var addingItem = obj_itemManager.addItemInventory(item[0],item[1])
        
		if addingItem[0]{
			
			//Remove o primeiro item do baú
			ds_list_delete(itens,0)
			
			//Texto que aparece ao pegar um item
			var text = string("Você encontrou: {0} x{1}",obj_itemManager.getItemName(item[0]),item[1])
			obj_guiTextBox.loadDialogue(new Dialogue(text,1,label))
			
			//Baú vazio
			if ds_list_empty(itens){
				state = 1
				image_index = 1}
			}
		
		else obj_guiTextBox.loadDialogue(new Dialogue(string(addingItem[1]),1,label))
		}
	
	//Aberto / Não tem items
	else{    
			obj_guiTextBox.loadDialogue(new Dialogue("Este baú está vazio",1,label))
		}	
	}