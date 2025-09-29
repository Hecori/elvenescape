//Fundo
draw_sprite_ext(spr_endScreen,0,background.x,background.y,background.scale,background.scale,0,c_white,0.8)

//Posições e Variáveis
var _x = 40, _y = 40, _padding = 20

//Texto de vitória
draw_set_font(fnt_quickSand)
draw_text(_x,_y,"VOCÊ CONSEGUIU ESCAPAR!"); _y += _padding*2

//Número de dias 
draw_set_font(fnt_sourceSans)
var _plural = ""
if global.days > 1 _plural = "s"

//Pontuação de dias
finalScore[0] = max(10-(global.days-1),0) 
draw_text(_x,_y,string("Você demorou {0} dia{1} para escapar:",global.days,_plural))
draw_text(_x+_padding*20,_y,string("+{0} Pontos",round(finalScoreAnimated[0])))
_y += _padding


//Nível
finalScore[1] = (global.score.level*2) //Pontuação do nível
draw_text(_x,_y,string("Nível Total: Lv. {0}",global.score.level)); 
draw_text(_x+_padding*20,_y,string("+{0} Pontos",round(finalScoreAnimated[1]))); 
_y += _padding

//Experiência
finalScore[2] = floor(global.score.xp/2) //Pontuação do nível
draw_text(_x,_y,string("Experiência Total: {0} XP",global.score.xp)); 
draw_text(_x+_padding*20,_y,string("+{0} Pontos",round(finalScoreAnimated[2]))); 
_y += _padding

//Vida
finalScore[3] = floor(global.score.hp/global.score.hpMax*10)
draw_text(_x,_y,string("Porcentagem de Vida restante: {0} %",global.score.hp/global.score.hpMax*100)); 
draw_text(_x+_padding*20,_y,string("+{0} Pontos",round(finalScoreAnimated[3]))); 
_y += _padding

//Pontuação Final
finalScore[4] = sum()

_y += _padding



//Mostrar pontuação final e tela de skip
if pointsLoaded{
	totalPointsWindow.draw(finalScore[4])
	totalPointsWindow.update(_x,_y)
	state = 1
	}