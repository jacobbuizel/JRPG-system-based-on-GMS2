//绘制黑场
draw_sprite_tiled_ext(spr_black,image_index,0,0,1,1,c_white,0.5-menu_anm/200);

var _x = 336,_y = op_border-menu_anm;

//绘制菜单
for(var i=0;i<op_length;i++)
{
	var _c = c_gray;
	if pos == i
	{
		_c = c_white;
	}
	draw_sprite_ext(spr_menu_b,i,_x+op_border*3*(i),_y,1,1,0,_c,1);
}
draw_text(800-(string_width(op_option[menu_level,pos])/2),_y+op_border*2+16,op_option[menu_level,pos]);

//绘制时间
_x += op_border*31;
_y += 16;

draw_sprite(spr_menu_timebox,image_index,_x,_y);
_x += 5;
_y += 2;

if global.time_h < 10
{
	draw_text_transformed(_x,_y,"0"+string(global.time_h)+":",1,1,0);
	_x += string_width("0"+string(global.time_h)+":");
}
else
{
	draw_text_transformed(_x,_y,+string(global.time_h)+":",1,1,0);
	_x += string_width(string(global.time_h)+":");
}
if global.time_m < 10
{
	draw_text_transformed(_x,_y,"0"+string(global.time_m),1,1,0);
}
else
{
	draw_text_transformed(_x,_y,string(global.time_m),1,1,0);
}

/*这一段已经被弃用
//动态菜单高度以及宽度
var _new_w = 0;
for (var i=0;i<op_length;i++)
{
	var _op_w = string_width(op_option[menu_level,i])
	_new_w = max(_new_w,_op_w);
}
width = _new_w + op_border*2;
height = op_border*2 + string_height(op_option[0,0]) + (op_length-1)*op_space;
//绘制菜单背景
draw_sprite_stretched(spr_msgbox,image_index,op_border,op_border,width,height);

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
	draw_text_color(op_border*2,op_border*2+(op_space*i),op_option[menu_level,i],_c,_c,_c,_c,1);
}
*/