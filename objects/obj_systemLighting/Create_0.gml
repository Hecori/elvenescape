surface1 = -1
depth=-1000
timer = 0

lightsSub = []
lightsAdd = []

function lightAdd(_array,_object,_follow,_alpha,_size,_color,_flicker,_raw=false){
	
    var light = {
		raw : _raw,
        object: _object,
        x: _object.x,
        y: _object.y,
		follow: _follow,
		alpha: _alpha,
		size: _size,
		color: _color,
		flicker: _flicker, //How much to flicker and the speed
		updatePosition: function(){
			x = (object.x - sprite_get_xoffset(object.sprite_index) + sprite_get_width(object.sprite_index)/2)
			y = (object.y - sprite_get_yoffset(object.sprite_index) + sprite_get_height(object.sprite_index)/2)
			
		}
    }
	
	//Adquirir valor absoluto de posição
	if light.raw != false{
		light.x = light.raw[0]
		light.y = light.raw[1]
		}
		
    array_push(_array,light)
}

//Renderizar cada luz
function lightRender(_array){
    for(var i = 0; i < array_length(_array);i++){
		with _array[i]{
	        draw_sprite_ext(spr_light,0,x,y,size,size,0,color,alpha)
			if follow updatePosition()
			size += sin(other.timer*flicker[1])*flicker[0]
			
		}
    }
}

//Luzes do player
lightAdd(lightsSub,obj_player,true,.8,1.3,c_white,[0,0])
lightAdd(lightsAdd,obj_player,true,.3,1,c_orange,[0.01,0.2])