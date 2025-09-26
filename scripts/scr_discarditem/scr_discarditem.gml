// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_discarditem(){
//如果背包只剩下一种物品
global.g_msg_name = ds_grid_get(inventory,0,item_pos+item_scroll_a);
if(ds_grid_height(inventory)==1)
{
	for(var i = 0; i < inventory_w; i++)
	{
		ds_grid_set(inventory,i,0,0);
		empty = true;
	}
}
//如果背包有超过两种物品
else
{
	inventoryEND = min(ds_grid_height(inventory)-1,17);
	var c_row = item_pos + item_scroll_a + 1;
	var rowtrm = item_pos + item_scroll_a;
	for(var i = rowtrm;i<ds_grid_height(inventory)-1;i++)
	{
		ds_grid_set_grid_region(inventory,inventory,0,c_row,11,c_row,0,i)
		c_row += 1;
	}
	ds_grid_resize(inventory,inventory_w,ds_grid_height(inventory)-1);
	if(item_scroll_a > 0)
	{
		item_scroll_a--;
	}
	else if(item_pos > inventoryEND-1)
	{
		item_pos--;
	}
}
}