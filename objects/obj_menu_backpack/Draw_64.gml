//绘制初始化
var _x = 200;
var _y = op_border*5+menu_anm;
draw_sprite_stretched(spr_msgbox,image_index,_x,_y,700,height);
draw_sprite_stretched(spr_msgbox,image_index,_x+700,_y,500,height);
draw_set_font(font0);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(c_white);

_x += op_border;
_y += op_border;

draw_text(_x,_y,"物品")
_x += op_border*9+18;
draw_text(_x,_y,"数量")
_x += op_border*4;
draw_text(_x,_y,"重量")
_x += op_border*3;
draw_text(_x,_y,"总重量")
_x = 200+op_border;
_y += op_border;

var _oy = _y, _ox = _x;

if !empty
{
	var _inventory = 0;
	for(var i=0;i<inventoryEND;i++)
	{
		_inventory = load_inventory(i+item_scroll_a);
		draw_sprite_ext(_inventory.spr,image_index,_x,_y,0.125,0.125,0,c_white,1);
		_x += op_border+8;
		draw_text(_x,_y,_inventory.i_name);
		_x += op_border*8+10;
		draw_text(_x,_y,string(_inventory.amount));
		_x += op_border*4;
		draw_text(_x,_y,string(_inventory.weight)+"磅");
		_x += op_border*3;
		draw_text(_x,_y,string(_inventory.amount*_inventory.weight)+"磅");
		_x = _ox;
		_y += op_border;
	}
	_y = _oy;
	draw_rectangle(_x,_y+(item_pos*op_border),_x+636,_y+op_border+((item_pos*op_border)),true)
	_x += 790;
	_y = _oy-op_border;
	_inventory = load_inventory(item_pos+item_scroll_a);
	draw_sprite_ext(_inventory.spr,image_index,_x,_y,1,1,0,c_white,1);
	draw_sprite_ext(spr_msge,image_index,_x,_y,0.5,0.5,0,c_white,1);
	_x -= 90;
	_y += 256;
	draw_text(_x,_y,_inventory.i_name)
	_y += op_border;
	var _rarity = ""
	_x += op_border*7;
	draw_text(_x,_y,"数量:"+string(_inventory.amount));
	_x -= op_border*7;
	switch _inventory.rarity
	{
		default:
			_rarity = "";
			break;
		case 0:
			_rarity = "普通";
			break;
		case 1:
			_rarity = "非普通";
			break;
		case 2:
			_rarity = "珍惜";
			break;
		case 3:
			_rarity = "极珍惜";
			break;
		case 4:
			_rarity = "传说";
			break;
		case 5:
			_rarity = "神器";
			break;
	}
	draw_text(_x,_y,_rarity+_inventory.type_i);
	_y += op_border;
	draw_text(_x,_y,"价格:"+string(_inventory.price)+"GP");
	_x += op_border*7;
	draw_text(_x,_y,"重量:"+string(_inventory.weight)+"磅");
	_x -= op_border*7;
	_y += op_border;
	draw_text(_x,_y,string_wrap(_inventory.descr,450));
	
	//绘制滚动条
	if inventoryEND < ds_grid_height(inventory)
	{
		var visible_rows = inventoryEND;
		var total_rows   = ds_grid_height(inventory);
		var scrollbar_x1 = _ox + 642;   //滚动条的x位置
		
		var scrollbar_x2 = scrollbar_x1+6;
		var scrollbar_y1 = _oy;
		var scrollbar_y2 = scrollbar_y1 + visible_rows * op_border;
		
		var midx = (scrollbar_x1+scrollbar_x2)/2; //滚动条宽的中心

		// 滑块高度 = 窗口/总内容
		var slider_h = clamp((visible_rows / total_rows) * (scrollbar_y2 - scrollbar_y1), 20, scrollbar_y2 - scrollbar_y1);

		// 滑块位置 = 当前滚动比 * (可移动范围)
		var scroll_ratio = item_scroll_a / max(1, total_rows - visible_rows);
		var slider_y1 = scrollbar_y1 + scroll_ratio * ((scrollbar_y2 - scrollbar_y1) - slider_h);
		var slider_y2 = slider_y1 + slider_h;
		
		//绘制滚动条
		draw_set_color(c_gray);
		draw_rectangle(scrollbar_x1, scrollbar_y1, scrollbar_x2, scrollbar_y2, false);
		draw_set_color(c_white);
		draw_rectangle(scrollbar_x1, slider_y1, scrollbar_x2, slider_y2, false);
		
		//绘制箭头
		var arrow_offset = round(sin(current_time/1000 * pi) * 2); // -2 ~ +2 像素
		if item_pos + item_scroll_a != 0
		{
			// 上箭头（上下浮动）
			draw_triangle(
				midx,scrollbar_y1-15+arrow_offset,
				midx-4,scrollbar_y1-7+arrow_offset,
				midx+4,scrollbar_y1-7+arrow_offset,
				false
			);
		}
		if item_pos + item_scroll_a != ds_grid_height(inventory)-1
		{
			// 下箭头（同样浮动，但反向也行）
			draw_triangle(
				midx,scrollbar_y2+15-arrow_offset,
				midx-4,scrollbar_y2+7-arrow_offset,
				midx+4,scrollbar_y2+7-arrow_offset,
				false
			);
		}
	}
}

_x = _ox;
_y = _oy+(op_border*17);

draw_text(_x,_y,"团队负重:"+string(global.item_w)+"/"+string(load_chara(global.player[0]).str*5+load_chara(global.player[1]).str*5)+"磅")
if global.overweight
{
	_x += op_border*15+18;
	draw_text(_x,_y,"重载!");
}

if global.sub_menu == 2
{
	//动态菜单高度以及宽度
	var _new_w = 0;
	for (var i=0;i<op_length;i++)
	{
		var _op_w = string_width(op_option[i])
		_new_w = max(_new_w,_op_w);
	}
	var o_width = _new_w + op_border*2;
	var o_height = op_border*2 + string_height(op_option[0]) + (op_length-1)*op_space;

	//绘制菜单背景
	draw_sprite_stretched(spr_msgbox,image_index,736+op_border,op_border*7+(item_pos*op_border),o_width,o_height);

	//绘制选项
	draw_set_font(font0);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);

	for (var i=0;i<op_length;i++)
	{
		var _c = c_white;
		if pos == i
		{
			_c = c_yellow;
		}
		draw_text_color(736+op_border*2,op_border*7+(item_pos*op_border)+op_border+(op_space*i),op_option[i],_c,_c,_c,_c,1);
	}
}

if global.sub_menu == 3 && !instance_exists(obj_menu_useitem)
{
	_x = (display_get_width()) / 2 - 160;
	_y = (display_get_height()) / 2 - 150;
	
	//绘制菜单背景
	draw_sprite_stretched(spr_msgbox, image_index, _x, _y, 160, 150);
	
	//绘制选项标题
	draw_set_font(font0);
	var _c = c_white;
	draw_text_color(_x + op_border, _y + op_border, "丢弃数量",_c,_c,_c,_c,1);
	
	_y += op_border*1.5;
	
	//计算每一位数字
	var digits = [floor(discard_amount/100)%10, floor(discard_amount/10)%10, discard_amount%10];
	for (var i=0; i<3; i++)
	{
		var _dx = _x + op_border*1.24 + i*32;
		var _dy = _y+32;
		
	// 高亮框和箭头
	if (i == discard_cursor)
	{
		draw_set_color(c_white);
		//方框
		draw_rectangle(_dx-6, _dy-2, _dx+18, _dy+32, true);
		//方框中心X
		var midx = (_dx-6+_dx+18)/2;
		//箭头抖动偏移动画（sin 波，周期60帧，大约1秒）
		var arrow_offset = round(sin(current_time/1000 * pi) * 2); // -2 ~ +2 像素

		// 上箭头（上下浮动）
		draw_triangle(
			midx,_dy-15+arrow_offset,
			midx-6,_dy-7+arrow_offset,
			midx+6,_dy-7+arrow_offset,
			false
		);

		// 下箭头（同样浮动，但反向也行）
		draw_triangle(
			midx,_dy+44-arrow_offset,
			midx-6,_dy+36-arrow_offset,
			midx+6,_dy+36-arrow_offset,
			false
		);
	}

		//绘制数字
		draw_set_color(c_white);
		draw_text(_dx, _dy, string(digits[i]));
	}
}
