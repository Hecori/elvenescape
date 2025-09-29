function Dialogue(_text = ["noText"], _textSpeeds = [1], _label = "", _next = "none") constructor {
    if !is_array(_text) _text = [_text] 
    if !is_array(_textSpeeds) _textSpeeds = [_textSpeeds]
 
    text = _text
    textSpeeds = _textSpeeds
    label = _label
	next = _next
	
	//Adiciona o dialogo a algum container
	function add(_container,_key){
		ds_map_add(_container,_key,self)
		}

}