/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

image_speed = 8 / game_get_speed(gamespeed_fps);

max_vel = 2;
debug = false;
tempo_estado = game_get_speed(gamespeed_fps) * 1;
tempo = tempo_estado;

tempo_persegue = game_get_speed(gamespeed_fps) * 2;
t_persegue = tempo_persegue;

tempo_ataque = game_get_speed(gamespeed_fps) * .5
t_ataque = tempo_ataque;

destino_x = 0;
destino_y = 0;
campo_visao = 200;
estado = "parado"
alvo = noone; 


controla_sprite = function(){
	var _dir = point_direction(0, 0, velx, vely);
	
	var _face = _dir div 90;
	
	switch(_face){
		case 0:
			sprite_index = spr_cogumelo_right;
			image_xscale = 1;
			break;
		case 1:	sprite_index = spr_cogumelo_up;break;
		case 2: sprite_index = spr_cogumelo_right; image_xscale = -1; break;
		case 3: sprite_index = spr_cogumelo_down;break;
	} 
	
}

olhando = function(){
	var _player = collision_circle(x, y, campo_visao, obj_player, false, true);
	if(_player && t_persegue <= 0){
		estado = "persegue";
		alvo = _player;
	}
}

controla_estado = function(){
	switch(estado){
		case "parado":
			
			if(t_persegue > 0){
				t_persegue--;
			}
			
			image_blend = c_white;
			tempo--;
			velx = 0;
			vely = 0;
			
			if(tempo <= 0){
				estado = choose("parado", "andando");
				tempo = tempo_estado;
				
			}
			olhando();
		break;
		case "andando":
		
			if(t_persegue > 0){
					t_persegue--;
			}
			tempo--;
			
			var _dist = point_distance(x, y, destino_x, destino_y);
			
			
			if(destino_x == 0 or destino_y == 0 or _dist < max_vel * 2){
				destino_x = random_range(0, room_width);
				destino_y = random_range(0, room_height);
			}
			
			var _dir = point_direction(x, y, destino_x, destino_y);
			
			velx = lengthdir_x(max_vel, _dir);
			vely = lengthdir_y(max_vel, _dir);
			
			if(tempo <= 0){
				estado = choose("parado", "andando", "andando");
				tempo = tempo_estado;
	
			}	
			olhando();
		break;
		case "persegue":
			//alvo = obj_player;
			
			image_blend = c_orange;
			
			if(alvo){
				destino_x = alvo.x;
				destino_y = alvo.y;
			}else{
				estado = choose("parado", "parado", "andando");
				destino_x = 0;
				destino_y = 0;
				tempo = tempo_estado;
			}
			
			var _dir = point_direction(x, y, destino_x, destino_y);
			velx = lengthdir_x(max_vel, _dir);
			vely = lengthdir_y(max_vel, _dir);
			
			var _dist =  point_distance(x, y, destino_x, destino_y);
			
			if(_dist > campo_visao + campo_visao / 2){
				alvo = noone;
				tempo = tempo_estado;
				destino_x = 0;
				destino_y = 0;
				
			}
			if(_dist < 100){
				estado = "carrega_ataque";
				tempo = tempo_estado;
				
			}
			
		break;
		
		case "carrega_ataque":
			
			t_ataque--;
			
			velx = 0;
			vely = 0;
			
			if(t_ataque <= 0){
				estado = "ataque";
				t_ataque = tempo_ataque;
			}
			
			
		break;
		
		case "ataque":
			image_blend = c_red;
			t_persegue = tempo_persegue;
			var _dir = point_direction(x, y, destino_x, destino_y);
			velx = lengthdir_x(max_vel * 3, _dir);
			vely = lengthdir_y(max_vel * 3, _dir);
			var _dist =  point_distance(x, y, destino_x, destino_y);
			if(place_meeting(x + velx, y + vely, obj_chao)){
				estado = "parado";
				tempo = tempo_estado;
				destino_x = 0;
				destino_y = 0;
			}
			if(_dist < 16){
				estado = "parado";
			}
		
	}
}


