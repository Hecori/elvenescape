getInput()

//Menu inicial
if screen = 0{
	//Trocar de opção
	var _temp = buttonSelected
	buttonSelected = clamp(buttonSelected+(keyDownPressed-keyUpPressed),0,array_length(buttonLabels[screen])-1)
	
	//Limitar se for inGame
	if room != rm_title buttonSelected = min(2,buttonSelected)
	
	//Som
	if _temp != buttonSelected audio_play_sound(snd_optionHover,0,0,global.volumeEffects*global.volumeGlobal/100)
	
	//Enviar opção
	if keyZ {
		pressOptionMenu()
		audio_play_sound(snd_optionSelect,0,0,global.volumeEffects*global.volumeGlobal/100)
		}
	}

//Opções	
else if screen = 1{
	//Mudar de slider
	var oldValue = sliderSelected
	sliderSelected = clamp(sliderSelected+(keyDownPressed-keyUpPressed),0,array_length(sliderLabels)-1)
	if oldValue != sliderSelected audio_play_sound(snd_optionHover,0,0,global.volumeEffects*global.volumeGlobal/100)

	//Mudar valor do slider
	oldValue = sliderValues[sliderSelected]
	sliderValues[sliderSelected] = clamp(sliderValues[sliderSelected]+(keyRightPressed-keyLeftPressed),0,sliderValuesMax[sliderSelected])
	
	
	if oldValue != sliderValues[sliderSelected] {
		audio_play_sound(snd_optionHover,0,0,global.volumeEffects*global.volumeGlobal/100)
			
		//Mudar no global
		if sliderSelected = 0 global.volumeGlobal = sliderValues[0]
		else if sliderSelected = 1 global.volumeEffects = sliderValues[1]
		else if sliderSelected = 2 {
			global.volumeMusic = sliderValues[2]
		} 
		
		audio_sound_gain(global.music,global.volumeMusic*global.volumeGlobal/100)
	}
}	
	
//Iniciar um jogo
else if screen = 2{
	if timer > 0 timer--
	else{
		room_goto(rm_cellsA1)
		draw_set_alpha(1)
		audio_pause_sound(global.music)
		with instance_create_depth(x,x,-9999,obj_fxRoomTransition){
			type = "fadeIn"
			timeEnd = 30
			}
		global.showHelpAtStart = 1
		}
	}

//Fechar o menu
else if screen = 3{
	if timer > 0 timer--
	else{
		instance_destroy(self)
		draw_set_alpha(1)
		}
	}

if keyX screen = 0
else if keyR game_restart()

