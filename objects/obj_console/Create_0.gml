state = 0

windowMain = {
	x:32,y:32,width:view_get_wport(view_current)-64,height:view_get_hport(view_current)-128,margin:8}

windowInput = {
	x:windowMain.x,y:view_get_hport(view_current)-64,width:windowMain.width,height:32,
	text:""
	}

command = []
log = ""
history = []
historyIndex = 0

//Executa um comando
function commandExecute(_commandArgs){
	var _obj = noone
	
	switch(_commandArgs[0]){
		case "help": //Comandos
			return "clear : Limpa o log\nadd [itemKey] [amount] : Adiciona itens ao inventário do player\nmove [objName] : Teleporta o objeto para a posição do mouse\nmod [variable] [newValue] : Altera o valor de uma variável do objeto abaixo do mouse\ninfo : Mostra informações sobre o objeto\ndebug : Ativa ou desativa o modo debug\nreset : Reinicia o jogo"
		
		case "clear":
			log = ""
			return ""
		
		case "reset":
			game_restart()
			return ""
		
		case "debug":
			global.modeDebug /=-1
			return "Modo debug: "+string(bool(global.modeDebug+1))
		
		case "info":
			_obj = instance_position(mouse_x,mouse_y,all)
			
			//Numero de argumentos errado
			if array_length(_commandArgs) > 1 return "Número de argumentos errado"
			
			else if _obj = noone return "Não existe quaisquer objetos abaixo do mouse"
			else{
				var _variables = variable_instance_get_names(_obj),_text = string(_obj.object_index)+": \n"
				
				for(var i = 0; i<array_length(_variables);i++){
					_text+=string("{0} = {1} / ",_variables[i],variable_instance_get(_obj,_variables[i]))
					}
				
				return _text
			}
		
		case "add":
			//Numero de argumentos errado
			if array_length(_commandArgs) != 3 return "Número de argumentos errado"
			
			//var _item = obj_itemManager.addItemInventory(_commandArgs[1],string_digits(_commandArgs[2]))
			var _item = obj_itemManager.addItemInventory(_commandArgs[1],1)
			return string(_item)
			
		case "mod":
			_obj = instance_position(mouse_x,mouse_y,all)
			
			//Numero de argumentos errado
			if array_length(_commandArgs) = 1 or array_length(_commandArgs) > 3 return "Número de argumentos errado"
			
			else if _obj = noone return "Não existe quaisquer objetos abaixo do mouse"
			else{
				if !variable_instance_exists(_obj.id,_commandArgs[1]) return string("Objeto: {0} não possui a variável {1}",_obj.id,_commandArgs[1])
				else{
					variable_instance_set(_obj.id,_commandArgs[1],_commandArgs[2])
					return "Valor alterado com sucesso!"
					}
				}
		case "move":
		
			//Numero de argumentos errado
			if array_length(_commandArgs) = 1 or array_length(_commandArgs) > 2 return "Número de argumentos errado"
		
			_obj = asset_get_index(_commandArgs[1])
			if _obj = -1 return "O objeto especificado não existe"
			else {
				_obj.x = mouse_x
				_obj.y = mouse_y
				return string("O objeto {0} foi movido para x:{1} y:{2}",_commandArgs[1],mouse_x,mouse_y)
				}
		default:
			return "Comando não existente."
		}
	}