getInput()

//Não teleportar para as salas
if room = rm_win instance_destroy(self)

//Ativar ou  desativar
if keyConsole { 
	if state = 0{
		keyboard_lastchar = ""
		state = 1}
		
	else{
		state = 0
		windowInput.text = "" 
		}
	}

//Escrever
if state = 1{
	//Rodar comando
	if keyboard_lastkey = vk_enter and windowInput.text != ""{
		
		//Salvar no historico
		history[array_length(history)] = windowInput.text
		historyIndex = array_length(history)
		
		//Extrair comando e executar
		command = string_split(windowInput.text," ")
		
		//Log
		var _msg = commandExecute(command)
		log += _msg
		if _msg != "" log+="\n"
		
		//Limpar
		windowInput.text = ""
		keyboard_lastkey = -1
		keyboard_lastchar = ""
		}
		
	//Apagar letra	
	else if keyboard_lastkey = vk_backspace{
		windowInput.text = string_copy(windowInput.text,0,string_length(windowInput.text)-1)
		keyboard_lastkey = -1
		keyboard_lastchar = ""
		}
	
	//Carregar comando anterior
	else if keyboard_lastkey = vk_up or keyboard_lastkey = vk_down{
		
		
		historyIndex += keyDownPressed-keyUpPressed
		
		historyIndex = min(array_length(history)-1,historyIndex)
		historyIndex = max(0,historyIndex)
		
		if array_length(history) > 0 windowInput.text = history[historyIndex]
		
		}
		
	//Se escreveu algo
	else if keyboard_lastchar != "" {
		windowInput.text+= keyboard_lastchar
		keyboard_lastchar = ""
		}
	}
	