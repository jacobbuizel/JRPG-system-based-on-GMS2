draw_set_font(font0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// 战斗场景底色。
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

// ------------------------------------------------------------
// 1. 计算每一条横线的屏幕 y 坐标
// ------------------------------------------------------------
// 注意：这里仍然保留“远端格子矮，近端格子高”的设计。
// 但是后面所有 x 方向的透视插值，都必须基于实际 y 坐标来算，
// 不能继续用 _row / _row_count，否则边缘会变弯。
var _row_ys = [];
var _grid_total_h = 0;

_row_ys[0] = grid_top_y;

for (var _rh = 0; _rh < _row_count; _rh++)
{
	var _height_rate = _rh / max(1, _row_count - 1);
	var _cell_h = lerp(grid_far_cell_h, grid_near_cell_h, _height_rate);

	_grid_total_h += _cell_h;
	_row_ys[_rh + 1] = grid_top_y + _grid_total_h;
}

var _grid_bottom_y = _row_ys[_row_count];
var _grid_total_screen_h = max(1, _grid_bottom_y - grid_top_y);

// ------------------------------------------------------------
// 2. 绘制棋盘横线
// ------------------------------------------------------------
draw_set_alpha(1);
draw_set_color(c_lime);

for (var _row = 0; _row <= _row_count; _row++)
{
	var _row_y = _row_ys[_row];

	// 关键修正：
	// 用真实屏幕 y 的比例计算梯形左右边界。
	var _row_rate = (_row_y - grid_top_y) / _grid_total_screen_h;

	var _row_left = lerp(grid_top_left, grid_bottom_left, _row_rate);
	var _row_right = lerp(grid_top_right, grid_bottom_right, _row_rate);

	draw_line_width(_row_left, _row_y, _row_right, _row_y, 2);
}


// ------------------------------------------------------------
// 3. 绘制棋盘竖线
// ------------------------------------------------------------
// 每个竖线分段绘制，但分段端点的 x 坐标必须由实际 y 坐标推导。
for (var _col = 0; _col <= _col_count; _col++)
{
	var _col_rate = _col / _col_count;

	for (var _seg_row = 0; _seg_row < _row_count; _seg_row++)
	{
		var _top_y = _row_ys[_seg_row];
		var _bottom_y = _row_ys[_seg_row + 1];

		var _top_rate = (_top_y - grid_top_y) / _grid_total_screen_h;
		var _bottom_rate = (_bottom_y - grid_top_y) / _grid_total_screen_h;

		var _top_left = lerp(grid_top_left, grid_bottom_left, _top_rate);
		var _top_right = lerp(grid_top_right, grid_bottom_right, _top_rate);

		var _bottom_left = lerp(grid_top_left, grid_bottom_left, _bottom_rate);
		var _bottom_right = lerp(grid_top_right, grid_bottom_right, _bottom_rate);

		var _top_x = lerp(_top_left, _top_right, _col_rate);
		var _bottom_x = lerp(_bottom_left, _bottom_right, _col_rate);

		draw_line_width(_top_x, _top_y, _bottom_x, _bottom_y, 2);
	}
}


// ------------------------------------------------------------
// 4. 战场物件占位绘制
// ------------------------------------------------------------
// 物件也要用同一套 y -> 梯形左右边界的算法，
// 否则会出现“格子是对的，但角色/物件飘偏”的问题。
for (var _obj_i = 0; _obj_i < array_length(_state.objects); _obj_i++)
{
	var _obj = _state.objects[_obj_i];
	if (_obj.removed) continue;

	var _obj_size = max(1, _obj.size);

	var _obj_start_row = clamp(floor(_obj.grid_y), 0, _row_count - 1);
	var _obj_end_row = clamp(floor(_obj.grid_y + _obj_size), _obj_start_row + 1, _row_count);

	var _obj_screen_y = (_row_ys[_obj_start_row] + _row_ys[_obj_end_row]) * 0.5;
	var _obj_y_rate = (_obj_screen_y - grid_top_y) / _grid_total_screen_h;

	var _obj_row_left = lerp(grid_top_left, grid_bottom_left, _obj_y_rate);
	var _obj_row_right = lerp(grid_top_right, grid_bottom_right, _obj_y_rate);

	var _obj_x_rate = (_obj.grid_x + (_obj_size * 0.5)) / _col_count;

	// 物件向绘制的中心轻微收拢避免过于靠外。
	var _obj_center_pull = 0.10;
	_obj_x_rate = lerp(_obj_x_rate, 0.5, _obj_center_pull);

	var _obj_screen_x = lerp(_obj_row_left, _obj_row_right, _obj_x_rate);

	draw_set_color(c_gray);
	draw_rectangle(_obj_screen_x - 28, _obj_screen_y - 28, _obj_screen_x + 28, _obj_screen_y + 28, false);
}


// ------------------------------------------------------------
// 5. 单位绘制
// ------------------------------------------------------------
// 绘制逻辑说明：
// 1. 单位的“站位点”使用格子的中心偏下位置，而不是正中心。
// 2. 因为角色 sprite 源点距离图片底部大约 128px，
//    所以 draw_sprite_ext 的绘制 y 点需要向上补偿。
// 3. unit_base_draw_w 控制 size=1 单位的显示宽度。
//    原图宽 256，unit_base_draw_w=96 时，缩放比例就是 96/256=0.375。

for (var _draw_depth = 1; _draw_depth <= _row_count + 3; _draw_depth++)
{
	for (var _unit_i = 0; _unit_i < array_length(_state.units); _unit_i++)
	{
		var _unit = _state.units[_unit_i];
		if (_unit.removed) continue;

		var _unit_size = max(1, _unit.size);

		// 用单位脚下所在的最靠近玩家的行来排序。
		// grid_y 越大，越靠近镜头，越应该后画。
		var _unit_depth = floor(_unit.grid_y + _unit_size);
		if (_unit_depth != _draw_depth) continue;

		var _unit_start_row = clamp(floor(_unit.grid_y), 0, _row_count - 1);
		var _unit_end_row = clamp(floor(_unit.grid_y + _unit_size), _unit_start_row + 1, _row_count);

		// 单位占据的行高。
		var _unit_span_h = _row_ys[_unit_end_row] - _row_ys[_unit_start_row];

		// 单位站位点。
		// 0.5 是格子正中心。
		// 建议角色站在格子中心偏下，例如 0.68。
		// 如果角色仍然太低，就改小，比如 0.62。
		// 如果角色太高，就改大，比如 0.72。
		var _unit_anchor_rate_y = 0.66;
		var _unit_stand_y = _row_ys[_unit_start_row] + _unit_span_h * _unit_anchor_rate_y;

		// 根据站位点 y 计算当前横截面的左右边界。
		var _unit_y_rate = (_unit_stand_y - grid_top_y) / _grid_total_screen_h;

		var _unit_row_left = lerp(grid_top_left, grid_bottom_left, _unit_y_rate);
		var _unit_row_right = lerp(grid_top_right, grid_bottom_right, _unit_y_rate);

		// 单位的地面中心 x。
		var _unit_x_rate = (_unit.grid_x + (_unit_size * 0.5)) / _col_count;

		// 角色视觉中心向棋盘中线收拢一点。
		// 0 = 不修正；1 = 完全贴到中心线。
		// 建议先用 0.12 ~ 0.18。
		var _unit_center_pull = 0.025;
		_unit_x_rate = lerp(_unit_x_rate, 0.5, _unit_center_pull);

		var _unit_screen_x = lerp(_unit_row_left, _unit_row_right, _unit_x_rate);

		var _unit_spr = _unit.spr_idle;

		// size=1 时宽度为 unit_base_draw_w。
		// 你的原图宽 256，如果 unit_base_draw_w=96，则缩放为 0.375。
		var _unit_draw_w = unit_base_draw_w * _unit_size;
		var _unit_scale = _unit_draw_w / sprite_get_width(_unit_spr);

		// 你的 sprite 源点距离图片底部大约 128px。
		// 因为图片会被缩放，所以补偿值也要乘以 _unit_scale。
		//
		// 这个值的含义是：
		// “从 sprite 源点到角色脚底/底部的大约像素距离”。
		// 如果角色还是太靠下，就增大这个值，比如 150。
		// 如果角色被抬得太高，就减小这个值，比如 100。
		var _unit_origin_to_bottom = 128;
		var _unit_origin_fix_y = _unit_origin_to_bottom * _unit_scale;

		// 最终绘制点。
		// draw_sprite_ext 的 y 是 sprite 源点位置。
		// 我们希望角色脚底接近 _unit_stand_y，
		// 所以源点要放在 _unit_stand_y - 补偿值的位置。
		var _unit_draw_y = _unit_stand_y - _unit_origin_fix_y;

		draw_set_color(c_white);
		draw_sprite_ext(
			_unit_spr,
			0,
			_unit_screen_x,
			_unit_draw_y,
			_unit_scale,
			_unit_scale,
			0,
			c_white,
			1
		);

		// 名字/HP 文本建议贴近脚下站位点，而不是贴近 sprite 源点。
		draw_text_transformed(
			_unit_screen_x - 48,
			_unit_stand_y + 8,
			_unit.c_name + " " + string(_unit.HP_C) + "/" + string(_unit.HP),
			0.5,
			0.5,
			0
		);
	}
}

// 战斗日志框：复用现有 spr_msgbox 皮肤，避免和菜单 UI 脱节。
draw_sprite_stretched(spr_msgbox,image_index,log_x,log_y,log_w,log_h);
draw_set_color(c_white);
var _log_draw_y = log_y + 32;
for (var _log_i = max(0,array_length(_state.log) - 6); _log_i < array_length(_state.log); _log_i++)
{
	draw_text(log_x + 48,_log_draw_y,_state.log[_log_i]);
	_log_draw_y += 36;
}
