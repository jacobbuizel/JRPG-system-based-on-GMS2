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
		draw_chara_block(_chara,_x,_y,op_border);
		_y+=op_border*5;
	}
}