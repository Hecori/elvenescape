function getSkill(_skillValue){
	switch(_skillValue){
		
			case "fireBlast":
				return new Skill(_skillValue,"Explosão de Chamas",2,"Conjuração: Lança uma labareda em chamas na direção do alvo e causa entre 5 e 10 de dano.","fire",5,10)
			
			case "heal":
				return new Skill(_skillValue,"Tratar Feridas",2,"Recupera uma quantidade de pontos de vida equivalentes ao seu nível atual vezes 3 no seu turno.") //Cura
			
			case "block":
				return new Skill(_skillValue,"Bloquear",1,"Recebe um bônus de Defesa igual a +1 pelos próximos turnos.") //Bloquear
			
			case "focus":
				return new Skill(_skillValue,"Foco de Batalha",1,"Recebe um bônus de dano no ataque igual ao seu nível menos 1.") //Bloquear
			
			case "rest":
				return new Skill(_skillValue,"Descanço",0,"Você passa seu turno realizando um rápido descanço, recuperando entre 0~1 pontos de Energia e 0~1 Vida.") //Bloquear
			
			}
	}

function getNewSkill(_skillValue){
	var _skill = ""
	
	//Aprender habilidade pelo nivel
	if typeof(_skillValue) = "number"{
		
		
		if _skillValue = 2{_skill = getSkill("focus"); _skill.add()} //Nível 2
		else if _skillValue = 4{_skill = getSkill("heal"); _skill.add()} //Nível 3
	
		if _skill != "" return string("Você aprendeu a habilidade: {0}",_skill.name)
		else return ""
	}
	else return getSkill(_skillValue)
	
}