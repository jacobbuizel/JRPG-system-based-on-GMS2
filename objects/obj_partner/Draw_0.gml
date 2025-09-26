//debug窗口绘制
if global.debug
{
	draw_self();
	draw_set_color(c_white);
	var _x=x+32,_y=y-8;
	draw_path(follow_path,x,y,0);
	draw_text_transformed(_x,_y,"xspeed:"+string(vx),0.5,0.5,0);
	_y += 8;
	draw_text_transformed(_x,_y,"yspeed:"+string(vy),0.5,0.5,0);
	_y += 8;
	draw_text_transformed(_x,_y,"vspeed:"+string(vs),0.5,0.5,0);
	_y += 8;
	draw_text_transformed(_x,_y,"npcbe:"+string(npc_behavior),0.5,0.5,0);
	_y += 8;
}
scr_spriting();