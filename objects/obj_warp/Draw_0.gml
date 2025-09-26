if global.debug = true
{
	draw_self();
	draw_set_color(c_black);
	var _x=x,_y=y;
	draw_text_transformed(_x,_y,string(target_rm),0.5,0.5,0);
	_y += 8;
	draw_text_transformed(_x,_y,string(target_x),0.5,0.5,0);
	_y += 8;
	draw_text_transformed(_x,_y,string(target_y),0.5,0.5,0);
	_y += 8;
}