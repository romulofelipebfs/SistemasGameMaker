/// @description Insert description here
// You can write your code in this editor

event_inherited();

max_vel = 5;
meu_acel = .1;
acel = meu_acel;
sprite = sprite_index;
xscale = 1;

face = 0;

estado = noone;
estado_txt = "parado";

debug = true;


keyboard_set_map(ord("W"), vk_up);
keyboard_set_map(ord("S"), vk_down);
keyboard_set_map(ord("A"), vk_left);
keyboard_set_map(ord("D"), vk_right);


estado_parado = function(){
	
	estado_txt = "parado";
	velx = 0;
	vely = 0;
	
	var _up = keyboard_check(vk_up);
	var _down = keyboard_check(vk_down);
	var _left = keyboard_check(vk_left);
	var _right = keyboard_check(vk_right);
	
	if((_up xor _down) or (_left xor _right)){
		estado = estado_movendo;
	}
	
}

estado_movendo = function(){
	estado_txt = "movendo";
	
	switch(face){
		case 0: sprite = spr_player_idle_right; xscale = 1; break;
		case 1: sprite = spr_player_idle_up; break;
		case 2: sprite = spr_player_idle_right; xscale = -1; break;
		case 3: sprite = spr_player_idle_down;  break;
		
	}
	
	if(abs(velx) <= 0.2 && abs(vely) <= 0.2){
		estado = estado_parado;
	}
}

estado = estado_parado;