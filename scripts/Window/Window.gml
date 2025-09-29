function Window(_name, _x, _y, _width, _height, _center=false,_type = "none") constructor{
    name = _name
    x = _x
    y = _y
    width = _width
    height = _height
    center = _center
    parent = noone
    type = _type
    
    children = ds_list_create()
    
    if center{
        x = x-width/2
        y = y-height/2
    }
	
	if type = "details"{
		option = -1
		optionLabels = ["NOLABELS"]
		optionMax = 1
		}
    
    //Desenha as janelas
    function draw(){
		
        if type = "none"{
            draw_rectangle(x,y+obj_gui.windowDisplacement[0],x+width,y+height+obj_gui.windowDisplacement[0],true)
            for(var i = 0; i < ds_list_size(children);i++){ 
                ds_list_find_value(children,i).draw()
            }
        }
        else if type = "inv"{
            //Desenha o label e o outline da janela 
            draw_text(x+width/2-(string_width(name)/2),y-28+obj_gui.windowDisplacement[0],name)
            draw_rectangle(x,y+obj_gui.windowDisplacement[0],x+width,y+height+obj_gui.windowDisplacement[0],true)
            
            var slotHeight = 32, slotPadding  = 4
            var inv = obj_itemManager.inventory, invKeys = ds_map_keys_to_array(inv)
            var xx = x+slotPadding, yy = y + slotPadding +obj_gui.windowDisplacement[0]
            var invSize = obj_itemManager.inventorySize
			
			//Escolher o item
			if !obj_gui.menuVisualOnly{
				getInput()
				var invAmount = ds_map_size(obj_itemManager.inventory)
				obj_gui.inventorySelectedItem = clamp(obj_gui.inventorySelectedItem+(keyDownPressed-keyUpPressed),0,invAmount-1)
				}

            //Items
            for(var i = 0;i < invSize;i++){
                //Cada item
                if i < array_length(invKeys){
                    var item = ds_map_find_value(inv,invKeys[i]), text = string("{0} x{1}",item.name,item.amount)
                    var marginLeft = 8
                    
                    //Selecionar o item 
                    if obj_gui.inventorySelectedItem = i {
                        draw_set_color(c_yellow)
                        draw_text(xx+marginLeft*2,yy+(slotHeight/2)-(string_height(text)/2),text)
                        draw_set_color(c_white)
                    }
                    else{
                        draw_text(xx+marginLeft,yy+(slotHeight/2)-(string_height(text)/2),text)    
                    }
					
					//Equipado
					switch (invKeys[i]){
						case obj_itemManager.equipment.weapon:
						case obj_itemManager.equipment.armor:
							draw_set_color(c_lime)
							draw_text(xx+width-24,yy+6,"E")
							draw_set_color(c_white)
							break
						}
                }
                
                //Bordas
                draw_rectangle(xx,yy,xx+width-slotPadding*2,yy+slotHeight,true)
        
                yy+=slotHeight+slotPadding
            }
        }
		else if type = "details"{
			var xx = x, yy = y +obj_gui.windowDisplacement[0], padding = 16
			draw_set_color(c_white)
			//Desenha o label e o outline da janela 
            draw_text(x+width/2-(string_width(name)/2),y-28+obj_gui.windowDisplacement[0],name)
            draw_rectangle(x,y+obj_gui.windowDisplacement[0],x+width,y+height+obj_gui.windowDisplacement[0],true)
			
			//Se um item estiver selecionado
			if !ds_map_empty(obj_itemManager.inventory) and obj_gui.inventorySelectedItem > -1 and obj_gui.inventorySelectedItem <  array_length(ds_map_values_to_array(obj_itemManager.inventory)){
				
				//Padding
				xx+=padding
				yy+=padding
				
				var item = ds_map_values_to_array(obj_itemManager.inventory)[obj_gui.inventorySelectedItem]
				var textHeight = string_height("A")

				//Nome do item
				draw_text(xx,yy,string("{0} x{1}",item.name,item.amount))
				
				//Tipo do item
				draw_set_font(fnt_sourceSans)
				var itemType = "", extra = "-Sem informações adicionais"
				xx+=textHeight
				yy+=textHeight+4+obj_gui.windowDisplacement[0]
				
				switch(item.type){
					case "weapon": 
						itemType = "Arma"
						extra = string("Causa {0} - {1} de dano Físico. (Soma com a sua Força)",item.dmg.min,item.dmg.max)
						
						//Caso tenha propriedades especiais
						if item.dmgMagic.type!="none"{
							extra = string("{0}\nEssa é uma arma mágica que causa {1} a {2} de dano {3}.",extra,item.dmgMagic.min,item.dmgMagic.max,elementInfo(item.dmgMagic.type).dano)
							}
						break
						
					case "armor": 
						itemType = "Armadura"
						extra = string("Reduz entre {0} - {1} de dano sofrido.",item.def.min,item.def.max)
						break
						
					case "potionHealth": 
						itemType = "Poção Revitalizante"
						extra = string("Cura {0} de vida.",item.heal)
						break
						
					case "potionEnergy": 
						itemType = "Poção Energética"
						extra = string("Recupera {0} pontos de energia.",item.energy)
						break
						
					case "bag": 
						itemType = "Mochila"
						extra = string("Aumenta em +2 a quantidade de itens que você pode carregar.")
						break
						
					case "key": 
						itemType = "Chave"
						extra = "Misteriosamente ao ser largada, volta para os bolsos do personagem.\nIMPOSSÍVEL de ser largada, a menos que seja usada em uma porta"
						break
						
					case "skillItem": 
						itemType = "Item de Habilidade"
						extra = string("Um item que após ser lido fornece uma habilidade que pode ser utilizada em batalhas, a mesma parece ser associada ao título do item em si.")
						break
						
					}
					
				draw_text(xx,yy,"Tipo: "+itemType)
				
				//Descrição
				yy+=textHeight*2
				draw_text_ext(xx,yy,string("{0}\n\n{1}",item.description,extra),-1,width-42)
				draw_set_font(fnt_openSans)
				
				//Interação com o menu
				if !obj_gui.menuVisualOnly {
					getInput()
					actionGet()
					}
				
				var selectedItem = obj_itemManager.getItemByIndex(obj_gui.inventorySelectedItem)
				
				optionLabels = selectedItem.actions
				optionMax = array_length(optionLabels)
				//Ações
					var buttonWidth = 80, buttonHeight = 30, buttonSpacing = 24
					xx = x+buttonSpacing
					yy = y+height-buttonHeight-buttonSpacing+obj_gui.windowDisplacement[0]
					
					//Cada botão 
					for (var i = 0; i < optionMax; i++){
						
						if option = i {
							draw_set_color(c_yellow)
							
							//Border
							var expansion = 2
							draw_rectangle(xx-expansion,yy-expansion,xx+buttonWidth+expansion,yy+buttonHeight+expansion,true)
						
							//Label centralizada
							draw_text_centered(xx+buttonWidth/2,yy+buttonHeight/2,optionLabels[i])
							
							//Executar a ação selecionada com o item selecionado
							if keyZ and !obj_gui.menuVisualOnly {
								var _itemAction = optionLabels[i], _extraInfo = item_action(optionLabels[i])
								
								//Usar um item dentro da batalha
								if room = rm_battle {
									obj_battleSystem.currentAction[1] = "phase3"
									obj_battleSystem.currentAction[2] = [_itemAction,item.name,_extraInfo]
									}
								}
							}
						else{
							//Border
							draw_rectangle(xx,yy,xx+buttonWidth,yy+buttonHeight,true)
							
							//Label centralizada
							draw_text_centered(xx+buttonWidth/2,yy+buttonHeight/2,optionLabels[i])
							}
						
						//Reseta a cor
						draw_set_color(c_white)
						
						xx+=buttonWidth+buttonSpacing
						}

				}
        }
		  //Janela dos status
        else if type = "stat"{
			//Desenha o label e o outline da janela 
            draw_text(x+width/2-(string_width(name)/2),y-28+obj_gui.windowDisplacement[0],name)
            draw_rectangle(x,y+obj_gui.windowDisplacement[0],x+width,y+height+obj_gui.windowDisplacement[0],true)
			
			var padding = 16, xx = x+padding, yy = y+padding+obj_gui.windowDisplacement[0], lineHeight = string_height("W")
			
			//Vida e dias
			draw_text(xx,yy,string("Pontos de Vida: {0}/{1}",obj_player.hp,obj_player.hpMax))
			draw_text(xx+250,yy,string("Dia atual: {0}",global.days))
			yy+= lineHeight
			
			//Energia
			draw_text(xx,yy,string("Pontos de Energia: {0}/{1}",obj_player.sp,obj_player.spMax))
			yy+= lineHeight*2
			
			//Atributos
			draw_text(xx,yy,string("NÍVEL: {0}\nFORÇA {1}\nDEFESA: {2} ~ {3}",obj_player.level,obj_player.atribStr,obj_player.def.min,obj_player.def.max))
			
			//Dano e esquiva
			var dmgMin = obj_player.dmg.min+obj_player.atribStr, dmgMax = obj_player.dmg.max+obj_player.atribStr 
			draw_text(xx+140,yy,string("Pontos de Experiência: {0}\nDano mínimo~máximo : {1}~{2}\nPontos até o próximo nível: {3}",obj_player.xp[0],dmgMin,dmgMax,obj_player.xp[1]-obj_player.xp[0]))
			yy+= lineHeight
			
        }
    }
    
    //Adiciona sub janelas
    function add(_child){
        _child.x = x+_child.x
        _child.y = y+_child.y
        _child.parent = self
        
        ds_list_add(children,_child)
    }
	
	function actionGet(){
		option = clamp(option+(keyRightPressed-keyLeftPressed),0,optionMax-1)
		}
}
