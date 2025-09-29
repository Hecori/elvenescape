getInput()

//Definir se a tela está vazia
global.isScreenEmpty = !(global.isMenuOpen or 
						global.isTextBoxOpen or 
						instance_exists(obj_fxRoomTransition) or 
						room=rm_battle or
						instance_exists(obj_titleMenu) or
						obj_console.state = 1)

//Abrir menu dentro do jogo
if keyEsc and room != rm_battle 
	{
	if !instance_exists(obj_titleMenu) and global.isScreenEmpty = 1{
		instance_create_depth(0,0,depth,obj_titleMenu)
		}
	else{
		instance_destroy(obj_titleMenu)
		
		}
	}
	

	
//Abrir inventário

//Menu
	if keyC and room != rm_battle{
		if global.isScreenEmpty and global.isMenuOpen = 0{
			//Reseta as seleções
			windowDetails.option = -1
			inventorySelectedItem = 0
			
			global.isScreenEmpty = 0
			global.isMenuOpen = 1
			}
        //Fechar o menu
		else{
			global.isMenuOpen = 0
			}
		}
	
//Musica
audio_sound_gain(global.music,global.volumeMusic*global.volumeGlobal/100)