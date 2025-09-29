//Variáveis
	effectList = []
	skillList = []

//Funções
	function particleCreate(_type,_x,_y,_dmg) constructor{
		type = _type
		dmg = _dmg
		x = _x
		y = _y
		
		alpha = 1
		
		if type = "damageEnemyComplex"{
			color = c_white
			hsp = -0.4
			vsp = -0.6
			friction = 0.004
			fadeOut = 0.01
			}
			
		else if type = "damagePlayer"{
			color = c_red
			hsp = 0.3
			vsp = -1
			friction = 0.01
			fadeOut = 0.01
			}
		
		function draw(){
			draw_set_font(fnt_gothic)
			
			//Dano
			draw_text_transformed_color(x,y,dmg.final,1,1,0,color,color,color,color,alpha)
			draw_text_transformed_color(x+20,y,string("{0} Físico",dmg.base),.4,.4,0,color,color,color,color,alpha)
			draw_text_transformed_color(x+20,y+16,string("Bloqueou {0} ",dmg.block),.4,.4,0,color,color,color,color,alpha)
				
			//Dano mágico se houver
			if dmg.magic.dmg > 0{
				var _element = elementInfo(dmg.magic.type)
				draw_set_halign(fa_center)
				draw_text_transformed_color(x+32,y+32,string("{0} {1}",_element.nome,dmg.magic.dmg),.4,.4,0,_element.color,_element.color,_element.color,_element.color,alpha)
				draw_set_halign(fa_left)
				}
			}
		
		function update(_id){
			x+=hsp
			y+=vsp
			
			hsp=hsp-sign(hsp)*friction
			vsp=vsp-sign(vsp)*friction
			
			
			if alpha <= 0 array_delete(obj_battleEffects.effectList,_id,1)
			else alpha -= fadeOut
			}			
		}
		
	function particleAdd(_type,_x,_y,_value = 0){
		var part = new particleCreate(_type,_x,_y,_value)
		array_push(effectList,part)
		}
		
	function attackCreate(_type,_x,_y) constructor{
		type = _type
		x = _x
		y = _y
		
		alpha = 1
		imageIndex= 0
		hscale = 1
		
		if _type = "slash"{
			sprite = spr_fxSlash
			animationTime = 5
			}
			
		else if _type = "slashFire"{
			sprite = spr_fxSlashFire
			animationTime = 5
			}	
		
		else if _type = "fireBlast"{
			sprite = spr_fxFireBlast
			animationTime = 5
			}	
		
		function draw(){
			draw_sprite_ext(sprite,imageIndex,x,y,3*hscale,3,0,c_white,alpha)
			}
			
		function update(_id = 0){
			
			if imageIndex >= sprite_get_number(sprite)-1{
				array_delete(obj_battleEffects.effectList,_id,1)
				}
			else{imageIndex = animation_animate(sprite,imageIndex,false)}
		}
		
	}
	
	function attackAdd(_type,_x,_y){
		var fxAtk = new attackCreate(_type,_x,_y)
		array_push(effectList,fxAtk)
		
		return fxAtk.animationTime
	}
		
	function skillCreate(_type, _x, _y, _time, _skillPlayer) constructor{
		type = _type
		x = _x
		y = _y

		shift = 0
		time = _time
		skillPlayer = _skillPlayer
		imageIndex = 0
		
		//Definir o sprite
		if type = "heal" imageIndex = 2
		else if type = "focus" imageIndex = 0
		else if type = "block" imageIndex = 1
		else if type = "rest" imageIndex = 3
		
		function draw(_i){
			var _spacing = 18, _x = x+_spacing*_i, _y = y+sin(shift/10)*2, _fontSize = 0.9
			
			//Remover
			if skillPlayer[0] = 0 and skillPlayer[1] = 0 array_delete(obj_battleEffects.skillList,_i,1)
			
			draw_set_font(fnt_debugInGame)
			
			//Desenhar
			draw_sprite_ext(spr_skillIcons,imageIndex,_x,_y,1,1,0,c_white,1)
				
			//Turnos
			draw_text_transformed(_x+12,_y-8,skillPlayer[0],_fontSize,_fontSize,0)
			
			//Efeito de floating
			shift += irandom(2)
			}
		}
		
	function skillAdd(_type, _x, _y, _time,_skillPlayer){
		var _skill = new skillCreate(_type, _x, _y, _time,_skillPlayer)
		
		//Ver se já existe um ícone de skill, se ja apagar o antigo
		for(var i = 0; i < array_length(skillList); i++){
			if skillList[i].type = _type array_delete(skillList,i,1)
			}
		array_push(skillList,_skill)
		}