if load
{
	ds_grid_resize(inventory,inventory_w,global.saveDATA.Sinventory_h);
	ds_grid_read(inventory,global.saveDATA.Sinventory);
	
	ds_grid_resize(equipment,equipment_w,global.saveDATA.Sequipment_h);
	ds_grid_read(equipment,global.saveDATA.Sequipment);
	load = false;
}

//计算负重
global.item_w = 0.00;
for(var i=0;i<ds_grid_height(inventory);i++)
{
	var _inventory = load_inventory(i);
	global.item_w += _inventory.amount*_inventory.weight;
}
for(var i=0;i<ds_grid_height(equipment);i++)
{
	var _equipment = load_equipment(i);
	global.item_w += _equipment.amount*_equipment.weight;
}
if load_chara(global.player1).str*5+load_chara(global.player2).str*5 < global.item_w
{
	global.overweight = true;
}
else global.overweight = false;
