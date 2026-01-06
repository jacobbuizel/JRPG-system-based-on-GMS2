//绘制初始化
var _x = 216;
var _y = op_border*5+menu_anm;
var _oy = _y,_ox = _x;
draw_set_font(font0);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

//绘制人物子菜单
if global.sub_menu == 1
{
	draw_sprite_stretched(spr_msgbox,image_index,_x,_y,width,height);
	_x += op_border;
	_y += op_border;
	
	draw_rectangle(_x,_y+(pos*(128+op_border)),_x+width-(op_border*2),_y+128+((pos*(128+op_border))),true);
	
	//绘制角色图
	var _chara = 0;
	_chara = load_chara(global.player[0]);
	if _chara.portrait
	{
		draw_sprite_ext(_chara.portrait,0,_x,_y,0.25,0.25,0,c_white,1);
	}
	else draw_rectangle_color(_x,_y,_x+128,_y+128,c_black,c_black,c_black,c_black,false);
	draw_sprite_ext(spr_msge,image_index,_x,_y,0.25,0.25,0,c_white,1);
	_x += 128 + op_border/2;
	draw_text(_x,_y,string(_chara.c_name)+" 等级"+string(_chara.level)+" "+string(_chara.class_name)+":"+string(_chara.sub_class_name));
	_y += op_border;
	draw_text(_x,_y,"AC:"+string(_chara.AC_C)+" HP:"+string(_chara.HP_C)+"/"+string(_chara.HP));
	_y += op_border;
	draw_text(_x,_y,"MP:"+string(_chara.MP_C)+"/"+string(_chara.MP));
		
	_y+=op_border*3;
	_x-=128 + op_border/2;

	_chara = 0;
	_chara = load_chara(global.player[1]);
	if _chara.portrait
	{
		draw_sprite_ext(_chara.portrait,0,_x,_y,0.25,0.25,0,c_white,1);
	}
	else draw_rectangle_color(_x,_y,_x+128,_y+128,c_black,c_black,c_black,c_black,false);
	draw_sprite_ext(spr_msge,image_index,_x,_y,0.25,0.25,0,c_white,1);
	_x += 128 + op_border/2;
	draw_text(_x,_y,string(_chara.c_name)+" 等级"+string(_chara.level)+" "+string(_chara.class_name)+":"+string(_chara.sub_class_name));
	_y += op_border;
	draw_text(_x,_y,"AC:"+string(_chara.AC_C)+" HP:"+string(_chara.HP_C)+"/"+string(_chara.HP));
	_y += op_border;
	draw_text(_x,_y,"MP:"+string(_chara.MP_C)+"/"+string(_chara.MP));
}
//绘制装备栏子菜单
else if global.sub_menu >= 2
{
	//绘制角色栏
	_x = _ox;
	_y = _oy;
	draw_sprite_stretched(spr_msgbox,image_index,_x,_y,width/2-op_border*3,height);
	_x += op_border;
	_y += op_border;
	var _chara = load_chara(global.player[menu_level]);
	draw_text(_x,_y,_chara.c_name);
	_y += op_border;
	
	//绘制装备部位
	draw_text(_x,_y,"主手:");
	if _chara.main_h == 0
	{
		_x += op_border*4
		draw_text(_x,_y,"空");
		_x += op_border*3
	}
	else
	{
		_x += op_border*2
		draw_text(_x,_y,_chara.main_h.e_name);
		_x += op_border*5
	}
	draw_text(_x,_y,"副手:");
	if _chara.sec_h == 0
	{
		_x += op_border*4
		draw_text(_x,_y,"空");
		_x += op_border*3
	}
	else
	{
		_x += op_border*2
		draw_text(_x,_y,_chara.sec_h.e_name);
		_x += op_border*5
	}
	_x -= op_border*14
	_y += op_border;
	draw_text(_x,_y,"护甲:");
	if _chara.armor == 0
	{
		_x += op_border*4
		draw_text(_x,_y,"空");
		_x += op_border*3
	}
	else
	{
		_x += op_border*2
		draw_text(_x,_y,_chara.armor.e_name);
		_x += op_border*5
	}
	draw_text(_x,_y,"配饰:");
	if _chara.accessoryA == 0
	{
		_x += op_border*4
		draw_text(_x,_y,"空");
		_x += op_border*3
	}
	else
	{
		_x += op_border*2
		draw_text(_x,_y,_chara.accessoryA.e_name);
		_x += op_border*5
	}
	_x -= op_border*14
	_y += op_border;
	draw_text(_x,_y,"配饰:");
	if _chara.accessoryB == 0
	{
		_x += op_border*4
		draw_text(_x,_y,"空");
		_x += op_border*3
	}
	else
	{
		_x += op_border*2
		draw_text(_x,_y,_chara.accessoryB.e_name);
		_x += op_border*5
	}
	draw_text(_x,_y,"配饰:");
	if _chara.accessoryC == 0
	{
		_x += op_border*4
		draw_text(_x,_y,"空");
		_x += op_border*3
	}
	else
	{
		_x += op_border*2
		draw_text(_x,_y,_chara.accessoryC.e_name);
		_x += op_border*5
	}
	_x -= op_border*14
	
	//绘制属性
	_y += op_border;
	if _chara.str_m >= 0
	{
		draw_text(_x,_y,"力量:"+string(_chara.str)+"(+"+string(_chara.str_m)+")");
	}
	else
	{
		draw_text(_x,_y,"力量:"+string(_chara.str)+"("+string(_chara.str_m)+")");
	}
	_x += op_border*5;
	if _chara.dex_m >= 0
	{
		draw_text(_x,_y,"敏捷:"+string(_chara.dex)+"(+"+string(_chara.dex_m)+")");
	}
	else
	{
		draw_text(_x,_y,"敏捷:"+string(_chara.dex)+"("+string(_chara.dex_m)+")");
	}
	_x += op_border*5;
	if _chara.con_m >= 0
	{
		draw_text(_x,_y,"体质:"+string(_chara.con)+"(+"+string(_chara.con_m)+")");
	}
	else
	{
		draw_text(_x,_y,"体质:"+string(_chara.con)+"("+string(_chara.con_m)+")");
	}
	_x -= op_border*10;
	_y += op_border;
	if _chara.int_m >= 0
	{
		draw_text(_x,_y,"智力:"+string(_chara.int)+"(+"+string(_chara.int_m)+")");
	}
	else
	{
		draw_text(_x,_y,"智力:"+string(_chara.int)+"("+string(_chara.int_m)+")");
	}
	_x += op_border*5;
	if _chara.wis_m >= 0
	{
		draw_text(_x,_y,"感知:"+string(_chara.wis)+"(+"+string(_chara.wis_m)+")");
	}
	else
	{
		draw_text(_x,_y,"感知:"+string(_chara.wis)+"("+string(_chara.wis_m)+")");
	}
	_x += op_border*5;
	if _chara.cha_m >= 0
	{
		draw_text(_x,_y,"魅力:"+string(_chara.cha)+"(+"+string(_chara.cha_m)+")");
	}
	else
	{
		draw_text(_x,_y,"魅力:"+string(_chara.cha)+"("+string(_chara.cha_m)+")");
	}
	_x -= op_border*10;
	_y += op_border;
	draw_text(_x,_y,"AC:"+string(_chara.AC));
	_x += op_border*5;
	draw_text(_x,_y,"HP:"+string(_chara.HP_C)+"/"+string(_chara.HP));
	_x -= op_border*5;
	_y += op_border;
	draw_text(_x,_y,"MP:"+string(_chara.MP_C)+"/"+string(_chara.MP));
	_y += op_border;
	draw_text(_x,_y,"移动力:"+string(_chara.spd)+"格");
	_x += op_border*5;
	draw_text(_x,_y,"熟练加值:+"+string(_chara.PRO_B));
	_x -= op_border*5;
	_y += op_border;
	
	//绘制选框
	_x = _ox+op_border*3;
	_y = _oy+op_border*2;
	if global.sub_menu != 2
	{
		draw_set_colour(c_gray);
	}
	draw_rectangle(_x+(e_pos_col*(op_border*7)),_y+(e_pos_row*op_border),_x+(e_pos_col*(op_border*7)+op_border*4.8),_y+op_border+((e_pos_row*op_border)),true);
	draw_set_colour(c_white);
	
	//绘制装备栏
	_ox += width/2-op_border*3;
	_x = _ox;
	_y = _oy;
	draw_sprite_stretched(spr_msgbox,image_index,_x,_y,width/2+op_border*3,height/2+114);
	_x += op_border;
	_y += op_border;
	draw_text(_x,_y,"物品")
	_x += op_border*9+18;
	draw_text(_x,_y,"数量")
	_x += op_border*3;
	draw_text(_x,_y,"重量")
	_x += op_border*4;
	draw_text(_x,_y,"总重量")
	_x = _ox;
	_y += op_border;
	//绘制物品列表
	if !equip_empty
	{
		var _equipment = 0;
		for(var i=0;i<equipmentEND;i++)
		{
			_x = _ox+op_border;
			_equipment = load_equipment(i+equip_scroll_a);
			draw_sprite_ext(_equipment.spr,image_index,_x,_y,0.125,0.125,0,c_white,1);
			_x += op_border+9;
			draw_text(_x,_y,_equipment.e_name);
			_x += op_border*8+10;
			draw_text(_x,_y,string(_equipment.amount));
			_x += op_border*3;
			draw_text(_x,_y,string(_equipment.weight)+"磅");
			_x += op_border*4;
			draw_text(_x,_y,string(_equipment.amount*_equipment.weight)+"磅");
			_x = _ox+op_border;
			_y += op_border;
		}
		_y = _oy+op_border*2;
		if global.sub_menu < 4
		{
			draw_set_colour(c_gray);
		}
		draw_rectangle(_x,_y+(equip_pos*op_border),_x+width/2+op_border,_y+op_border+((equip_pos*op_border)),true);
		draw_set_colour(c_white);
		_x += 790;
		_y = _oy-op_border;
		
		//绘制滚动条
		if equipmentEND < ds_grid_height(equipment)
		{
			var visible_rows = equipmentEND;
			var total_rows   = ds_grid_height(equipment);
			var scrollbar_x1 = _ox + width/2+op_border*2+6;   //滚动条的x位置
		
			var scrollbar_x2 = scrollbar_x1+7;
			var scrollbar_y1 = _oy + op_border*2;
			var scrollbar_y2 = scrollbar_y1 + visible_rows * op_border;
		
			var midx = (scrollbar_x1+scrollbar_x2)/2; //滚动条宽的中心

			// 滑块高度 = 窗口/总内容
			var slider_h = clamp((visible_rows / total_rows) * (scrollbar_y2 - scrollbar_y1), 20, scrollbar_y2 - scrollbar_y1);

			// 滑块位置 = 当前滚动比 * (可移动范围)
			var scroll_ratio = equip_scroll_a / max(1, total_rows - visible_rows);
			var slider_y1 = scrollbar_y1 + scroll_ratio * ((scrollbar_y2 - scrollbar_y1) - slider_h);
			var slider_y2 = slider_y1 + slider_h;
		
			//绘制滚动条
			draw_set_color(c_gray);
			draw_rectangle(scrollbar_x1, scrollbar_y1, scrollbar_x2, scrollbar_y2, false);
			draw_set_color(c_white);
			draw_rectangle(scrollbar_x1, slider_y1, scrollbar_x2, slider_y2, false);
		
			//绘制箭头
		    var arrow_offset = round(sin(current_time/1000 * pi) * 2); // -2 ~ +2 像素
		
			if equip_pos+equip_scroll_a != 0
			{
			    // 上箭头（上下浮动）
			    draw_triangle(
			        midx,scrollbar_y1-15+arrow_offset,
			        midx-4,scrollbar_y1-7+arrow_offset,
			        midx+4,scrollbar_y1-7+arrow_offset,
			        false
			    );
			}
			if equip_pos+equip_scroll_a != ds_grid_height(equipment)-1
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
	_x = _ox+op_border;
	_y = _oy+(op_border*12);
	draw_text(_x,_y,"团队负重:"+string(global.item_w)+"/"+string(load_chara(global.player[0]).str*5+load_chara(global.player[1]).str*5)+"磅")
	if global.overweight
	{
		_x += op_border*16+18;
		draw_text(_x,_y,"重载!");
	}
	_ox -= width/2-op_border*3;
	
	//绘制装备描述栏
	_ox += width/2-op_border*3;
	_x = _ox;
	_y = _oy+height/2+114;
	draw_sprite_stretched(spr_msgbox,image_index,_x,_y,width/2+op_border*3,height/2-114);
	if !equip_empty
	{
		_x += op_border;
		_y += op_border;
		var _equipment = 0;
		_equipment = load_equipment(equip_pos+equip_scroll_a);
		draw_sprite_ext(_equipment.spr,image_index,_x+5,_y+op_border*0.5,0.5,0.5,0,c_white,1);
		draw_sprite_ext(spr_msge,image_index,_x+5,_y+op_border*0.5,0.25,0.25,0,c_white,1);
		_x += op_border*4.8;
		var _rarity = ""
		switch _equipment.rarity
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
		draw_text(_x,_y,_equipment.e_name+" "+_rarity+_equipment.type_descr);
		draw_text(_x+op_border*10,_y,"价格:"+string(_equipment.price)+"GP");
		
		_y += op_border;
		draw_text(_x,_y,string_wrap(_equipment.descr,480));
	}
	_ox -= width/2-op_border*3;
}
if global.sub_menu == 3
{
	//动态菜单高度以及宽度
	var _new_w = 0;
	for (var i=0;i<op_length_slot_eq;i++)
	{
		var _op_w = string_width(op_option_slot_eq[i])
		_new_w = max(_new_w,_op_w);
	}
	var o_width = _new_w + op_border*2;
	var o_height = op_border*2 + string_height(op_option_slot_eq[0]) + (op_length_slot_eq-1)*op_space;

	//绘制菜单背景
	draw_sprite_stretched(spr_msgbox,image_index,736+op_border,op_border*7+(equip_pos*op_border),o_width,o_height);

	//绘制选项
	draw_set_font(font0);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);

	for (var i=0;i<op_length_slot_eq;i++)
	{
		var _c = c_white;
		if pos_slot_eq == i
		{
			_c = c_yellow;
		}
		draw_text_color(736+op_border*2,op_border*7+(equip_pos*op_border)+op_border+(op_space*i),op_option_slot_eq[i],_c,_c,_c,_c,1);
	}
}
if global.sub_menu == 5
{
	//动态菜单高度以及宽度
	var _new_w = 0;
	for (var i=0;i<op_length_eq;i++)
	{
		var _op_w = string_width(op_option_eq[i])
		_new_w = max(_new_w,_op_w);
	}
	var o_width = _new_w + op_border*2;
	var o_height = op_border*2 + string_height(op_option_eq[0]) + (op_length_eq-1)*op_space;

	//绘制菜单背景
	draw_sprite_stretched(spr_msgbox,image_index,736+op_border,op_border*7+(equip_pos*op_border),o_width,o_height);

	//绘制选项
	draw_set_font(font0);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);

	for (var i=0;i<op_length_eq;i++)
	{
		var _c = c_white;
		if pos_eq == i
		{
			_c = c_yellow;
		}
		draw_text_color(736+op_border*2,op_border*7+(equip_pos*op_border)+op_border+(op_space*i),op_option_eq[i],_c,_c,_c,_c,1);
	}
}