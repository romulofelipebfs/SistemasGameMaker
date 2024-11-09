/// @description Insert description here
// You can write your code in this editor

larg = 30;
alt = 10;
margem = 10; 


dialogo_area = function(){
	var _y = bbox_bottom + margem;
	
	var _player =  collision_rectangle(x - larg / 2, _y, x + larg / 2, _y + alt, obj_player, 0, 1)
	
	image_blend = c_white;
	if(_player){
		image_blend = c_red;
		if(keyboard_check_pressed(vk_space)){
			with(_player){
				estado = estado_dialogo;
			}
		}
		if(keyboard_check_pressed(vk_escape)){
			with(_player){
				estado = estado_parado ;
			}
		}
	}
}