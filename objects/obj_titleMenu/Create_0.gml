//Som
if room = rm_title{
	global.volumeGlobal = 5
	global.volumeEffects = 5
	global.volumeMusic = 5
	}
	
//Telas
screen = 0

screenMiddle = [view_get_wport(view_current)/2,view_get_hport(view_current)/2]

//Botões
buttonLabels = [["Jogar","Opções","Sair"],["Voltar","Opções","Sair do Jogo"]]
buttonPos = [150,380]
if room = rm_title buttonSize = [120,32] else buttonSize = [180,32] 
buttonMargin = 8
buttonSelected = 0
buttonShift = [0,0,0,0]
buttonShiftSpeed = 2
if room = rm_title buttonAlpha = 1 else buttonAlpha = 0

//TItulo do jogo
title={x:10,y:64}

//Texto
textMarginRight = 8

//Sliders
sliderLabels = ["Volume Global","Volume de Efeitos","Volume da Música"]
sliderValues = [global.volumeGlobal,global.volumeEffects,global.volumeMusic]
sliderValuesMax = [10,10,10]
sliderHeight = 32
sliderSelected = 0
sliderAlpha = 0

//Generic
timer = 0

//Musica
if room = rm_title global.music = audio_play_sound(snd_musicTitle,0,0,global.volumeMusic*global.volumeGlobal/100)

//Quando um botão é pressionado
function pressOptionMenu(){
	if room = rm_title{
		switch(buttonSelected){
			case 0:
				screen = 2
				timer = 60
			break
		
			case 1:
				screen = 1
			break
		
			case 2:
				game_end(0)
			break
			}
		}
	else{
		switch(buttonSelected){
			case 0:
				screen = 3
				timer = 20
			break
		
			case 1:
				screen = 1
			break
		
			case 2:
				game_end(0)
			break
		}

	}
}
	
function buttonsRun(_buttonType = 0){
	
	if room != rm_title {
		_buttonType = 1
		}
	
	draw_set_alpha(buttonAlpha)
	//Desenha os botões do menu inicial
	var xx = buttonPos[0], yy = buttonPos[1]-buttonAlpha*10, heightShift = (buttonSize[1]/2)-(string_height("M")/2), shiftMax = 16
	
	for(var i = 0; i < array_length(buttonLabels[_buttonType]);i++){
		
		//Desenhar as opções
		if buttonSelected!=i{
			draw_text(xx+textMarginRight+buttonShift[i],yy+heightShift,buttonLabels[_buttonType][i])
			//draw_rectangle(xx,yy,xx+buttonSize[0]+round(buttonShift[i]),yy+buttonSize[1],true)
			
			//Diminui o shift
			buttonShift[i] = max(0,buttonShift[i]/1.5)
			}
		else{
			draw_rectangle(xx,yy,xx+buttonSize[0]+round(buttonShift[i]),yy+buttonSize[1],false)
			draw_set_color(c_black)
			draw_text(xx+textMarginRight+buttonShift[i],yy+heightShift,buttonLabels[_buttonType][i])
			draw_set_color(c_white)
			
			//Aumenta o shift
			buttonShift[i] = min(shiftMax,(buttonShift[i]+0.1)*2)
			}
			
		yy+=buttonSize[1]+buttonMargin
		}
	draw_set_alpha(1)
	}
	
function slidersRun(){

	draw_set_alpha(sliderAlpha)
	var xx = 40, yy = 300+(sliderAlpha*10), sliderBarMarginLeft = 200, sliderBarSize = [6,string_height("M")]
	
	for(var i = 0; i < array_length(sliderLabels);i++){
		
		if sliderSelected != i{
			//Título do slider
			draw_text(xx,yy,sliderLabels[i])
			}
		else{
			draw_set_color(c_yellow)
			draw_text(xx,yy,sliderLabels[i])
			draw_set_color(c_white)
			}
		
		//Barras
		var barXX = xx, sliderBarSpacing = 4
		
		for (var j = 1; j <= sliderValuesMax[i]; j++){
			
			if j > sliderValues[i] draw_set_color(c_dkgray)
			draw_rectangle(barXX+sliderBarMarginLeft,yy,barXX+sliderBarMarginLeft+sliderBarSize[0],yy+sliderBarSize[1],false)	
			barXX += sliderBarSpacing+sliderBarSize[0]
			}
		draw_set_color(c_white)
		yy += sliderHeight
		}
	draw_set_alpha(1)
	}