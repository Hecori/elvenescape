function item_action(_action){
	var itemId = ds_map_keys_to_array(obj_itemManager.inventory)[obj_gui.inventorySelectedItem]
	var item = ds_map_find_value(obj_itemManager.inventory,itemId), _text = ""
		
	switch(_action){
		
		case "Beber":
			if item.key = "potionHealth" or item.key = "potionHealthLesser"{
				if obj_player.hp = obj_player.hpMax return "fail"
				else{
					var _oldHp = obj_player.hp
					obj_player.hp=clamp(obj_player.hp+item.heal,0,obj_player.hpMax)
					_text = string("Você recuperou {0} ponto(s) de vida.",obj_player.hp-_oldHp)
					}
				}
				
			else if item.key = "potionEnergy"{
				if obj_player.sp = obj_player.spMax return "fail"
				else{
					var _oldSp = obj_player.sp
					obj_player.sp=clamp(obj_player.sp+item.energy,0,obj_player.spMax)
					_text = string("Você recuperou {0} ponto(s) de energia.",obj_player.sp-_oldSp)
					}
				}
				
			//Apenas remove o item se so tiver um
			if item.amount > 1 item.amount --
			else obj_itemManager.removeItemById(itemId)
			return _text
			
		case "Largar":
			//Apenas remove o item se so tiver um
				if item.amount > 1 item.amount --
				else obj_itemManager.removeItemById(itemId)
			
			//Se estiver equipado
			if itemId = obj_itemManager.equipment.weapon {
				obj_itemManager.equipment.weapon = ""
				obj_player.dmg = {min:0,max:1}
				obj_player.magicDmg = {min:0,max:0,type:"none"}
				}
			else if itemId = obj_itemManager.equipment.armor {
				obj_itemManager.equipment.armor = ""
				obj_player.def = {min:0,max:1}
				}
				
			return ""
			
		case "Equipar":
			if item.type="weapon"{
				
				//Se ja houver uma arma equipada
				if obj_itemManager.equipment.weapon != "" obj_itemManager.getItemById(obj_itemManager.equipment.weapon).actions[0] = "Equipar"	
				
				obj_itemManager.equipment.weapon = itemId
				
				//Muda o dano
				obj_player.dmg.min = item.dmg.min
				obj_player.dmg.max = item.dmg.max
				obj_player.dmgMagic = {min:item.dmgMagic.min,max:item.dmgMagic.max,type:item.dmgMagic.type}
				}
				
			else if item.type="armor"{
				if obj_itemManager.equipment.armor != "" obj_itemManager.getItemById(obj_itemManager.equipment.armor).actions[0] = "Equipar"
					
				obj_itemManager.equipment.armor = itemId
				
				//Muda a defesa
				obj_player.def.min = item.def.min
				obj_player.def.max = item.def.max
				}
				
			//Mudar a ação pra de-equipar
			ds_map_find_value(obj_itemManager.inventory,itemId).actions[0] = "Remover"
			
			return ""
			
		case "Vestir":
			obj_itemManager.inventorySize+= 2
			obj_itemManager.removeItemById(itemId)
			return "Você veste a mochila e sente que pode carregar mais coisas com si."
		
		case "Ler":
			obj_itemManager.removeItemById(itemId)
			
			//Escolher e adicionar a skill
			var _skill = getNewSkill(item.skill)
			_skill.add()
			
			//Mensagem de utilização
			_text = string("Você leu {0} e aprendeu a habilidade: {1}",item.name, _skill.name)
			
			//Mostrar mensagem fora da batalha
			if room != rm_battle {
				obj_guiTextBox.loadDialogue(new Dialogue(_text))
				global.isMenuOpen = 0
				}
			
			return string(_text)
		
		case "Remover":
			if item.type="weapon"{
				obj_itemManager.equipment.weapon = ""
				obj_player.dmg = {min:0,max:1}
				obj_player.magicDmg = {min:0,max:0,type:"none"}
				}
			else if item.type="armor"{
				obj_itemManager.equipment.armor = ""
				obj_player.def = {min:0,max:1}
				}
				
			//Mudar a ação pra equipar
			ds_map_find_value(obj_itemManager.inventory,itemId).actions[0] = "Equipar"
			
			return ""
	}
}