//Texto
	text = []
	lineText = ""
	label = "NoLabel"
	textSpeeds = []
	
	lineCurrent = 0 //Indice de "text"
	lineTextPos = 0 //Posição em "lineCurrent"
	
	dialogueHasEnded = false
	autoClose = -1
	canSkip = true
	
//Camera
	cameraSize = [view_get_wport(view_current),view_get_hport(view_current)]

//Box
	boxMargin = 16
	boxHeight = 128
    textPadding = 16

	boxX1 = boxMargin
	boxY1 = cameraSize[1]-boxMargin-boxHeight
	boxX2 = cameraSize[0]-boxMargin
	boxY2 = cameraSize[1]-boxMargin
	
//Funções 		
	function resetCurrentLine(){ //Apaga só a linha atual
		lineTextPos = 0
		lineText = ""
		}

	function clearCurrentText(){ //Apaga todo o diálogo
		resetCurrentLine()
		lineCurrent = 0
		label = "noLabel"
		text = []
		textSpeeds = []
		}
	
	function loadDialogue(_dialogue,_autoClose=-1,_canSkip = true){
		dialogueHasEnded = false
		autoClose = _autoClose
		canSkip = _canSkip
		
		clearCurrentText()
		array_copy(text,0,_dialogue.text,0,array_length(_dialogue.text))
        label = _dialogue.label
		textSpeeds = _dialogue.textSpeeds
		
		global.isTextBoxOpen = 1
		global.isScreenEmpty = 0
		}