var _e_slot_index = e_pos_row * 2 + e_pos_col;
var _e_slot_is_empty = false;
var _chara = load_chara(global.player[menu_level]);
var _change_e_id = 0;
var _slot_map = [
	_chara.main_h,
	_chara.sec_h,
	_chara.armor,
	_chara.accessoryA,
	_chara.accessoryB,
	_chara.accessoryC
];

if(menu_anm <= 2 && menu_cloes == false)
{
	//人物子菜单
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
	else if global.sub_menu >= 2 && global.talking != true
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
	        if akey && !key_cooldown[0]
			{
				key_cooldown[0]=1;
				var _can_enter = true;
				//判断主副手冲突
				if(_e_slot_index==1)
				{
					if(_chara.main_h != 0 && _chara.main_h.equip_parts == 0)
					{
						_can_enter = false;
					}
				}
				
				if(_can_enter)
				{
					//确认当前槽是否为空
					_e_slot_is_empty = (_slot_map[_e_slot_index] == 0);
					
					if _e_slot_is_empty
					{
						if !equip_empty
					    {
							//切换到装备选择界面
							global.sub_menu+=2;
							audio_play_sound(sfx_select, 9, false);
						}
						else
						{
							audio_play_sound(sfx_deselect, 9, false);
						}
					}
					else
					{
						//切换卸下还是切换
						global.sub_menu++;
						audio_play_sound(sfx_select, 9, false);
					}
				}
				else
				{
					audio_play_sound(sfx_deselect, 9, false);
				}
			}
		}
		//部位选择子菜单
		if global.sub_menu == 3
		{
			if equip_empty
			{
				var _new_op_option_slot_eq = [
					MENU_EQUIPMENT_SLOT.UNEQUIP,
					MENU_EQUIPMENT_SLOT.DISCARD
				];
				op_option_slot_eq = _new_op_option_slot_eq;
				op_length_slot_eq = array_length(op_option_slot_eq);
			}
			else
			{
				var _new_op_option_slot_eq = [
					MENU_EQUIPMENT_SLOT.UNEQUIP,
					MENU_EQUIPMENT_SLOT.SWITCH,
					MENU_EQUIPMENT_SLOT.DISCARD
				];
				op_option_slot_eq = _new_op_option_slot_eq;
				op_length_slot_eq = array_length(op_option_slot_eq);
			}
			//切换选项
			if op_length_slot_eq > 1
			{
				pos_slot_eq += dpkey - upkey;
				if dpkey || upkey
				{
					audio_play_sound(sfx_click,9,false);
				}
				if pos_slot_eq >= op_length_slot_eq
				{
					pos_slot_eq=0;
				}
				if pos_slot_eq < 0
				{
					pos_slot_eq = op_length_slot_eq-1;
				}
			}
			//应用选项
			if akey && !key_cooldown[0]
			{
				switch(op_option_slot_eq[pos_slot_eq])
				{
				case MENU_EQUIPMENT_SLOT.UNEQUIP:
					//卸下装备
					if (_slot_map[_e_slot_index] != 0)
					{
						_change_e_id = _slot_map[_e_slot_index].e_id;
						add_equipment_id(_change_e_id, 1);
						equipmentEND = min(ds_grid_height(equipment),10);
					}
					apply_equipment(_chara,_e_slot_index,0);
					global.sub_menu=2;
					break;
				case MENU_EQUIPMENT_SLOT.SWITCH:
					//切换装备
					global.sub_menu=4;
					break;
				case MENU_EQUIPMENT_SLOT.DISCARD:
					//丢弃装备
					if get_equipped_item(_chara, _e_slot_index).discardable!=1
					{
						create_msg_box("undiscardable");
					}
					else
					{
						apply_equipment(_chara,_e_slot_index,0);
					}
					pos_slot_eq = 0;
					global.sub_menu=2;
					break;
				}
				audio_play_sound(sfx_select, 9, false);
				key_cooldown[0]=1;
			}
		}
		//装备背包菜单
		if global.sub_menu == 4
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
		if global.sub_menu == 5
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
				switch(op_option_eq[pos_eq])
				{
				case MENU_EQUIPMENT_INTERFACE.EQUIP:
					if (!can_equipment_to_slot(_equipment, _e_slot_index, _chara))
				    {
				        audio_play_sound(sfx_deselect, 9, false);
				        break;
				    }
					//装备
					//记录旧装备
					var _old_equip = _slot_map[_e_slot_index];
					//如果有旧装备则记录id
					if (_old_equip != 0)
					{
						_change_e_id = _old_equip.e_id;
					}
					//去掉背包内的物品
					scr_discard_equipment();
					//写入装备槽
					apply_equipment(_chara, _e_slot_index, _equipment);
					//如果有旧装备则加回背包
					if (_old_equip != 0)
					{
						add_equipment_id(_change_e_id, 1);
					}

					audio_play_sound(sfx_select,9,false);
					global.sub_menu-=3;
					equip_pos = 0;
					equip_scroll_a = 0;
					equipmentEND = min(ds_grid_height(equipment),10);
					break;
				case MENU_EQUIPMENT_INTERFACE.DISCARD:
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
							global.sub_menu-=2;
							pos_slot_eq = 0;
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
			if global.sub_menu==2
			{
				equip_pos = 0;
				equip_scroll_a = 0;
				equipmentEND = min(ds_grid_height(equipment),10);
				e_pos_row = 0;
				e_pos_col = 0;
			}
			if global.sub_menu==4
			{
				global.sub_menu--;
			}
			global.sub_menu--;
			sort = 0;
			pos_eq = 0;
			pos_slot_eq = 0;
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