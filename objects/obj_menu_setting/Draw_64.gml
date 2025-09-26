//动态菜单高度以及宽度
var _new_w = 0;
for (var i=0;i<op_length;i++)
{
	var _op_w = string_width(op_option[menu_level,i]);
	_new_w = max(_new_w,_op_w);
}
width = _new_w + op_border*2;
height = op_border*2 + string_height(op_option[0,0]) + (op_length-1)*op_space;

//绘制菜单背景
draw_sprite_stretched(spr_msgbox,image_index,(1600-width)/2,(900-height)/2,width,height);

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
	draw_text_color((1600-width)/2+op_border,(900-height)/2+op_border+(op_space*i),op_option[menu_level,i],_c,_c,_c,_c,1);
}