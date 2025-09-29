//Mostrar caixa de Texto
	if global.isTextBoxOpen = 1{
        draw_set_font(fnt_openSans)
        
		//Desenhar Fundo da caixa
		draw_set_alpha(.7)
        draw_set_color(c_black)
		draw_rectangle(boxX1,boxY1,boxX2,boxY2,false)
        
        //Desenhar o fundo da label
		var labelSize = [string_width(label),string_height(label)]
        if label!="" draw_rectangle(boxX1,boxY1-boxMargin,boxX1+labelSize[0]+textPadding*2,boxY1-labelSize[1]-boxMargin*2,false)
		
		//Desenhar outline da caixa
		draw_set_alpha(1)
		draw_set_color(c_white)
		draw_rectangle(boxX1,boxY1,boxX2,boxY2,true)
		
        //Desenhar outline da label
        if label!="" draw_rectangle(boxX1,boxY1-boxMargin,boxX1+labelSize[0]+textPadding*2,boxY1-labelSize[1]-boxMargin*2,true)
        
		//Mostrar label
        draw_text(boxX1+textPadding,boxY1-textPadding*2.8,label)
        
		//Mostrar texto
		draw_text_ext(boxX1+textPadding,boxY1+textPadding,lineText,-1,cameraSize[0]-boxMargin-textPadding*3)
		
		//TypeWritter Effect 
		if lineTextPos < string_length(text[lineCurrent]){
			
			//Pula o texto
			if keyboard_check_pressed(ord("X")) and lineTextPos > 0{
				lineTextPos = string_length(text[lineCurrent])
				}
				
			//Avança o texto
			else{
				if array_length(textSpeeds) > 1 lineTextPos+=textSpeeds[lineCurrent]*.5
				else lineTextPos+=textSpeeds[0]*1
				}
			
			lineText = string_copy(text[lineCurrent],0,ceil(lineTextPos))
			}
			
		else{
			
			
			//Mudar para o próximo diálogo
			if keyboard_check_pressed(ord("Z")) or autoClose = 0 {
				resetCurrentLine()
				lineCurrent++
			
				//Após acabar todo o texto e tentar mostrar um a mais
				if lineCurrent >= array_length(text){
					autoClose = -1
					global.isTextBoxOpen = 0
					dialogueHasEnded = true
					clearCurrentText()
					}
				}
				
			//Timer até o texto fechar sozinho	
			else if autoClose > 0 and lineCurrent = array_length(text)-1 autoClose --
			}
		}