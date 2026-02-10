// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_discard_inventory(){
//如果背包只剩下一种物品
global.g_msg_name = ds_grid_get(inventory,DS_INVENTORY.NAME,item_pos+item_scroll_a);
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
		ds_grid_set_grid_region(inventory,inventory,DS_INVENTORY.NAME,c_row,inventory_w-1,c_row,0,i)
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

function scr_useitem(){
//如果背包只剩下一种物品
if(ds_grid_height(inventory)==1)
{
	if ds_grid_get(inventory,DS_INVENTORY.AMOUNT,item_pos+item_scroll_a)==1
	{
		for(var i = 0; i < inventory_w; i++)
		{
			ds_grid_set(inventory,i,0,0);
			empty = true;
		}
	}
	else
	{
		ds_grid_set(inventory,DS_INVENTORY.AMOUNT,item_pos+item_scroll_a,ds_grid_get(inventory,DS_INVENTORY.AMOUNT,item_pos+item_scroll_a)-1)
	}
}
//如果背包有超过两种物品
else
{
	if ds_grid_get(inventory,DS_INVENTORY.AMOUNT,item_pos+item_scroll_a)==1
	{
		inventoryEND = min(ds_grid_height(inventory)-1,17);
		var c_row = item_pos + item_scroll_a + 1;
		var rowtrm = item_pos + item_scroll_a;
		for(var i = rowtrm;i<ds_grid_height(inventory)-1;i++)
		{
			ds_grid_set_grid_region(inventory,inventory,DS_INVENTORY.NAME,c_row,inventory_w-1,c_row,0,i)
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
	else
	{
		ds_grid_set(inventory,DS_INVENTORY.AMOUNT,item_pos+item_scroll_a,ds_grid_get(inventory,DS_INVENTORY.AMOUNT,item_pos+item_scroll_a)-1)
	}
}
}

function scr_discard_equipment(){
//如果背包只剩下一种装备
global.g_msg_name = ds_grid_get(equipment,DS_EQUIPMENT.NAME,equip_pos+equip_scroll_a);
if(ds_grid_height(equipment)==1)
{
	for(var i = 0; i < equipment_w; i++)
	{
		ds_grid_set(equipment,i,0,0);
		equip_empty = true;
	}
}
//如果背包有超过两种装备
else
{
	equipmentEND = min(ds_grid_height(equipment)-1,17);
	var c_row = equip_pos + equip_scroll_a + 1;
	var rowtrm = equip_pos + equip_scroll_a;
	for(var i = rowtrm;i<ds_grid_height(equipment)-1;i++)
	{
		ds_grid_set_grid_region(equipment,equipment,DS_EQUIPMENT.NAME,c_row,equipment_w-1,c_row,0,i)
		c_row += 1;
	}
	ds_grid_resize(equipment,equipment_w,ds_grid_height(equipment)-1);
	if(equip_scroll_a > 0)
	{
		equip_scroll_a--;
	}
	else if(equip_pos > equipmentEND-1)
	{
		equip_pos--;
	}
}
}