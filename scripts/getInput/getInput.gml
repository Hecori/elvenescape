function getInput(){
	keyLeft = keyboard_check(vk_left) || keyboard_check(ord("A"))
    keyLeftPressed = keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))
	keyRight = keyboard_check(vk_right) || keyboard_check(ord("D"))
    keyRightPressed = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))
	keyUp = keyboard_check(vk_up) || keyboard_check(ord("W"))
    keyUpPressed = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))
	keyDown = keyboard_check(vk_down) || keyboard_check(ord("S"))
    keyDownPressed = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))
	
	keyR = keyboard_check_pressed(ord("R"))
	keyZ = keyboard_check_pressed(ord("Z"))
	keyH = keyboard_check_pressed(ord("H"))
	keyX = keyboard_check_pressed(ord("X"))
	keyC = keyboard_check_pressed(ord("C"))
	
	key1 = keyboard_check_pressed(ord("1"))
	key2 = keyboard_check(ord("2"))

	keyCtrl = keyboard_check_pressed(vk_control)
	keyEsc = keyboard_check_pressed(vk_escape)
	keyConsole = keyboard_check_pressed(vk_f1)
}