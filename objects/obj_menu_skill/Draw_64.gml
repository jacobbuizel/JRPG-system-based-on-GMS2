//绘制初始化
var _x = 216;
var _y = op_border*5+menu_anm;
var _chara = 0;
var _skill = 0;
var _chara_skill_list = 0;

var _oy = _y,_ox = _x;

//绘制选项
draw_set_font(font0);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

//角色选择子菜单
if global.sub_menu == 1
{
	draw_sprite_stretched(spr_msgbox,image_index,_x,_y,width,height);
	_x += op_border;
	_y += op_border;

	draw_rectangle(_x,_y+(pos*(128+op_border)),_x+width-(op_border*2),_y+128+((pos*(128+op_border))),true);

	//绘制角色图
	for (var i = 0; i < global.totalchara; i++)
	{
		_chara = load_chara(global.player[i]);
		//绘制角色图
		draw_chara_block(_chara,_x,_y,op_border);
		_y+=op_border*5;
	}
}
//技能列表子菜单
else if global.sub_menu >= 2
{
	//绘制左侧角色状态面板
	var _left_panel_w = width/1.5;
	var _left_panel_h = op_border*6;
	_x = _ox;
	_y = _oy;
	draw_sprite_stretched(spr_msgbox,image_index,_x,_y,_left_panel_w,_left_panel_h);
	_x += op_border;
	_y += op_border;
	
	//绘制角色
	_chara = load_chara(global.player[menu_level]);
	draw_chara_block(_chara,_x,_y,op_border);

	//绘制右侧技能列表面板
	var _right_panel_x = _ox + _left_panel_w;
	var _right_panel_w = width/3;
	_x = _right_panel_x;
	_y = _oy;
	draw_sprite_stretched(spr_msgbox,image_index,_x,_y,_right_panel_w,height);
	_x += op_border;
	_y += op_border;

	draw_text(_x,_y,"技能");
	_y += op_border;

	var _list_x = _x;
	var _list_y = _y;
	_chara_skill_list = _chara.skill_list;

	if !skill_empty
	{
		//绘制技能列表
		for(var i=0; i<skillEND; i++)
		{
			_x = _list_x;
			_skill = load_skill(_chara,i+skill_scroll_a);
			draw_text(_x, _list_y, _skill.s_name);
			_list_y += op_space;
		}
		
		//绘制选中框
		draw_rectangle(_x,_y+(skill_pos*op_space),_x+op_border*10,_y+op_space+(skill_pos*op_space),true);

		//绘制滚动条
		if skillEND < ds_grid_height(_chara_skill_list)
		{
			var visible_rows = skillEND;
			var total_rows = ds_grid_height(_chara_skill_list);
			var scrollbar_x1 = _right_panel_x + _right_panel_w - op_border - 10;
			var scrollbar_x2 = scrollbar_x1 + 7;
			var scrollbar_y1 = _oy + op_border * 2;
			var scrollbar_y2 = scrollbar_y1 + visible_rows * op_space;

			var midx = (scrollbar_x1 + scrollbar_x2) / 2;

			// 滑块高度
			var slider_h = clamp((visible_rows / total_rows) * (scrollbar_y2 - scrollbar_y1), 20, scrollbar_y2 - scrollbar_y1);

			// 滑块位置
			var scroll_ratio = skill_scroll_a / max(1, total_rows - visible_rows);
			var slider_y1 = scrollbar_y1 + scroll_ratio * ((scrollbar_y2 - scrollbar_y1) - slider_h);
			var slider_y2 = slider_y1 + slider_h;

			//绘制滚动条
			draw_set_color(c_gray);
			draw_rectangle(scrollbar_x1, scrollbar_y1, scrollbar_x2, scrollbar_y2, false);
			draw_set_color(c_white);
			draw_rectangle(scrollbar_x1, slider_y1, scrollbar_x2, slider_y2, false);

			//绘制箭头
			var arrow_offset = round(sin(current_time/1000 * pi) * 2);
			if skill_pos + skill_scroll_a != 0
			{
				draw_triangle(
					midx, scrollbar_y1 - 15 + arrow_offset,
					midx - 4, scrollbar_y1 - 7 + arrow_offset,
					midx + 4, scrollbar_y1 - 7 + arrow_offset,
					false
				);
			}
			if skill_pos + skill_scroll_a != ds_grid_height(_chara_skill_list) - 1
			{
				draw_triangle(
					midx, scrollbar_y2 + 15 - arrow_offset,
					midx - 4, scrollbar_y2 + 7 - arrow_offset,
					midx + 4, scrollbar_y2 + 7 - arrow_offset,
					false
				);
			}
		}
	}
	else
	{
		//没有技能时显示提示
		draw_text(_list_x, _list_y, "无技能");
	}
	//绘制技能描述面板
	var _desc_panel_y = op_border*6;
	_x = _ox;
	_y = _oy+op_border*6;
	draw_sprite_stretched(spr_msgbox,image_index,_x,_y,_left_panel_w,height-op_border*6);
	_x += op_border;
	_y += op_border;
	
	if !skill_empty
	{
		//获取当前选中技能的信息
		_skill = load_skill(_chara,skill_pos+skill_scroll_a)
		//绘制技能名称
		draw_text(_x,_y,_skill.s_name);
		_y += op_border;
		//绘制描述
		draw_text(_x,_y,string_wrap(_skill.descr,_left_panel_w-op_border*2));
	}
}

//技能确认子菜单
if global.sub_menu == 3
{
	//计算确认菜单的位置（技能选框旁边）
	var _confirm_x = _ox + width-op_border*2;
	var _confirm_y = _oy + op_border*2+(skill_pos*op_space);

	//动态菜单宽度和高度
	var _new_w = 0;
	for (var i = 0;i<op_skill_length;i++)
	{
		var _op_w = string_width(op_skill_option[i]);
		_new_w = max(_new_w,_op_w);
	}
	var o_width = _new_w + op_border * 2;
	var o_height = op_border*2+string_height(op_skill_option[0])+(op_skill_length-1)*op_space;

	//绘制菜单背景
	draw_sprite_stretched(spr_msgbox, image_index, _confirm_x, _confirm_y, o_width, o_height);

	//绘制选项
	for (var i = 0; i < op_skill_length; i++)
	{
		var _c = c_white;
		if pos_skill == i
		{
			_c = c_yellow;
		}
		draw_text_color(_confirm_x + op_border, _confirm_y + op_border + (op_space * i), op_skill_option[i], _c, _c, _c, _c, 1);
	}
}