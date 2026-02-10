// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function item_potion(_num,_dice,_add){
with(instance_create_layer(0,0,"Instances",obj_menu_useitem))
{
	u_num = _num;
	u_dice = _dice;
	u_add = _add;
	u_scr = function() { using_item_potion(u_num, u_dice, u_add); };
}
}

function using_item_potion(_num,_dice,_add){
var _chara = load_chara(pos_chara);
if(_chara.HP_C>=_chara.HP)
{
	create_msg_box("isfull");
}
else
{
	var _rhp = dice(_num,_dice)+_add;
	_rhp = max(0,min(_rhp,_chara.HP-_chara.HP_C));
	_chara.HP_C+=_rhp;
	
	if ds_grid_get(inventory,DS_INVENTORY.AMOUNT,item_pos+item_scroll_a)==1
	{
		menu_cloes = true;
	}
	scr_useitem();
	global.g_msg_name = _chara.c_name;
	global.g_msg_amount = _rhp;
	if(_chara.HP_C==_chara.HP)
	{
		create_msg_box("use_item_1_isfull");
	}
	else
	{
		create_msg_box("use_item_1");
	}
}
}