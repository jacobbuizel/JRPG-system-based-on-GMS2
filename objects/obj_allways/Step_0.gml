//游戏结束键
if esckey game_end();
//游戏重启键
if f12key game_restart();
//保存
if f5key scr_saving(0);
//读档
if f6key && file_exists("savedata0.sav")
{
	audio_play_sound(sfx_select,9,false);
	roomgoto = true;
	loding = true;
	global.warping = 1;
	global.bgm = 0;
	instance_create_layer(x,y,"Instances",obj_warp_anm);
}
if roomgoto && loding && global.warping == 2
{
	global.pause = false;
	global.sub_menu = 0;
	global.gamestart = false;
	global.gameload = true;
	global.savef = 0;
	instance_destroy(obj_player);
	instance_destroy(obj_partner);
	instance_destroy(obj_allways);
	instance_destroy(obj_charsatus);
	instance_destroy(obj_item_manager);
	reroomsatus();
	room_goto(room_TEST_1);
	instance_destroy(self);
}


//debug交互
if f1key
{
	if global.debug
	{
		global.debug = false;
	}
	else
	{
		global.debug = true;
	}
}
if xkey && global.debug
{
	if global.battle
	{
		global.battle = false;
	}
	else
	{
		global.battle = true;
	}
}
if f2key && global.debug
{
	var _chara = load_chara(global.player[0]);
	_chara.HP_C=0;
	_chara = load_chara(global.player[1]);
	_chara.HP_C=0;
}
if f3key && global.debug
{
	restor_roomsatus(global.roomid);
}
if f4key && global.debug
{
	var _chara = load_chara(global.player[0]);
	_chara.HP_C=1;
	_chara.MP_C=1;
	_chara = load_chara(global.player[1]);
	_chara.HP_C=1;
	_chara.MP_C=1;
}

//战斗管理
if global.battle
{
	audio_group_set_gain(audiogroup_BGM_2,global.bgm_v,0);
}
else
{
	audio_group_set_gain(audiogroup_BGM_2,0,0);
}

//时间计算
gamens++;
if gamens>=60
{
	global.game_time_s++;
	gamens = 0;
}
if global.game_time_s>=60
{
	global.game_time_m++;
	global.game_time_s-=60;
}
if global.game_time_m>=60
{
	global.game_time_h++;
	global.game_time_m-=60;
}
	
//游戏内时间
if !global.pause && !global.talking
{
	times++;
	if times>=3600
	{
		global.time_m++;
		times = 0;
	}
	if global.time_m>=60
	{
		global.time_h++;
		global.time_m-=60;
	}
	if global.time_h>=24
	{
		global.time_day++;
		global.time_h-=24;
	}
}

//寻路格子刷新
global.grid_solid = mp_grid_create(0,0,room_width / 32,room_height / 32,32,32);
global.grid_h_npc_solid = mp_grid_create(0,0,room_width / 32,room_height / 32,32,32);
mp_grid_add_instances(global.grid_solid,obj_solid,false);
mp_grid_add_instances(global.grid_h_npc_solid,obj_h_npc_solid,false);


//游戏结束
if global.gameover && !global.talking
{
	if !roomgoto
	{
		roomgoto = true;
		global.warping = 1;
		instance_create_layer(x,y,"Instances",obj_warp_anm);
	}
	if roomgoto && !loding && global.warping == 2
	{
		if instance_exists(obj_partner)
		{
			instance_destroy(obj_partner);
		}
		instance_destroy(obj_player);
		instance_destroy(obj_item_manager);
		instance_destroy(obj_charsatus);
		instance_destroy();
		room_goto(room_game_over);
	}
}