depth = -1001;
global.pause = true;
global.sub_menu = 1;
empty = false;

width = 1200;
height = 672;

op_border = 32;
op_space = 32;
sort = 0;

menu_anm = 800;
menu_cloes = false;

wait_time = 30;
item_pos = 0;
item_scroll_a = 0;
inventoryEND = min(ds_grid_height(inventory),17);

op_option[0] = "使用";
op_option[1] = "丢弃";
pos = 0;
op_length = array_length(op_option);

discard_cursor = 2;
discard_amount = 1;

if(ds_grid_get(inventory,0,0)==0)
{
	inventoryEND = 0;
	empty = true;
}