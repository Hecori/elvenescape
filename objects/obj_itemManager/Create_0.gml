#region Lista de itens do jogo
	itemBase = ds_map_create()
	
	//Funcão de adicionar itens a base
		function itemAdd(_item) {
			_item.amount = 1
			ds_map_set(obj_itemManager.itemBase,_item.key,_item)
			}
			
	//Chaves
		itemAdd({key:"key",
				name:"Chave",
				description:"Uma chave enferrujada e pequena, pode ser utilizada para abrir as celas comuns desse lugar.",
				type:"key",
				actions:[],
				isStackable:false})
	
	//Armas
		itemAdd({key:"dagger",
				name:"Adaga",
				description:"Uma adaga antiga, pode ser utilizada como arma mesmo enferrujada.",
				type:"weapon",
				dmg:{min:1,max:2,type:"normal"},
				dmgMagic:{min:0,max:0,type:"none"},
				effect:"none",
				actions:["Equipar","Largar"],
				isStackable:false})			
		itemAdd({key:"daggerVampiric",
				name:"Punhal Vampírico",
				description:"Uma lâmina pequena, a bainha possui marcações relacionadas a \"absorver vida\".",
				type:"weapon",
				dmg:{min:1,max:2,type:"normal"},
				dmgMagic:{min:0,max:1,type:"vampiric"},
				effect:"heal",
				heal:{chance:33,amount:1},
				actions:["Equipar","Largar"],
				isStackable:false})			
		itemAdd({key:"daggerIce",
				name:"Adagas \"Glacius\"",
				description:"Um conjunto de duas adagas, a lâmina das duas contém símbolos que brilham em azul claro.",
				type:"weapon",
				dmg:{min:1,max:2,type:"normal"},
				dmgMagic:{min:1,max:2,type:"ice"},
				effect:"none",
				actions:["Equipar","Largar"],
				isStackable:false})
		itemAdd({key:"katanaElectric",
				name:"Katana \"Tempestade\"",
				description:"Um tipo de espada de lâmina longa e curvada, emite pequenas faíscas de tempos em tempos.",
				type:"weapon",
				dmg:{min:1,max:3,type:"normal"},
				dmgMagic:{min:1,max:3,type:"electric"},
				effect:"none",
				actions:["Equipar","Largar"],
				isStackable:false})		
		itemAdd({key:"swordFlaming",
				name:"Espada Longa \"Vulcano\"",
				description:"Uma espada de lâmina longa que emana brasas quando usada em ataques, mais pesada que uma Espada Curta porém suas propriedades mágicas compensam por isso. Possui runas em algum dialeto anão.",
				type:"weapon",
				dmg:{min:0,max:5,type:"normal"},
				dmgMagic:{min:0,max:2,type:"fire"},
				actions:["Equipar","Largar"],
				effect:"none",
				isStackable:false})
		itemAdd({key:"swordShort",
				name:"Espada Curta",
				description:"Uma espada de ferro, possui uma lâmina não muito grande",
				type:"weapon",
				dmg:{min:1,max:3,type:"normal"},
				dmgMagic:{min:0,max:0,type:"none"},
				effect:"none",
				actions:["Equipar","Largar"],
				isStackable:false})		
		itemAdd({key:"halberdGolden",
				name:"Alabarda Dourada \"Nebula\"",
				description:"Um tipo de alabarda simplificada feita de um metal dourado, contém uma aura sombria e é envolta de runas élficas.",
				type:"weapon",
				dmg:{min:2,max:4,type:"normal"},
				dmgMagic:{min:1,max:5,type:"dark"},
				effect:"none",
				actions:["Equipar","Largar"],
				isStackable:false})
	
	//Armaduras
		itemAdd({key:"armorLeather",
				name:"Armadura Leve de Couro",
				description:"Um conjunto de peças leves de armadura, feitas a partir de um couro velho. Nada exagerado mas serve.",
				type:"armor",
				def:{min:0,max:2},
				actions:["Equipar","Largar"],
				isStackable:false})		
		itemAdd({key:"armorIron",
				name:"Armadura Média de Ferro",
				description:"Peças de uma armadura feitas a partir de ferro. Parece ter pertencido a algum guarda deste lugar.",
				type:"armor",
				def:{min:1,max:3},
				actions:["Equipar","Largar"],
				isStackable:false})		
				
	//Poções
		itemAdd({key:"potionHealthLesser",
				name:"Poção de Cura Menor",
				description:"Um frasco pequeno contendo um líquido vermelho. Pode ser usado para recuperar sua vida mas em pouca quantidade.",
				type:"potionHealth",
				heal:5,
				actions:["Beber","Largar"],
				isStackable:true})
		itemAdd({key:"potionHealth",
				name:"Poção de Cura",
				description:"Um frasco médio contendo um líquido vermelho. Pode ser usado para recuperar sua vida, recupera uma grande quantidade de vida",
				type:"potionHealth",
				heal:10,
				actions:["Beber","Largar"],
				isStackable:true})
		itemAdd({key:"potionEnergy",
				name:"Poção de Energia",
				description:"Um frasco médio contendo um líquido azul claro. Parece emitir feixes fracos de luz quando o frasco é movimentado.",
				type:"potionEnergy",
				energy:5,
				actions:["Beber","Largar"],
				isStackable:true})
	
	//Upgrades
		itemAdd({key:"bag",
				name:"Mochila Velha",
				description:"Uma mochila velha feita a partir de retalhos costurados cautelosamente por algum artesão há muitotempo atrás.",
				type:"bag",
				energy:5,
				actions:["Vestir","Largar"],
				isStackable:true})
				
	//Habilidades
		itemAdd({key:"tomeFireBlast",
				name:"Tomo: \"Explosão de Chamas\"",
				description:"Uma espécie de tomo antigo contendo símbolos desconhecidos. A tinta parece ainda estar quente ao toque.",
				type:"skill",
				skill:"fireBlast",
				actions:["Ler","Largar"],
				isStackable:false})
	
#endregion

//Inventário
    inventorySize = 5
	inventory = ds_map_create()
	
//Equipamento
	equipment = {
		weapon: "",
		armor:""
		}
	
	
/// @desc Adiciona um item ao inventário do jogador
/// @param {String} key Chave que representa o item
/// @param {real} amount Quantidade desse item a ser adicionado
/// @returns {array} Array Retorna se o item foi adicionado e uma mensagem explicando o porque desse resultado

function addItemInventory(_key,_amount){ 
    var inventoryAmount = array_length(ds_map_keys_to_array(inventory))
	var newID = false
	
	//Se já existir
    if ds_map_exists(inventory,_key){
		var item = ds_map_find_value(inventory,_key)
		if item = -1 return [false,"Não existe um item com esse nome"]
		
		if item.isStackable{
			item.amount += _amount
			return [true,"Item adicionado com sucesso, adicionado a outro"]  
			}
			
		else if inventoryAmount >= inventorySize{
			return [false,"Você não pode carregar mais desse item"]  
			}
			
		else newID = true	
       }
	  
	   
	//Adiciona um novo item se houver espaço
	if inventoryAmount < inventorySize{
		
		//Criar novo item
		var newItem = variable_clone(ds_map_find_value(itemBase,_key))
		
		//Quantidade
		newItem.amount = _amount
		var keyName = _key
		
		//Se ja tiver um item, gerar novo id
		if newID keyName+=string(irandom_range(1,1000000))
		
		//Adiciona
		ds_map_add(inventory,keyName,newItem)
		return [true,"O item foi adicionado ao inventário com sucesso"]
		}

	//Se não houver espaço
	else{ 
		return [false,"Não existe espaço no seu inventário"]}
	}
	
//Tenta remover um item do inventário, retorna True se conseguir
function removeItemByKey(_key){

	var keys = ds_map_keys_to_array(inventory)
	
	for(var i = 0; i < array_length(keys);i++){
		if ds_map_find_value(inventory,keys[i]).key = _key{
			ds_map_delete(inventory,keys[i])
			
			//Atualizar slot selecionado caso seja o ultimo da lista
			var _keys = ds_map_keys_to_array(inventory)
			obj_gui.inventorySelectedItem = array_length(_keys) obj_gui.inventorySelectedItem --
			return true
			}
		}
	
	return false
}

function removeItemById(_id){
	ds_map_delete(inventory,_id)
}
	
function getItemName(_key){
	var item = ds_map_find_value(itemBase,_key)
	return item.name
	}
	
function getItemByIndex(_index){
	var itemKeys = ds_map_keys_to_array(inventory),item = ds_map_find_value(inventory,itemKeys[_index])
	return item
	}	
	
function getItemById(_id){
	return ds_map_find_value(inventory,_id)
	}	