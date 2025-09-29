//Variáveis
pointsLoaded = true
state = 0
spd = 0.05

//Imagem de fundo
background={x:0,y:0,scale:2}

//Transição
with instance_create_depth(x,y,-9999,obj_fxRoomTransition){
	timeEnd = 120
	type = "fadeIn"
	}

finalScore = [0,0,0,0,0]
finalScoreAnimated = [0,0,0,0]

function sum(){
	var _sum = 0
	for(var i = 0; i < array_length(finalScore)-1;i++){
		_sum+=finalScore[i]
		}
	return _sum
	}
	
totalPointsWindow = {
	x:0, 
	y:0,
	alpha:0,
	scale:1,
	draw: function(_finalScore){
		var _text = string("Sua pontuação final: {0} Pontos",round(_finalScore))
		
		draw_set_font(fnt_points)
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		
		draw_text_transformed_color(x+string_width(_text)/2,y,_text,scale,scale,0,c_white,c_white,c_white,c_white,alpha)
		
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		},
	update: function(_x,_y){
		x = _x
		y = _y
		scale = 1+sin(current_time/1000)/100
		if alpha < 1 alpha += 0.05
		},
	}