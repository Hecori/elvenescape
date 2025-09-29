if state = 1{
	
	//Fonte	
	draw_set_font(fnt_debugInGame)
	
	//Fundo
	draw_set_color(c_black)
	draw_set_alpha(.6)
	draw_rectangle(0,0,view_get_wport(view_current),view_get_hport(view_current),false)
	draw_set_color(c_white)
	draw_set_alpha(1)
	
	//Borda
	draw_rectangle(windowMain.x,windowMain.y,windowMain.x+windowMain.width,windowMain.y+windowMain.height,true)
	
	draw_rectangle(windowInput.x,windowInput.y,windowInput.x+windowInput.width,windowInput.y+windowInput.height,true)
	
	//Texto do log
	draw_text_ext(windowMain.x+windowMain.margin,windowMain.y+windowMain.margin,log,-1,700)
	
	//Texto do input
	draw_text(windowInput.x+windowMain.margin,windowInput.y+windowMain.margin,">>> "+windowInput.text)
	}