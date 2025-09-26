//动态菜单高度以及宽度
var _new_w = 0;
for (var i=0;i<op_length;i++)
{
	var _op_w = string_width(op_option[i])
	_new_w = max(_new_w,_op_w);
}
width = _new_w + op_border*2;
height = string_height(op_option[0]) + op_border*2;

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
	draw_text_color(op_border*3,512+op_border*2+(op_space*i),op_option[i],_c,_c,_c,_c,1);
}