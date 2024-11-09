/// @description Insert description here
// You can write your code in this editor

if(mouse_check_button_released(mb_right)) debug = !debug;

var _mouse_sobre = position_meeting(mouse_x, mouse_y, id);
var _click = keyboard_check_pressed(ord("K"));

if(_mouse_sobre && _click){
	estado = "ataque";
}

controla_sprite();
controla_estado();
