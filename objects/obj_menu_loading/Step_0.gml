if !roomgoto && global.talking != true
{
	if global.sub_menu == 1 && menu_anm <= 2 && menu_cloes == false
	{
		//切换选项
		pos += dpkey - upkey;
		
		//右键一次跳5行
		if rpkey
		{
			scr_menu_movement_jump(id,"pos","scroll_a",51,18,5,1,1);
		}
		//左键一次跳5行
		if lpkey
		{
			scr_menu_movement_jump(id,"pos","scroll_a",51,18,5,0,1);
		}
			
		//音效
		if dpkey || upkey || rpkey || lpkey
		{
			audio_play_sound(sfx_click,9,false);
		}
			
		// 把互斥键收集到一个数组或列表
		var _dir_keys = [ukey,dkey,lkey,rkey];

		// 统计按下了多少个互斥键
		var _pressed_count = 0;
		for (var i = 0; i < array_length(_dir_keys); i++)
		{
			if (_dir_keys[i])
			{
				_pressed_count++;
			}
		}
		// 如果按下两个及以上，算互斥
		if (_pressed_count >= 2)
		{
			wait_time = 30;
		}
		else if (_pressed_count == 1)
		{
			if (wait_time > 0)
			{
				wait_time--;
			}
		}
		else
		{
			wait_time = 30;
		}
			
		//长按快速切换选取
		if ukey || dkey || lkey || rkey
		{
			if wait_time > 0
			{
				wait_time--;
			}
		}
		else wait_time = 30;
		if wait_time <= 0
		{
			pos += dkey - ukey;
			//右键一次跳5行
			if rkey
			{
				scr_menu_movement_jump(id,"pos","scroll_a",51,18,5,1,1);
			}
			//左键一次跳5行
			if lkey
			{
				scr_menu_movement_jump(id,"pos","scroll_a",51,18,5,0,1);
			}
			if !(_pressed_count >= 2)
			{
				audio_play_sound(sfx_click,9,false);
			}
			wait_time = 5;
		}
		
		if pos >= 18
		{
			if 17+scroll_a < 50
			{
				scroll_a++;
				pos = 17;
			}
			else
			{
				scroll_a = 0;
				pos = 0;
			}
		}	
		if pos < 0
		{
			if scroll_a > 0
			{
				scroll_a--;
				pos = 0;
			}
			else
			{
				scroll_a = 50 - 17;
				pos = 17;
			}
		}
		
		if akey && !key_cooldown[0]
		{
			key_cooldown[0]=1;
			if ((room_get_name(room) == "room_TITLE") || (room_get_name(room) == "room_game_over"))
			{
				var _new_op_option_1 = [];
				_new_op_option_1[0] = "读取";
				_new_op_option_1[1] = "删除";
	
				op_option_1 = _new_op_option_1;
				op_length_1 = array_length(op_option_1);
				if !(op_option[pos+scroll_a] = "存档"+string(pos+scroll_a)+" 空")
				{
					global.sub_menu++;
					audio_play_sound(sfx_select,9,false);
				}
				else
				{
					audio_play_sound(sfx_deselect,9,false);
				}

			}
			else
			{
				if !(op_option[pos+scroll_a] = "存档"+string(pos+scroll_a)+" 空")
				{
					var _new_op_option_1 = [];
					_new_op_option_1[0] = "保存";
					_new_op_option_1[1] = "读取";
					_new_op_option_1[2] = "删除";

					op_option_1 = _new_op_option_1;
					op_length_1 = array_length(op_option_1);
				}
				else
				{
					var _new_op_option_1 = [];
					_new_op_option_1[0] = "保存";

					op_option_1 = _new_op_option_1;
					op_length_1 = array_length(op_option_1);
				}
				global.sub_menu++;
				audio_play_sound(sfx_select,9,false);
			}
		}
		if bkey && !key_cooldown[0]
		{
			key_cooldown[0]=1;
			menu_cloes = true;
			audio_play_sound(sfx_deselect,9,false);
		}
	}
	
	if global.sub_menu == 2 && menu_anm <= 2 && menu_cloes == false
	{
		//切换选项
		pos_1 += dpkey - upkey;
		if dpkey || upkey
		{
			audio_play_sound(sfx_click,9,false);
		}
	
		if pos_1 >= op_length_1
		{
			pos_1=0;
		}
		if pos_1 < 0
		{
			pos_1 = op_length_1-1;
		}

		if bkey && !key_cooldown[0]
		{
			key_cooldown[0]=1;
			global.sub_menu--;
			pos_1 = 0;
			audio_play_sound(sfx_deselect,9,false);
		}

		//应用选项
		if akey && !key_cooldown[0]
		{
			key_cooldown[0]=1;
			global.sub_menu++;
			audio_play_sound(sfx_select,9,false);
		}
	}
	
	if global.sub_menu == 3 && menu_anm <= 2 && menu_cloes == false
	{
		//切换选项
		pos_2 += rpkey - lpkey;
		if rpkey || lpkey
		{
			audio_play_sound(sfx_click,9,false);
		}
	
		if pos_2 >= op_length_2
		{
			pos_2=0;
		}
		if pos_2 < 0
		{
			pos_2 = op_length_2-1;
		}

		if bkey && !key_cooldown[0]
		{
			key_cooldown[0]=1;
			global.sub_menu--;
			pos_2 = 1;
			audio_play_sound(sfx_deselect,9,false);
		}

		//应用选项
		if akey && !key_cooldown[0]
		{
			key_cooldown[0]=1;
			if op_option_2[pos_2] == "确认"
			{
				switch(op_option_1[pos_1])
				{
				case "保存":	
					if (!(room_get_name(room)=="room_TITLE") && !(room_get_name(room)=="room_game_over") && !global.noresting)
					{
						audio_play_sound(sfx_select,9,false);
						scr_saving(pos+scroll_a);
						pos_2 = 1;
						pos_1 = 0;
						global.sub_menu = 1;
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
								op_option[i] = "存档"+string(i)+" 空";
							}
						}
					}
					else
					{
						audio_play_sound(sfx_deselect,9,false);
						if global.noresting
						{
							create_msg_box("nosaving");
						}
					}
					break;
				case "读取":
					if op_option[pos+scroll_a] != "存档"+string(pos+scroll_a)+" 空"
					{	
						audio_play_sound(sfx_select,9,false);
						roomgoto = true;
						global.warping = 1;
						global.bgm = 0;
						instance_create_layer(x,y,"Instances",obj_warp_anm);
					}
					else
					{
						audio_play_sound(sfx_deselect,9,false);
					}
					break;
				case "删除":
					audio_play_sound(sfx_select,9,false);
					file_delete("savedata"+string(pos+scroll_a)+".sav")
					file_delete("savescreen"+string(pos+scroll_a)+".png")
					pos_2 = 1;
					pos_1 = 0;
					global.sub_menu = 1;
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
							op_option[i] = "存档"+string(i)+" 空";
						}
					}
					break;
				}
			}
			else
			{
				global.sub_menu--;
				pos_2 = 1;
				audio_play_sound(sfx_deselect,9,false);
			}
		}
	}
}

if menu_cloes = false
{
	if menu_anm > 0
	{
		menu_anm/=4;
	}
}
else
{
	if menu_anm < 800
	{
		menu_anm*=8;
	}
	else
	{
		instance_destroy(self);
	}
}

if roomgoto && global.warping == 2
{
	global.pause = false;
	global.sub_menu = 0;
	global.gamestart = false;
	global.gameload = true;
	global.savef = pos+scroll_a;
	instance_destroy(obj_player);
	instance_destroy(obj_partner);
	instance_destroy(obj_allways);
	instance_destroy(obj_charsatus);
	instance_destroy(obj_item_manager);
	reroomsatus();
	room_goto(room_TEST_1);
	instance_destroy(self);
}
