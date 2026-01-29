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
	for (var i = 0; i < global.totalchara; i++)
	{
		_chara = load_chara(global.player[i]);
		//绘制角色图
		draw_chara_block(_chara,_x,_y,op_border);
		_y+=op_border*5;
	}
}
else if global.sub_menu == 2
{
	//绘制角色状态
	_x = _ox+op_border;
	_y = _oy+op_border;
	var _chara = 0;
	_chara = load_chara(global.player[menu_level]);
	//todo:显示技能列表
	
}