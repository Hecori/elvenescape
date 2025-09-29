//Variaveis
timer++

//Re-cria a superficie se necesário
if !surface_exists(surface1){
    surface1 = surface_create(800,460)
}

//Setup
surface_set_target(surface1)
draw_clear(c_black)

//Sombras de subtração
gpu_set_blendmode(bm_subtract)
lightRender(lightsSub)
gpu_set_blendmode(bm_normal)

//Contornos da superfície
if global.modeDebug = true{
    draw_text_color(x,y,surface_get_target(),c_white,c_white,c_white,c_white,1)
    draw_set_color(c_green)
    draw_rectangle(1,1,surface_get_width(surface1)-2,surface_get_height(surface1)-2,true)
    draw_set_color(c_white)
}

//Desenha a surface final
surface_reset_target()
draw_surface(surface1,0,0)

//Luzes de adição
gpu_set_blendmode(bm_add)
lightRender(lightsAdd)
gpu_set_blendmode(bm_normal)
