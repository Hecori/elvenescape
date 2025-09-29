if os_type != os_windows{
	//Nenhum video carregado
	if videoIsLoaded = false{
		if file_exists("intro.webm"){
			video_open("intro.webm")
			video_set_volume(0)
			videoIsLoaded = true
			}
		}
	//Carregou o video
	else{
		surface = video_draw()
		gpu_set_blendmode(bm_add)
		if surface_exists(surface[1]) draw_surface_ext(surface[1],0,0,.6,.6,0,c_white,obj_titleMenu.buttonAlpha*0.5)
		gpu_set_blendmode(bm_normal)
		}
	}

else {
	draw_sprite_ext(spr_backgroundTitle,imageIndex,0,0,.6,.6,0,c_white,obj_titleMenu.buttonAlpha*0.5)
	
	imageIndex += coeficient
	
	//Looping
	if imageIndex >= imageMax-1 or imageIndex = 1 coeficient /= -1
	}