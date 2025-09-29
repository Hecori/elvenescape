function warp(_val,_floor,_ceil){
	if _val < _floor return _ceil 
	else if _val > _ceil return _floor
	return _val
}