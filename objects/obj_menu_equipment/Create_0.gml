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

//菜单动画
menu_anm = 800;
menu_cloes = false;

wait_time = 30;
equip_pos = 0;
equip_scroll_a = 0;
equipmentEND = min(ds_grid_height(equipment),10);

op_length = 2;
menu_level = 0;

if(ds_grid_get(equipment,0,0)==0)
{
	equipmentEND = 0;
	equip_empty = true;
}