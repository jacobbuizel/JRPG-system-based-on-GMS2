// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function item_crystal(_rmp){
with(instance_create_layer(0,0,"Instances",obj_menu_useitem))
{
	u_rmp = _rmp;
	u_scr = function() { using_item_crystal(u_rmp); };
}
}

function using_item_crystal(_rmp){
var _chara = load_chara(pos_chara);
if(_chara.MP_C >= _chara.MP)
{
	create_msg_box("isfull");
}
else
{
	_rmp = max(0,min(_rmp,_chara.MP-_chara.MP_C));
	_chara.MP_C += _rmp;
	
	if ds_grid_get(inventory,1,item_pos+item_scroll_a)==1
	{
		menu_cloes = true;
	}
	scr_useitem();
	global.g_msg_name = _chara.c_name;
	global.g_msg_amount = _rmp;
	if(_chara.MP_C == _chara.MP)
	{
		create_msg_box("use_item_2_isfull");
	}
	else
	{
		create_msg_box("use_item_2");
	}
}
}