/// @description Insert description here
// You can write your code in this editor

if(place_meeting(x + velx, y, obj_chao)){
	
	var _chao = instance_place(x + velx, y, obj_chao);
	
	if(_chao){
		if(velx > 0){
			x = _chao.bbox_left - sprite_width / 2;
		}else{
			x = _chao.bbox_right + sprite_width / 2;
		}
	}
	velx = 0;
	
}

x += velx;

var _chao = instance_place(x, y + vely, obj_chao);

if(_chao){
	
	if(vely > 0){
		y = _chao.bbox_top;
	}else{
		y = _chao.bbox_bottom + sprite_height; 
	}
	
	vely = 0;
}

y += vely;

/*
if(place_meeting(x, y + vely, obj_chao)){
	var _vely = sign(vely);
	
	while(!place_meeting(x, y + _vely, obj_chao)){
		y += _vely;
	}
	vely = 0;
	
}
*/



