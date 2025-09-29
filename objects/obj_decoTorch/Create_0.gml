
depth = -9000

var _flickering = random_range(-0.05,0.05)

image_speed += _flickering

//Light
	if sprite_index=spr_decoTorch1{ 
		with obj_systemLighting{
			var _offset = [other.x+(10*other.image_xscale),other.y+6]
			lightAdd(lightsSub,other,false,0.6,1,c_white,[0,0],_offset)
			lightAdd(lightsAdd,other,false,.1,.4,c_red,[0.005,0.1+_flickering],_offset)
			lightAdd(lightsAdd,other,false,.3,.2,c_yellow,[0.0005,0.1+_flickering],_offset)
			
			}
		}
		
	else if sprite_index=spr_decoTorch2{ 
		depth = -y
		with obj_systemLighting{
			var _offset = [other.x+7,other.y+6]
			lightAdd(lightsSub,other,false,0.6,1,c_white,[0,0],_offset)
			lightAdd(lightsAdd,other,false,.1,.4,c_red,[0.005,0.1+_flickering],_offset)
			lightAdd(lightsAdd,other,false,.3,.2,c_yellow,[0.0005,0.1+_flickering],_offset)
			}
		}
		
	else{
		with obj_systemLighting{
			var _offset = [other.x+8,other.y+6]
			lightAdd(lightsSub,other,false,0.6,.4,c_white,[0,0],_offset)
			lightAdd(lightsAdd,other,false,.2,.15,c_red,[0.005,0.1+_flickering],_offset)
			lightAdd(lightsAdd,other,false,.3,.08,c_yellow,[0.0005,0.1+_flickering],_offset)
			}
		}