//Tamanhos
    screenWidth = view_get_wport(view_current)
    screenHeight = view_get_hport(view_current)
    
//Janelas
    var padding = 32
	fadeSpeed = 0.10
	windowDisplacement = [0,10]
	alphaMenu = 0
	menuVisualOnly = true
	
    windowMain = new Window("Main",screenWidth/2,screenHeight/2,screenWidth-padding,screenHeight-padding,true)
    
//Inventario
    windowInventory = new Window("Inventário",padding,padding,300,windowMain.height-padding*2,false,"inv")
    windowMain.add(windowInventory)
    inventorySelectedItem = 0

//Details
    windowDetails = new Window("Item",windowInventory.width+padding*2+4,padding,529,350,false,"details")
    windowMain.add(windowDetails)
	
//Status
    windowStatus = new Window("Status",windowInventory.width+padding*2+4,windowDetails.height+padding*2,windowDetails.width,162,false,"stat")
    windowMain.add(windowStatus)

//Variáveis globais
	global.isScreenEmpty = 1
	global.isMenuOpen = 0
	global.isTextBoxOpen = 0

//Criação de outros objetos UI
	if !instance_exists(obj_guiTextBox) instance_create_depth(x,y,depth,obj_guiTextBox)
	if !instance_exists(obj_camera) instance_create_depth(obj_player.x,obj_player.y-128,depth,obj_camera)
    if !instance_exists(obj_systemLighting) instance_create_depth(x,y,depth,obj_systemLighting)
	
//Musica
	global.music = audio_play_sound( snd_caveAmbient,0,1,global.volumeMusic*global.volumeGlobal/100)
