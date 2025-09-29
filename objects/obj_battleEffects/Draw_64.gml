draw_set_font(fnt_sourceSans)

//Desenha os efeitos básicos
for (var i = 0; i<array_length(effectList);i++){
	var effect = effectList[i]
	effect.draw()
	effect.update(i)
	}
	
//Desenha os simbolos de skills
for (var i = 0; i<array_length(skillList);i++){
	var _skill = skillList[i]
	 _skill.draw(i)
}