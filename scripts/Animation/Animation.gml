function animation_get_time(_sprite){
	return sprite_get_speed(_sprite)
}

function animation_get_step(_sprite){
	return sprite_get_speed(_sprite)/game_get_speed(gamespeed_fps)
}

function animation_animate(_sprite,_imageIndex,_repeat = true){
	if _repeat = true{
		
		_imageIndex = warp(_imageIndex+animation_get_step(_sprite),0,sprite_get_number(_sprite))}
	
	else{
		_imageIndex+=animation_get_step(_sprite)
		if _imageIndex > sprite_get_number(_sprite)-1 _imageIndex = sprite_get_number(_sprite)-1
		}
		
		return _imageIndex
	
}