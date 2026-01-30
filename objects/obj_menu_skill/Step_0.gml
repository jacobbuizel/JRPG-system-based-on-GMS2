if menu_anm <= 2 && menu_cloes == false
{
	//角色选择子菜单
	if global.sub_menu == 1 && global.talking != true
	{
		//切换选项
		pos += dpkey - upkey;
		if dpkey || upkey
		{
			audio_play_sound(sfx_click,9,false);
		}

		if pos >= op_length
		{
			pos=0;
		}
		if pos < 0
		{
			pos = op_length-1;
		}

		if bkey && !key_cooldown[0]
		{
			key_cooldown[0]=1;
			menu_cloes = true;
			audio_play_sound(sfx_deselect,9,false);
		}

		//应用选项
		if akey && !key_cooldown[0]
		{
			key_cooldown[0]=1;
			audio_play_sound(sfx_select,9,false);
			global.sub_menu = 2;
			menu_level = pos;
			//初始化技能列表
			var _chara = load_chara(global.player[menu_level]);
			if (ds_grid_get(_chara.skill_list, 0, 0) != 0)
			{
				skillEND = min(ds_grid_height(_chara.skill_list), 10);
				skill_empty = false;
			}
			else
			{
				skillEND = 0;
				skill_empty = true;
			}
			skill_pos = 0;
			skill_scroll_a = 0;
		}
	}
	//技能列表子菜单
	else if global.sub_menu == 2 && global.talking != true
	{
		if !skill_empty
		{
			//切换选项
			if(ds_grid_height(load_chara(global.player[menu_level]).skill_list)>1)
			{
				//上下移动技能选框
				skill_pos += dpkey - upkey;
				//右键一次跳5行
				if rpkey
				{
					var _chara = load_chara(global.player[menu_level]);
					scr_menu_movement_jump(id, "skill_pos", "skill_scroll_a", ds_grid_height(_chara.skill_list), skillEND, 5, 1, 1);
				}
				//左键一次跳5行
				if lpkey
				{
					var _chara = load_chara(global.player[menu_level]);
					scr_menu_movement_jump(id, "skill_pos", "skill_scroll_a", ds_grid_height(_chara.skill_list), skillEND, 5, 0, 1);
				}

				//音效
				if dpkey || upkey || rpkey || lpkey
				{
					audio_play_sound(sfx_click,9,false);
				}

				// 互斥键处理
				var _dir_keys = [ukey,dkey,lkey,rkey];
				var _pressed_count = 0;
				for (var i = 0; i < array_length(_dir_keys); i++)
				{
					if (_dir_keys[i])
					{
						_pressed_count++;
					}
				}
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
					skill_pos += dkey - ukey;
					var _chara = load_chara(global.player[menu_level]);
					//右键一次跳5行
					if rkey
					{
						scr_menu_movement_jump(id, "skill_pos", "skill_scroll_a", ds_grid_height(_chara.skill_list), skillEND, 5, 1, 1);
					}
					//左键一次跳5行
					if lkey
					{
						scr_menu_movement_jump(id, "skill_pos", "skill_scroll_a", ds_grid_height(_chara.skill_list), skillEND, 5, 0, 1);
					}
					if !(_pressed_count >= 2)
					{
						audio_play_sound(sfx_click,9,false);
					}
					wait_time = 5;
				}
			}

			//保持选框在合法范围
			if skill_pos >= skillEND
			{
				var _chara = load_chara(global.player[menu_level]);
				if skillEND + skill_scroll_a < ds_grid_height(_chara.skill_list)
				{
					skill_scroll_a++;
					skill_pos = skillEND - 1;
				}
				else
				{
					skill_scroll_a = 0;
					skill_pos = 0;
				}
			}
			if skill_pos < 0
			{
				var _chara = load_chara(global.player[menu_level]);
				if skill_scroll_a > 0
				{
					skill_scroll_a--;
					skill_pos = 0;
				}
				else
				{
					skill_scroll_a = ds_grid_height(_chara.skill_list) - skillEND;
					skill_pos = skillEND - 1;
				}
			}

			//选择技能
			if akey && !key_cooldown[0]
			{
				key_cooldown[0]=1;
				global.sub_menu = 3;
				pos_skill = 0;
				audio_play_sound(sfx_select,9,false);
			}
		}

		//返回角色选择
		if bkey && !key_cooldown[0]
		{
			key_cooldown[0]=1;
			global.sub_menu = 1;
			pos = 0;
			audio_play_sound(sfx_deselect,9,false);
		}
	}
	//技能确认子菜单
	else if global.sub_menu == 3 && global.talking != true
	{
		//切换选项
		pos_skill += dpkey - upkey;
		if dpkey || upkey
		{
			audio_play_sound(sfx_click,9,false);
		}

		if pos_skill >= op_skill_length
		{
			pos_skill = 0;
		}
		if pos_skill < 0
		{
			pos_skill = op_skill_length - 1;
		}

		//确认选项
		if akey && !key_cooldown[0]
		{
			key_cooldown[0]=1;
			if pos_skill == 1 || pos_skill == 0
			{
				//取消 - 返回技能列表
				if pos_skill == 1
				{
					audio_play_sound(sfx_deselect,9,false);
					global.sub_menu = 2;
					pos_skill = 0;
				}
				//施展 - 先做交互，之后再做功能
				else
				{
					audio_play_sound(sfx_select,9,false);
					// TODO: 实现技能施展功能
					// 这里暂时显示一个消息框提示
					create_msg_box("skill_use");
					global.sub_menu = 2;
					pos_skill = 0;
				}
			}
		}

		//取消返回技能列表
		if bkey && !key_cooldown[0]
		{
			key_cooldown[0]=1;
			global.sub_menu = 2;
			pos_skill = 0;
			audio_play_sound(sfx_deselect,9,false);
		}
	}
}

//菜单动画控制
if menu_cloes == false
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