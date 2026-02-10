depth = -1001;
global.pause = true;
global.sub_menu = 1;
equip_empty = false;

//高和宽
width = 1200;
height = 672;

//上边框和字符上下间距
op_border = 32;
op_space = 32;

//排序方式
sort = 0;

//长按切换按键
pos = 0;

//装备部位选框
e_pos_row = 0;
e_pos_col = 0;

//菜单动画
menu_anm = 800;
menu_cloes = false;

wait_time = 30;
equip_pos = 0;
equip_scroll_a = 0;
equipmentEND = min(ds_grid_height(equipment),10);

//角色总数
op_length = global.totalchara;

menu_level = 0;

//装备互动
op_option_eq = [
	MENU_EQUIPMENT_INTERFACE.EQUIP,
	MENU_EQUIPMENT_INTERFACE.DISCARD
];
op_length_eq = array_length(op_option_eq);
pos_eq = 0;
op_option_slot_eq = [
	MENU_EQUIPMENT_SLOT.UNEQUIP,
	MENU_EQUIPMENT_SLOT.SWITCH,
	MENU_EQUIPMENT_SLOT.DISCARD
];
op_length_slot_eq = array_length(op_option_slot_eq);
pos_slot_eq = 0;

if(ds_grid_get(equipment,DS_EQUIPMENT.NAME,0)==0)
{
	equipmentEND = 0;
	equip_empty = true;
}