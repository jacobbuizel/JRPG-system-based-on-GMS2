var _e_slot_index = e_pos_row * 2 + e_pos_col;
var _e_slot_is_empty = false;
var _chara = load_chara(global.player[menu_level]);
var _change_e_id = 0;

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
				//确认当前槽是否为空
				switch(_e_slot_index)
				{
					case 0://主手
						if _chara.main_h == 0
						{
							_e_slot_is_empty = true;
						}
						else
						{
							_e_slot_is_empty = false;
						}
						break;
					case 1://副手
						if _chara.sec_h == 0
						{
							_e_slot_is_empty = true;
						}
						else
						{
							_e_slot_is_empty = false;
						}
						break;
					case 2://护甲
						if _chara.armor == 0
						{
							_e_slot_is_empty = true;
						}
						else
						{
							_e_slot_is_empty = false;
						}
						break;
					case 3://配饰A
						if _chara.accessoryA == 0
						{
							_e_slot_is_empty = true;
						}
						else
						{
							_e_slot_is_empty = false;
						}
						break;
					case 4://配饰B
						if _chara.accessoryB == 0
						{
							_e_slot_is_empty = true;
						}
						else
						{
							_e_slot_is_empty = false;
						}
						break;
					case 5://配饰C
						if _chara.accessoryC == 0
						{
							_e_slot_is_empty = true;
						}
						else
						{
							_e_slot_is_empty = false;
						}
						break;
				}
				if _e_slot_is_empty
				{
					if !equip_empty
		            {
						//切换到装备选择界面
						global.sub_menu++;
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
					global.sub_menu=2.5;
					audio_play_sound(sfx_select, 9, false);
				}
	        }
		}
		//部位选择子菜单
		if global.sub_menu == 2.5
		{
			if equip_empty
			{
				var _new_op_option_slot_eq = [];
				_new_op_option_slot_eq[0] = "卸下";
				op_option_slot_eq = _new_op_option_slot_eq;
				op_length_slot_eq = array_length(op_option_slot_eq);
			}
			else
			{
				var _new_op_option_slot_eq = [];
				_new_op_option_slot_eq[0] = "卸下";
				_new_op_option_slot_eq[1] = "切换";
				op_option_slot_eq = _new_op_option_slot_eq;
				op_length_slot_eq = array_length(op_option_slot_eq);
				
				//切换选项
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
				show_debug_message("检测到按下A键");
				switch(pos_slot_eq)
				{
				case 0:
					//卸下
					switch(_e_slot_index)
					{
						case 0://主手
							_change_e_id = _chara.main_h.e_id;
							_chara.main_h=0;
							add_equipment_id(_change_e_id,1);
							show_debug_message("成功卸下装备0");
							break;
						case 1://副手
							_change_e_id = _chara.sec_h.e_id;
							_chara.sec_h=0;
							add_equipment_id(_change_e_id,1);
							show_debug_message("成功卸下装备1");
							break;
						case 2://护甲
							_change_e_id = _chara.armor.e_id;
							_chara.armor=0;
							add_equipment_id(_change_e_id,1);
							show_debug_message("成功卸下装备2");
							break;
						case 3://配饰A
							_change_e_id = _chara.accessoryA.e_id;
							_chara.accessoryA=0;
							add_equipment_id(_change_e_id,1);
							show_debug_message("成功卸下装备3");
							break;
						case 4://配饰B
							_change_e_id = _chara.accessoryB.e_id;
							_chara.accessoryB=0;
							add_equipment_id(_change_e_id,1);
							show_debug_message("成功卸下装备4");
							break;
						case 5://配饰C
							_change_e_id = _chara.accessoryC.e_id;
							_chara.accessoryC=0;
							add_equipment_id(_change_e_id,1);
							show_debug_message("成功卸下装备5");
							break;
					}
					global.sub_menu=2;
					break;
				case 1:
					//切换
					global.sub_menu=3;
					show_debug_message("成功进入切换界面");
					break;
				}
				audio_play_sound(sfx_select, 9, false);
				key_cooldown[0]=1;
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
					switch(_e_slot_index)
					{
						case 0://主手
							if _chara.main_h == 0
							{
								_chara.main_h=load_equipment(equip_pos+equip_scroll_a);
								scr_discard_equipment();
							}
							else
							{
								_change_e_id = _chara.main_h.e_id;
								_chara.main_h=load_equipment(equip_pos+equip_scroll_a);
								scr_discard_equipment();
								add_equipment_id(_change_e_id,1);
							}
							break;
						case 1://副手
							if _chara.sec_h == 0
							{
								_chara.sec_h=load_equipment(equip_pos+equip_scroll_a);
								scr_discard_equipment();
							}
							else
							{
								_change_e_id = _chara.sec_h.e_id;
								_chara.sec_h=load_equipment(equip_pos+equip_scroll_a);
								scr_discard_equipment();
								add_equipment_id(_change_e_id,1);
							}
							break;
						case 2://护甲
							if _chara.armor == 0
							{
								_chara.armor=load_equipment(equip_pos+equip_scroll_a);
								scr_discard_equipment();
							}
							else
							{
								_change_e_id = _chara.armor.e_id;
								_chara.armor=load_equipment(equip_pos+equip_scroll_a);
								scr_discard_equipment();
								add_equipment_id(_change_e_id,1);
							}
							break;
						case 3://配饰A
							if _chara.accessoryA == 0
							{
								_chara.accessoryA=load_equipment(equip_pos+equip_scroll_a);
								scr_discard_equipment();
							}
							else
							{
								_change_e_id = _chara.accessoryA.e_id;
								_chara.accessoryA=load_equipment(equip_pos+equip_scroll_a);
								scr_discard_equipment();
								add_equipment_id(_change_e_id,1);
							}
							break;
						case 4://配饰B
							if _chara.accessoryB == 0
							{
								_chara.accessoryB=load_equipment(equip_pos+equip_scroll_a);
								scr_discard_equipment();
							}
							else
							{
								_change_e_id = _chara.accessoryB.e_id;
								_chara.accessoryB=load_equipment(equip_pos+equip_scroll_a);
								scr_discard_equipment();
								add_equipment_id(_change_e_id,1);
							}
							break;
						case 5://配饰C
							if _chara.accessoryC == 0
							{
								_chara.accessoryC=load_equipment(equip_pos+equip_scroll_a);
								scr_discard_equipment();
							}
							else
							{
								_change_e_id = _chara.accessoryC.e_id;
								_chara.accessoryC=load_equipment(equip_pos+equip_scroll_a);
								scr_discard_equipment();
								add_equipment_id(_change_e_id,1);
							}
							break;
					}
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
			if global.sub_menu == 2.5
			{
				global.sub_menu=2;
			}
			else
			{
				if global.sub_menu==2
				{
					e_pos_row = 0;
					e_pos_col = 0;
				}
				global.sub_menu--;
			}
			sort = 0;
			pos_eq = 0;
			pos_slot_eq = 0;
		}
	}
}
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