draw_set_font(font0);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

var _title = "设置";

//保持面板宽度和滑块的比例
var _content_w = 500;
width = _content_w + op_border * 2;
height = op_border * 2 + op_space * (op_length + 2);

var _x0 = (1600 - width) / 2;
var _y0 = (900 - height) / 2;

draw_sprite_stretched(spr_msgbox, image_index, _x0, _y0, width, height);

var _tx = _x0 + op_border;
var _ty = _y0 + op_border;

draw_text_color(_tx, _ty, _title, c_aqua, c_aqua, c_aqua, c_aqua, 1);
_ty += op_space;

var _label_w = 180;
var _bar_gap = 20;
var _percent_gap = 20;
var _percent_w = 70;
var _bar_x = _tx + _label_w + _bar_gap;
var _bar_w = width - op_border * 2 - _label_w - _bar_gap - _percent_gap - _percent_w;
var _percent_x = _bar_x + _bar_w + _percent_gap;

for (var i = 0; i < op_length; i++)
{
	var _selected = (pos == i);
	var _c = _selected ? c_yellow : c_white;
	var _row_y = _ty + op_space * i;

	if i <= 2
	{
		var _name = "";
		var _value = 0;
		switch (i)
		{
			case 0:
				_name = "BGM音量";
				_value = clamp(global.bgm_v, 0, 1);
				break;
			case 1:
				_name = "SFX音量";
				_value = clamp(global.sfx_v, 0, 1);
				break;
			case 2:
				_name = "BGS音量";
				_value = clamp(global.bgs_v, 0, 1);
				break;
		}

		draw_text_color(_tx, _row_y, _name, _c, _c, _c, _c, 1);

		var _bar_y = _row_y + 8;
		var _bar_h = 14;
		var _fill_w = floor((_bar_w - 4) * _value);

		draw_set_color(c_black);
		draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, false);

		if _fill_w > 0
		{
			draw_set_color(_selected ? c_yellow : c_lime);
			draw_rectangle(_bar_x + 2, _bar_y + 2, _bar_x + 2 + _fill_w, _bar_y + _bar_h - 2, false);
		}

		draw_set_color(_c);
		draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, true);

		var _pct = string(round(_value * 100)) + "%";
		draw_text_color(_percent_x, _row_y, _pct, _c, _c, _c, _c, 1);
	}
	else
	{
		var _line = "";
		switch (i)
		{
			case 3:
				_line = "自动奔跑: " + (global.auto_run ? "开" : "关");
				break;
			case 4:
				_line = "恢复默认设置";
				break;
			case 5:
				_line = "返回";
				break;
		}
		draw_text_color(_tx, _row_y, _line, _c, _c, _c, _c, 1);
	}
}