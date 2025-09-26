//绘制菜单背景
var _x = 216;
var _y = op_border*5+menu_anm;
draw_sprite_stretched(spr_msgbox,image_index,_x,_y,width,height);

var _oy = _y,_ox = _x;

//绘制选项
draw_set_font(font0);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

if global.sub_menu == 1
{
	_x += op_border;
	_y += op_border;
	
	draw_rectangle(_x,_y+(pos*(128+op_border)),_x+width-(op_border*2),_y+128+((pos*(128+op_border))),true);
	
	//绘制角色图
	var _chara = 0;
	_chara = load_chara(global.player1);
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

	_chara = load_chara(global.player2);
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
else if global.sub_menu == 2
{
	//绘制角色状态
	_x = _ox+op_border;
	_y = _oy+op_border;
	var _chara = 0;
	switch menu_level
	{
	case 0:
		_chara = load_chara(global.player1);
		if _chara.art
		{
			draw_sprite_ext(_chara.art,1,_x,_y,1,1,0,c_white,1);
		}
		break;
	case 1:
		_chara = load_chara(global.player2);
		if _chara.art
		{
			draw_sprite_ext(_chara.art,1,_x,_y,1,1,0,c_white,1);
		}
		break;
	}
	_x += op_border+536;
	draw_text(_x,_y,_chara.c_name);
	_x += op_border*5;
	//draw_text(_x,_y,_chara.alignment);
	_x -= op_border*5;
	_y += op_border;
	draw_text(_x,_y,"种族:"+_chara.sub_race);
	_x += op_border*5;
	draw_text(_x,_y,"职业:"+_chara.class_name+"-"+_chara.sub_class_name);
	_x -= op_border*5;
	_y += op_border;
	draw_text(_x,_y,"等级:"+string(_chara.level)+"(xp:"+string(_chara.xp)+")");
	_y += op_border;
	if _chara.level < 20
	{
		// 定义每个等级所需的经验值数组
		var tnxpArray = [300, 900, 2700, 6500, 14000, 23000, 34000, 48000, 64000, 85000, 100000, 120000, 140000, 165000, 195000, 225000, 265000, 305000, 355000];

		// 获取当前等级所需的经验值，假设等级是从1开始的
		var _tnxp = 0;
		if (_chara.level > 0 && _chara.level <= array_length(tnxpArray)) {
		    _tnxp = tnxpArray[_chara.level - 1];
		}

		// 绘制文本
		draw_text(_x, _y, "距离下一级还有:" + string(_tnxp - _chara.xp) + "xp");

	}
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
	
	_ox = _x;

	_x = _ox;
	draw_text(_x,_y,"简介");
	_y += op_border;
	draw_text(_x,_y,_chara.descr)
}