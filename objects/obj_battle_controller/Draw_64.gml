draw_set_font(font0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);
draw_rectangle(0,0,1600,900,false);

if !battle_current_exists()
{
	draw_set_color(c_white);
	draw_text(32,32,"battle_ctx missing");
	exit;
}

var _state = global.battle_state;
var _row_count = _state.height;
var _col_count = _state.width;

draw_set_alpha(1);
draw_set_color(c_lime);

for (var _row = 0; _row <= _row_count; _row++)
{
	var _row_rate = _row / _row_count;
	var _row_y = lerp(grid_top_y,grid_bottom_y,_row_rate);
	var _row_left = lerp(grid_top_left,grid_bottom_left,_row_rate);
	var _row_right = lerp(grid_top_right,grid_bottom_right,_row_rate);
	draw_line_width(_row_left,_row_y,_row_right,_row_y,2);
}

for (var _col = 0; _col <= _col_count; _col++)
{
	var _col_rate = _col / _col_count;
	var _top_x = lerp(grid_top_left,grid_top_right,_col_rate);
	var _bottom_x = lerp(grid_bottom_left,grid_bottom_right,_col_rate);
	draw_line_width(_top_x,grid_top_y,_bottom_x,grid_bottom_y,2);
}

for (var _obj_i = 0; _obj_i < array_length(_state.objects); _obj_i++)
{
	var _obj = _state.objects[_obj_i];
	if _obj.removed continue;
	
	var _obj_rate_y = (_obj.grid_y + 0.5) / _row_count;
	var _obj_row_left = lerp(grid_top_left,grid_bottom_left,_obj_rate_y);
	var _obj_row_right = lerp(grid_top_right,grid_bottom_right,_obj_rate_y);
	var _obj_screen_x = lerp(_obj_row_left,_obj_row_right,(_obj.grid_x + 0.5) / _col_count);
	var _obj_screen_y = lerp(grid_top_y,grid_bottom_y,_obj_rate_y);
	
	draw_set_color(c_gray);
	draw_rectangle(_obj_screen_x - 28,_obj_screen_y - 28,_obj_screen_x + 28,_obj_screen_y + 28,false);
}

for (var _unit_i = 0; _unit_i < array_length(_state.units); _unit_i++)
{
	var _unit = _state.units[_unit_i];
	if _unit.removed continue;
	
	var _unit_rate_y = (_unit.grid_y + (_unit.size * 0.5)) / _row_count;
	var _unit_row_left = lerp(grid_top_left,grid_bottom_left,_unit_rate_y);
	var _unit_row_right = lerp(grid_top_right,grid_bottom_right,_unit_rate_y);
	var _unit_screen_x = lerp(_unit_row_left,_unit_row_right,(_unit.grid_x + (_unit.size * 0.5)) / _col_count);
	var _unit_screen_y = lerp(grid_top_y,grid_bottom_y,_unit_rate_y);
	var _unit_scale = 0.35 + _unit_rate_y * 0.25;
	
	draw_set_color(c_white);
	draw_sprite_ext(_unit.spr,0,_unit_screen_x,_unit_screen_y,_unit_scale,_unit_scale,0,c_white,1);
	draw_text_transformed(_unit_screen_x - 40,_unit_screen_y + 42,_unit.c_name + " " + string(_unit.HP_C) + "/" + string(_unit.HP),0.5,0.5,0);
}

draw_set_color(c_navy);
draw_rectangle(log_x,log_y,log_x + log_w,log_y + log_h,false);
draw_set_color(c_blue);
draw_rectangle(log_x,log_y,log_x + log_w,log_y + log_h,true);

draw_set_color(c_white);
var _log_draw_y = log_y + 32;
for (var _log_i = max(0,array_length(_state.log) - 6); _log_i < array_length(_state.log); _log_i++)
{
	draw_text(log_x + 48,_log_draw_y,_state.log[_log_i]);
	_log_draw_y += 36;
}
