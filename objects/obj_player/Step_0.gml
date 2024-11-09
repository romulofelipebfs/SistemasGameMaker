/// @description Insert description here
// You can write your code in this editor

if(mouse_check_button_pressed(mb_right)) debug = !debug;




show_debug_message(image_ind)
/*
velx = (_right - _left) * max_vel;
vely = (_down - _up) * max_vel;
*/




var _gelo = instance_place(x, y, obj_gelo);

if(_gelo){
	acel = _gelo.meu_acel;
}else{
	acel = meu_acel;
}




estado();



