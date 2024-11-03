/// @description Insert description here
// You can write your code in this editor

var _up = keyboard_check(vk_up);
var _down = keyboard_check(vk_down);
var _left = keyboard_check(vk_left);
var _right = keyboard_check(vk_right);

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

if((_up xor _down) or (_left xor _right)){
	var _dir = point_direction(0, 0, (_right - _left), (_down - _up));

	var _max_velx = lengthdir_x(max_vel, _dir);
	
	velx = lerp(velx, _max_velx, acel);
	var _max_vely = lengthdir_y(max_vel, _dir);
	vely = lerp(vely, _max_vely, acel);
	
	
}else{
	
	velx = lerp(velx, 0, acel);
	vely = lerp(vely, 0, acel);
}	