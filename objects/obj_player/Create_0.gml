/// @description Insert description here
// You can write your code in this editor

event_inherited();

max_vel = 5;
meu_acel = .1;
acel = meu_acel;
sprite = sprite_index;
xscale = 1;

ataque = false;
defesa = false;
roll = false;

sprites_index = 0;

face = 0;

estado = noone;
estado_txt = "parado";

image_ind = 0;
image_spd = 8 / game_get_speed(gamespeed_fps);
image_numb  = 0;
debug = true;

sprites =	[
			[spr_player_idle_right, spr_player_idle_up, spr_player_idle_right, spr_player_idle_down],
			[spr_player_run_right, spr_player_run_up, spr_player_run_right, spr_player_run_down],
			[spr_player_attack_right, spr_player_attack_up, spr_player_attack_right, spr_player_attack_down],
			[spr_player_shield_right, spr_player_shield_up, spr_player_shield_right, spr_player_shield_down],
			[spr_player_roll_right, spr_player_roll_up, spr_player_roll_right, spr_player_roll_down]
			]


keyboard_set_map(ord("W"), vk_up);
keyboard_set_map(ord("S"), vk_down);
keyboard_set_map(ord("A"), vk_left);
keyboard_set_map(ord("D"), vk_right);
keyboard_set_map(ord("C"), ord("J"));
keyboard_set_map(ord("L"), ord("Z"));

controla_player = function(){
	var _up = keyboard_check(vk_up);
	var _down = keyboard_check(vk_down);
	var _left = keyboard_check(vk_left);
	var _right = keyboard_check(vk_right);
	ataque = keyboard_check_pressed(ord("J"))
	defesa = keyboard_check(ord("Z"))
	roll = keyboard_check_pressed(ord("K"))

	if(_right){ face = 0; xscale = 1;};
	if(_up) face = 1;
	if(_left) {face = 2; xscale = -1};
	if(_down) face = 3;
	
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
}

ajuste_sprite = function(_indice_array){
	
	if(sprite != sprites[_indice_array][face]){
		image_ind = 0;
	}
	
	sprite = sprites[_indice_array][face];
	image_numb = sprite_get_number(sprite);
	
	image_ind += image_spd;
	
	image_ind %= image_numb;
}


estado_parado = function(){
	controla_player();
	sprites_index = 0;
	estado_txt = "parado";
	velx = 0;
	vely = 0;
	
	ajuste_sprite(0);
	
	var _up = keyboard_check(vk_up);
	var _down = keyboard_check(vk_down);
	var _left = keyboard_check(vk_left);
	var _right = keyboard_check(vk_right);
	
	if((_up xor _down) or (_left xor _right)){
		estado = estado_movendo;
	}
	if(ataque){
		estado = estado_ataque;
	}
	if(defesa){
		estado = estado_defesa;
	}
	if(roll){
		estado = estado_esquiva;
	}
	
}



estado_movendo = function(){
	controla_player();
	estado_txt = "movendo";
	sprites_index = 1;
	
	ajuste_sprite(1);
	
	if(abs(velx) <= 0.2 && abs(vely) <= 0.2){
		estado = estado_parado;
	}
	
	if(ataque){
		estado = estado_ataque;
	}
	if(defesa){
		estado = estado_defesa;
	}
	if(roll){
		estado = estado_esquiva;
	}
}

estado_ataque = function(){
	
	velx = 0;
	vely = 0;
	
	sprites_index = 2;
	ajuste_sprite(2);
	estado_txt = "ataque";
	if(image_ind + image_spd >= image_numb){
		estado = estado_parado;
	}
	
}

estado_defesa = function(){
	estado_txt = "Defesa";
	controla_player();
	ajuste_sprite(3);
	if(!defesa){
		estado = estado_parado;	
	}
	velx = 0;
	vely = 0;
}

estado_esquiva = function(){
	estado_txt = "Esquiva";
	ajuste_sprite(4);
	
	if(image_ind + image_spd >= image_numb){
		estado = estado_parado;
	}
	
}

estado_dialogo = function(){
	velx = 0;
	vely = 0;
	estado_txt = "diálogo";
	ajuste_sprite(1);
	//face = 1;
	
}

estado = estado_parado;