event_inherited()

state = 0

//Visual
	depth = -y-sprite_get_height(sprite_index)+sprite_get_yoffset(sprite_index)
	tipShift = 0 //Shift no simbolo de E

//Interação
    interationPosition = []
	interactionRange = [sprite_get_width(sprite_index)/2,sprite_get_height(sprite_index)/2]
	
//Diálogo
	label = "interactible object"
	dialogues = ds_map_create()
	
	new Dialogue(["OBJETO INTERAGÍVEL","APENAS ISSO"],[1,1],label,"obj_interactible2").add(dialogues,"obj_interactible1")
	new Dialogue(["Diálogo diferente do anterior"],1,label,"obj_interactible1").add(dialogues,"obj_interactible2")

	dialoguesCurrent = ds_map_find_value(dialogues,"obj_interactible1")
	
//Flags
	showKeyTip = true

// 1- Interagiu 0- No alcance mas não interagiu -1- Nem está no alcance
function getInteraction(argument0 = keyZ){
	if point_in_rectangle(obj_player.interactionSpot[0],obj_player.interactionSpot[1],interationPosition[0]-interactionRange[0]-1,interationPosition[1]-interactionRange[1]-1,interationPosition[0]+interactionRange[0]-1,interationPosition[1]+interactionRange[1])
		if argument0 and global.isScreenEmpty return 1
		else return 0
	else return -1
	}

function updateInteractionPosition(){
    	interationPosition = [x+sprite_get_width(sprite_index)/2-sprite_get_xoffset(sprite_index),
                            y+sprite_get_height(sprite_index)/2-sprite_get_yoffset(sprite_index)]
}
updateInteractionPosition()

function depthSet(argument0){
	depth = -y-argument0
	}