function getHelp(){
	
	//Se o botão de ajuda não for pressionado
	//Mostrar mensagem de ajuda
	if (global.showHelpAtStart = 1 or keyH) and global.isScreenEmpty{
		//Mensagem
		global.showHelpAtStart = 0
		obj_guiTextBox.loadDialogue(dialoguesCurrent)
		}
	
}