draw_set_font(fnt_quickSand)
getInput()

//In game
if room != rm_title{
	if screen = 0 or screen = 3 draw_set_alpha(buttonAlpha/2)
	else draw_set_alpha(.5)
	
	draw_set_color(c_black)
	draw_rectangle(0,0,2000,3000,false)
	
	draw_set_alpha(1)
	draw_set_color(c_white)
	}

//Menu
buttonsRun()

//Opções
slidersRun()

//Fade in e fade out
if screen = 0 buttonAlpha = min((buttonAlpha+.05)*2,1)
else {
	if room = rm_title buttonAlpha = max(buttonAlpha/1.2,0.05-(screen==2)*0.05)
	else buttonAlpha = max(buttonAlpha/1.2,0)
	}

if screen = 1 sliderAlpha = min((sliderAlpha+.05)*2,1)
else sliderAlpha = max(sliderAlpha/1.5,0)

//Game name
	gpu_set_blendmode(bm_add)
	draw_sprite_ext(spr_gameTitle,0,title.x,title.y,1.2,1.2,0,c_white,buttonAlpha*0.9)
	gpu_set_blendmode(bm_normal)