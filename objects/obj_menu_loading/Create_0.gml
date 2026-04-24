depth = -1001;
global.pause = true;
global.sub_menu = 1;

width = 1200;
height = 680;

op_border = 32;
op_space = 32;

menu_anm = 800;
menu_cloes = false;

pos = 0;
scroll_a = 0;

pos_1 = 0;
pos_2 = 1;

wait_time = 30;

roomgoto=false;

for(var i = 0;i<=50;i++)
{
	var _filename = "savedata"+string(i)+".sav"
	if file_exists(_filename)
	{
		var _saveDATA_P = 
		{
			game_time_s : 0,
			game_time_m : 0,
			game_time_h : 0,
			c_date : string(current_year)+"/"+string(current_month)+"/"+string(current_day),
			
			time_m : 0,
			time_h : 0,
			time_day : 0,
			
			Sinventory : 0,
			Sinventory_h : 0,
			Sroom_status_version : 0,
			Sroom_status : 0,
			Schara_status : 0,
			
			room_name : 0,
			playerSX : 0,
			playerSY : 0,
			partnerSX : 0,
			partnerSY : 0,
		}
		
		var _buffer = buffer_load(_filename);
		var _json = buffer_read(_buffer,buffer_string);
		buffer_delete(_buffer);
		
		var _loadArr = json_parse(_json);
		
		_saveDATA_P = array_get(_loadArr,0);
		op_option[i] = "存档"+string(i)+" 日期:"+string(_saveDATA_P.c_date)+" 游戏时长:"+string(_saveDATA_P.game_time_h)+":"+string(_saveDATA_P.game_time_m)+":"+string(_saveDATA_P.game_time_s)
	}
	else
	{
		op_option[i] = "存档"+string(i)+" 空"
	}
}


op_length = array_length(op_option);

op_option_1[0] = "保存";
op_option_1[1] = "读取";
op_option_1[2] = "删除";

op_length_1 = array_length(op_option_1);

op_option_2[0] = "确认";
op_option_2[1] = "取消";

op_length_2 = array_length(op_option_2);
