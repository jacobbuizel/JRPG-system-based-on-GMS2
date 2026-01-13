scr_keyboard_check();
draw_set_color(c_white);
draw_set_font(font0);
draw_set_valign(fa_top);
var _x=x,_y=y,_screen_w=window_get_width(),_screen_h=window_get_height();
draw_set_halign(fa_right);
draw_text(_screen_w,_y,"游戏BY:Jacob_chou，目前为测试阶段");
draw_set_halign(fa_left);
//debug界面
if global.debug = true
{
	draw_text(_x,_y,"fps:"+string(fps));
	_y += 32;
	draw_text(_x,_y,"上下左右键移动。按ESC键退出。按住shift键奔跑。");
	_y += 32;
	draw_text(_x,_y,"按f1键切换调试模式。按f2键自杀。按f3键快速刷新房间内可刷新物品。按f4键将玩家角色HP变为1和MP变为0。");
	_y += 32;
	draw_text(_x,_y,"按f5键快速保存，F6快速读档。按f12重启游戏。");
	_y += 32;
	draw_text(_x,_y,"按z键交互。按x键打开或关闭菜单。按c键切换战斗BGM。");
	_y += 32;
	draw_text(_x,_y,"按v键切换寻路格子显示。");
	_y += 32;
	draw_text(_x,_y,"玩家暂停:"+string(global.pause));
	_y += 32;
	draw_text(_x,_y,"是否在战斗:"+string(global.battle));
	if object_exists(obj_player)
	{	
		_y += 32;
		draw_text(_x,_y,"玩家位置:x"+string(obj_player.x)+",y"+string(obj_player.y));
	}
	_y += 32;
	var _chara_1 = 0;
	_chara_1 = load_chara(global.player[0]);
	var _chara_2 = 0;
	_chara_2 = load_chara(global.player[1]);
	draw_text(_x,_y,"玩家1HP:"+string(_chara_1.HP_C)+"/"+string(_chara_1.HP)+" 玩家2HP:"+string(_chara_2.HP_C)+"/"+string(_chara_2.HP));
	_y += 32;
	draw_text(_x,_y,"游戏时长:");
	_x += string_width("游戏时长:");
	if global.game_time_h != 0
	{
		draw_text(_x,_y,string(global.game_time_h)+":");
		_x += string_width(string(global.game_time_h)+":");
	}
	if global.game_time_h = 0 && global.game_time_m != 0
	{
		draw_text(_x,_y,string(global.game_time_m)+":");
		_x += string_width(string(global.game_time_m)+":");
	}
	else if global.game_time_h != 0
	{
		if global.game_time_m < 10
		{
			draw_text(_x,_y,"0"+string(global.game_time_m)+":");
			_x += string_width("0"+string(global.game_time_m)+":");
		}
		else
		{
			draw_text(_x,_y,string(global.game_time_m)+":");
			_x += string_width(string(global.game_time_m)+":");
		}
	}
	if global.game_time_h = 0 && global.game_time_m = 0
	{
		draw_text(_x,_y,string(global.game_time_s));
	}
	else
	{
		if global.game_time_s < 10
		{
			draw_text(_x,_y,"0"+string(global.game_time_s));
		}
		else
		{
			draw_text(_x,_y,string(global.game_time_s));
		}
	}
	_x = x;
	_y += 32;
	draw_text(_x,_y,"日期:第"+string(global.time_day)+"天");
	_x += string_width("日期:第"+string(global.time_day)+"天");
	if global.time_h < 10
	{
		draw_text(_x,_y,"0"+string(global.time_h)+":");
		_x += string_width("0"+string(global.time_h)+":");
	}
	else
	{
		draw_text(_x,_y,+string(global.time_h)+":");
		_x += string_width(string(global.time_h)+":");
	}
	if global.time_m < 10
	{
		draw_text(_x,_y,"0"+string(global.time_m));
	}
	else
	{
		draw_text(_x,_y,string(global.time_m));
	}
	_x = x;
	_y += 32;
	draw_text(_x,_y,"当前房间:"+room_get_name(room)+" 房间ID:"+string(global.roomid));
	_y += 32;
	draw_text(_x,_y,string(global.sub_menu));
	_y += 32;
}