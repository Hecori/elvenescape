getInput()
//Direções
	
	//Apenas se move se não houver nada na tela
	if global.isScreenEmpty{
		move_dir = [keyRight-keyLeft,keyDown-keyUp] 
		} 
	else move_dir = [0,0]
	
	isTryingToMove = abs(move_dir[0]) || abs(move_dir[1]) //Testa se o jogador está tentando se mover
	
	//Facing
	if isTryingToMove == 1 array_copy(facingDirection,0,move_dir,0,2)
	
	
//Definir Velocidade
	hsp = clamp(hsp+move_dir[0]*spdAcc,-maxSpd,maxSpd)
	vsp = clamp(vsp+move_dir[1]*spdAcc,-maxSpd,maxSpd)
		
	//Diagonal
	if hsp != 0 && vsp != 0{
		hsp = clamp(hsp,-sqrt(maxSpd/2),sqrt(maxSpd/2))
		vsp = clamp(vsp,-sqrt(maxSpd/2),sqrt(maxSpd/2))
		}
		
//Colisão
	var _hsp = hsp, _vsp = vsp, _oldPos = [x,y], _maxTries = 20
	
    //Colisão horizontal
	var listCollisions = ds_list_create()
    instance_place_list(x+hsp,y,obj_collider,listCollisions,false)

    for (var i = 0; i < ds_list_size(listCollisions);i++){
        var inst = ds_list_find_value(listCollisions,i)
		
        if inst.collisionIsEnabled{
			while !place_meeting(x+sign(hsp),y,inst) {
				x+=sign(hsp)*spdAcc
				_maxTries -= 1
				if _maxTries = 0 {x = _oldPos[0];break}
				}
				
			hsp = 0
            break
			}
    }    

    //Colisão vertical
    ds_list_clear(listCollisions)
	instance_place_list(x,y+vsp,obj_collider,listCollisions,false)
	_maxTries = 20
	
	for (var i = 0; i < ds_list_size(listCollisions);i++){
        var inst = ds_list_find_value(listCollisions,i)
        if inst.collisionIsEnabled{
			while !place_meeting(x,y+sign(vsp),inst){
				y+=sign(vsp)*spdAcc
				_maxTries -= 1
				if _maxTries = 0 {y = _oldPos[1];break}
				}
			vsp = 0
            break
			}
		}
    
    ds_list_destroy(listCollisions)
		
//Aplicar Velocidade Final
	x += hsp
	y += vsp

	//Fricção
	hsp = (hsp - (sign(hsp)*spdAcc) * (move_dir[0]=0)) * (abs(hsp)>=spdAcc)
	vsp = (vsp - (sign(vsp)*spdAcc) * (move_dir[1]=0)) * (abs(vsp)>=spdAcc)
	
	
//Vida e Energia
	hp = min(hp,hpMax)
	sp = min(sp,spMax)
	
//Interações
	interactionSpot = [x + (facingDirection[0]*interactionRange)-1,y + (facingDirection[1]*interactionRange)-4]

//Botão de ajuda
	getHelp()