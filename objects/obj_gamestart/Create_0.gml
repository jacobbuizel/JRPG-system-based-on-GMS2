playerX = 0;
playerY = 0;
partnerX = 0;
partnerY = 0;
if !global.gamestart
{
	//通用设置
	global.debug = true;
	global.message_set_speed = 0.5;
	global.auto_run = false;
	//游戏总时间
	global.game_time_s = 0;
	global.game_time_m = 0;
	global.game_time_h = 0;
	//游戏内时间
	global.time_m = 0;
	global.time_h = 7;
	global.time_day = 1;
	
	//不可变的全局变量	
	global.talking = false;
	global.overweight = false;
	global.noresting = false;
	global.bgm = 0;
	global.battle = false;
	global.gameover = false;
	
	reroomsatus();
	
	//需要读取存档的部分
	if global.gameload
	{
		scr_loading(global.savef);
		
		global.game_time_s = global.saveDATA.game_time_s;
		global.game_time_m = global.saveDATA.game_time_m;
		global.game_time_h = global.saveDATA.game_time_h;
		
		global.time_m = global.saveDATA.time_m;
		global.time_h = global.saveDATA.time_h;
		global.time_day = global.saveDATA.time_day;
		
		ds_grid_read(room_status,global.saveDATA.Sroom_status);
		if room_get_name(room)!=global.saveDATA.room_name
		{
			room_goto(asset_get_index(global.saveDATA.room_name));
			instance_destroy();
		}
	}
	else
	{
		global.saveDATA = 
		{
			game_time_s : global.game_time_s,
			game_time_m : global.game_time_m,
			game_time_h : global.game_time_h,
			c_date : string(current_year)+"/"+string(current_month)+"/"+string(current_day),
			
			time_m : global.time_m,
			time_h : global.time_h,
			time_day : global.time_day,
			
			Sinventory : 0,
			Sinventory_h : 0,
			Sroom_status : 0,
			Schara_status : 0,
			
			room_name : 0,
			playerSX : 0,
			playerSY : 0,
			partnerSX : 0,
			partnerSY : 0,
		}
	}
}