//人物子菜单
if global.sub_menu == 1 && global.talking != true && menu_anm <= 2 && menu_cloes == false
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
		switch(pos)
		{
		case 0:
			//罗琳
			menu_level = 0;
			break;
		case 1:	
			//丝诺
			menu_level = 1;
			break;
		}
	}
}
//装备栏子菜单
else if global.sub_menu >= 2 && global.talking != true && menu_anm <= 2 && menu_cloes == false
{
	//部位选择菜单
	if global.sub_menu == 2
	{
		//切换部位
		e_pos_row += dpkey - upkey;
        e_pos_col += lpkey - rpkey;
		
		//音效
		if dpkey || upkey || rpkey || lpkey
		{
			audio_play_sound(sfx_click,9,false);
		}
		
		//确保部位选择框在合法范围内
        if (e_pos_row >= 3) e_pos_row = 0;
        if (e_pos_row < 0) e_pos_row = 2;
        if (e_pos_col >= 2) e_pos_col = 0;
        if (e_pos_col < 0) e_pos_col = 1;
		
		//确认键（选择装备部位）
        if akey && !equip_empty && !key_cooldown[0]
		{
			key_cooldown[0]=1;
            //切换到装备选择界面
            audio_play_sound(sfx_select, 9, false);
			global.sub_menu++;
        }
	}
	//装备背包菜单
	if global.sub_menu == 3
	{
		//切换选项
		if(ds_grid_height(equipment)>1)
		{
			if xkey
			{
				//背包整理
				if sort == 0 || sort == 2
				{
					audio_play_sound(sfx_click,9,false);
					ds_grid_sort(equipment,2,true);
					sort = 1;
				}
				else if sort == 1
				{
					audio_play_sound(sfx_click,9,false);
					ds_grid_sort(equipment,2,false);
					sort = 2;
				}
			}
			
			//上下移动单格物品选框
			equip_pos += dpkey - upkey;
			//右键一次跳5行
			if rpkey
			{
				scr_menu_movement_jump(id,"equip_pos","equip_scroll_a",ds_grid_height(equipment),equipmentEND,5,1,1);
			}
			//左键一次跳5行
			if lpkey
			{
			    scr_menu_movement_jump(id,"equip_pos","equip_scroll_a",ds_grid_height(equipment),equipmentEND,5,0,1);
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
				equip_pos += dkey - ukey;
				//右键一次跳5行
				if rkey
				{
					scr_menu_movement_jump(id,"equip_pos","equip_scroll_a",ds_grid_height(equipment),equipmentEND,5,1,1);
				}
				//左键一次跳5行
				if lkey
				{
				    scr_menu_movement_jump(id,"equip_pos","equip_scroll_a",ds_grid_height(equipment),equipmentEND,5,0,1);
				}
				if !(_pressed_count >= 2)
				{
					audio_play_sound(sfx_click,9,false);
				}
				wait_time = 5;
			}
        }
		
		//保持选框在合法范围
		if equip_pos >= equipmentEND
		{
			if equipmentEND+equip_scroll_a < ds_grid_height(equipment)
			{
				equip_scroll_a++;
				equip_pos=equipmentEND-1;
			}
			else
			{
				equip_scroll_a = 0;
				equip_pos = 0;
			}
		}
		if equip_pos < 0
		{
			if equip_scroll_a > 0
			{
				equip_scroll_a--;
				equip_pos = 0;
			}
			else
			{
				equip_scroll_a = ds_grid_height(equipment) - equipmentEND;
				equip_pos = equipmentEND-1;
			}
		}
		
		//选择物品
		if akey && !key_cooldown[0]
		{
			key_cooldown[0]=1;
			audio_play_sound(sfx_select,9,false);
			global.sub_menu++;
		}
	}
	//选中物品
	if global.sub_menu == 4
	{
		//切换选项
		pos_eq += dpkey - upkey;
		if dpkey || upkey
		{
			audio_play_sound(sfx_click,9,false);
		}
	
		if pos_eq >= op_length_eq
		{
			pos_eq=0;
		}
		if pos_eq < 0
		{
			pos_eq = op_length_eq-1;
		}

		//应用选项
		if akey && !key_cooldown[0]
		{
			key_cooldown[0]=1;
			var _equipment = load_equipment(equip_pos+equip_scroll_a);
			switch(pos_eq)
			{
			case 0:
				//装备
				audio_play_sound(sfx_select,9,false);
				global.sub_menu-=2;
				break;
			case 1:
				//丢弃
				audio_play_sound(sfx_select,9,false);
				//判断是否可丢弃
				if _equipment.discardable!=1
				{
					create_msg_box("undiscardable");
					global.sub_menu--;
					pos_eq = 0;
				}
				else
				{
					scr_discard_equipment();
					if equip_empty
					{
						global.sub_menu--;
					}
					global.sub_menu--;
					pos_eq = 0;
				}
				break;
			}
		}
	}
	//关闭菜单
	if bkey && !key_cooldown[0]
	{
		key_cooldown[0]=1;
		audio_play_sound(sfx_deselect,9,false);
		global.sub_menu--;
		pos_eq = 0;
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