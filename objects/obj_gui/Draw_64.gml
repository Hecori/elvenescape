getInput()

//Variáveis do Draw
    draw_set_font(fnt_openSans)
    draw_set_color(c_white)

//Menu
	//Fundo escuro
	draw_set_alpha(alphaMenu*0.8)
    draw_set_color(c_black)
    draw_rectangle(0,0,screenWidth,screenHeight,false)
	
    draw_set_color(c_white)
	draw_set_alpha(alphaMenu)
	//Janela principal
	windowMain.draw()
		
	//Se o menu estiver aberto
	if global.isMenuOpen{
		menuVisualOnly = false
		alphaMenu = min(1,alphaMenu+fadeSpeed)
		windowDisplacement[0]=max(0,windowDisplacement[0]-2)
		}
		
	else{
		menuVisualOnly = true
		alphaMenu=max(0,alphaMenu-fadeSpeed)
		windowDisplacement[0]=min(windowDisplacement[1],windowDisplacement[0]+0.5)
		
		//Resetar o o item selecionado quando o menu estiver fechado
		if alphaMenu = 0 inventorySelectedItem = 0
		}

		
	draw_set_alpha(1)
	
//Informações de Debug	
	if global.modeDebug and room != rm_battle{
		draw_text(0,0,"Move Horizontal: "+string(obj_player.move_dir[0])+" | "+"Move Vertical: "+string(obj_player.move_dir[1]))
		draw_text(0,16,"x: "+string(obj_player.x)+" y: "+string(obj_player.y))
		draw_text(0,32,"Facing: "+string(obj_player.facingDirection))
		
		if array_length(obj_guiTextBox.text) > 0 draw_text(0,32+16,string(obj_guiTextBox.lineCurrent)+":"+string(obj_guiTextBox.text[obj_guiTextBox.lineCurrent]))
		else draw_text(0,32+16,"TextBox is empty")
		
		draw_text(0,64,"isMenuOpen: "+string(global.isMenuOpen))
		draw_text(0,64+16,"isTextBoxOpen: "+string(global.isTextBoxOpen))
		draw_text(0,64+32,"isScreenEmpty: "+string(global.isScreenEmpty))
		
		draw_text(0,128,string("HSP: {0} VSP: {1}",obj_player.hsp,obj_player.vsp))
		}