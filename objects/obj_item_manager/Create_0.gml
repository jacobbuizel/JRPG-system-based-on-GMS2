//创建物品栏
globalvar inventory, inventory_w, empty, item_pos, item_scroll_a, inventoryEND;
inventory_w = 3;
inventory = ds_grid_create(inventory_w,1);

//创建装备栏
globalvar equipment, equipment_w, equip_empty, equip_pos, equip_scroll_a, equipmentEND;
equipment_w = 4;
equipment = ds_grid_create(equipment_w,1);

load = false;

global.item_w = 0.00;