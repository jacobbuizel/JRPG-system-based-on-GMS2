//绘制菜单背景
var _x = 200;
var _y = op_border*5+menu_anm;

repeat(2)
{
	draw_sprite_stretched(spr_msgbox,image_index,_x,_y,width,height);
}

var _oy = _y,_ox = _x;

//绘制选项
draw_set_font(font0);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

if global.sub_menu == 3
{
	_x += op_border;
	_y += op_border;
	draw_rectangle(_x,_y+(pos*128+pos*op_border),_x+636,_y+128+(pos*128+pos*op_border),true)
	
	//绘制角色图
	var _chara = 0;
	for (var i = 0; i < global.totalchara; i++)
	{
		_chara = load_chara(global.player[i]);
		if _chara.portrait
		{
			draw_sprite_ext(_chara.portrait,0,_x,_y,0.25,0.25,0,c_white,1);
		}
		else draw_rectangle_color(_x,_y,_x+128,_y+128,c_black,c_black,c_black,c_black,false);
		draw_sprite_ext(spr_msge,image_index,_x,_y,0.25,0.25,0,c_white,1);
		_x += 128+op_border;
		draw_text(_x,_y,_chara.c_name+" 等级:"+string(_chara.level)+_chara.class_name+":"+_chara.sub_class_name);
		_y += op_border;
		draw_text(_x,_y,"AC:"+string(_chara.AC));
		_y += op_border;
		draw_text(_x,_y,"HP:"+string(_chara.HP_C)+"/"+string(_chara.HP)+" MP:"+string(_chara.MP_C)+"/"+string(_chara.MP));
	
		_x = _ox + op_border;
		_y = _oy + op_border*2 + 128;
	}
}