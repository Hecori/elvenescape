
/// @desc Retorna um array contendo [Nome do elemento traduzido, tipo de dano, cor do elemento em RGB]
/// @param {String} Elemento Nome do elemento em inglês
function elementInfo(_name){
	switch(_name){
		case "fire":
			return {nome:"Fogo",dano:"flamejante",color:make_color_rgb(255,120,0),color2:false}
		case "ice":
			return {nome:"Gelo",dano:"congelante",color:make_color_rgb(0,200,255),color2:false}
		case "dark":
			return {nome:"Sombras",dano:"sombrio",color:make_color_rgb(120,0,255),color2:false}
		case "electric":
			return {nome:"Energia",dano:"elétrico",color:make_color_rgb(230,255,0),color2:false}
		case "vampiric":
			return {nome:"Vampíro",dano:"vampírico",color:c_black,color2:c_red}
		}
}