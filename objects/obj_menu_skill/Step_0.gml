var _chara_id = global.player[menu_level];
var _chara = load_chara(_chara_id);
var _list_grid = (skill_tab == 1) ? _chara.spellbook_list : _chara.skill_list;

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
			pos = 0;
		}
		if pos < 0
		{
			pos = op_length - 1;
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
			skill_tab = 0;
			skill_pos = 0;
			skill_scroll_a = 0;
			//初始化技能列表
			_chara = load_chara(global.player[menu_level]);
			_list_grid = _chara.skill_list;
			if (ds_grid_get(_list_grid, 0, 0) != 0)
			{
				skillEND = min(ds_grid_height(_list_grid), 10);
				skill_empty = false;
			}
			else
			{
				skillEND = 0;
				skill_empty = true;
			}
		}
	}
	//技能列表子菜单
	else if global.sub_menu == 2 && global.talking != true
	{
		//列表初始化
		_chara = load_chara(global.player[menu_level]);
		_list_grid = (skill_tab == 1) ? _chara.spellbook_list : _chara.skill_list;
		
		if xkey
		{
			if _chara.class_id == 11
			{
				skill_tab = 1 - skill_tab;
				skill_pos = 0;
				skill_scroll_a = 0;
				audio_play_sound(sfx_click,9,false);
				_list_grid = (skill_tab == 1) ? _chara.spellbook_list : _chara.skill_list;
			}
			else
			{
				audio_play_sound(sfx_deselect,9,false);
			}
		}
		
		if (ds_grid_get(_list_grid, 0, 0) != 0)
		{
			skillEND = min(ds_grid_height(_list_grid), 10);
			skill_empty = false;
		}
		else
		{
			skillEND = 0;
			skill_empty = true;
			skill_pos = 0;
			skill_scroll_a = 0;
		}
		
		if !skill_empty
		{
			//切换选项
			var _list_h = ds_grid_height(_list_grid);

			if _list_h > 1
			{
				skill_pos += dpkey - upkey;
				if rpkey
				{
					scr_menu_movement_jump(id, "skill_pos", "skill_scroll_a", _list_h, skillEND, 5, 1, 1);
				}
				if lpkey
				{
					scr_menu_movement_jump(id, "skill_pos", "skill_scroll_a", _list_h, skillEND, 5, 0, 1);
				}
				
				if dpkey || upkey || rpkey || lpkey
				{
					audio_play_sound(sfx_click,9,false);
				}
				
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
					if rkey
					{
						scr_menu_movement_jump(id, "skill_pos", "skill_scroll_a", _list_h, skillEND, 5, 1, 1);
					}
					if lkey
					{
						scr_menu_movement_jump(id, "skill_pos", "skill_scroll_a", _list_h, skillEND, 5, 0, 1);
					}
					if !(_pressed_count >= 2)
					{
						audio_play_sound(sfx_click,9,false);
					}
					wait_time = 5;
				}
			}
			
			if skill_pos >= skillEND
			{
				if skillEND + skill_scroll_a < _list_h
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
				if skill_scroll_a > 0
				{
					skill_scroll_a--;
					skill_pos = 0;
				}
				else
				{
					skill_scroll_a = _list_h - skillEND;
					skill_pos = skillEND - 1;
				}
			}
			//选择技能
			if akey && !key_cooldown[0]
			{
				key_cooldown[0]=1;
				if skill_tab == 0
				{
					global.sub_menu = 3;
					pos_skill = 0;
					audio_play_sound(sfx_select,9,false);
				}
				else
				{
					var _row = skill_pos + skill_scroll_a;
					var _spell = load_spell(_chara,_row);
					var _result = false;
					if _spell.is_enable
					{
						_result = set_spell_enable_by_row(_chara,_row,false);
					}
					else
					{
						_result = set_spell_enable_by_row(_chara,_row,true);
					}

					if _result
					{
						audio_play_sound(sfx_select,9,false);
					}
					else
					{
						audio_play_sound(sfx_deselect,9,false);
					}
				}
			}
		}
		
		if bkey && !key_cooldown[0]
		{
			key_cooldown[0]=1;
			global.sub_menu = 1;
			skill_tab = 0;
			audio_play_sound(sfx_deselect,9,false);
		}
	}
	//技能确认子菜单
	else if global.sub_menu == 3 && global.talking != true
	{
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

		if akey && !key_cooldown[0]
		{
			key_cooldown[0]=1;
			if pos_skill == 1 || pos_skill == 0
			{
				if pos_skill == 1
				{
					audio_play_sound(sfx_deselect,9,false);
					global.sub_menu = 2;
					pos_skill = 0;
				}
				else
				{
					_chara = load_chara(global.player[menu_level]);
					var _skill = load_skill(_chara,skill_pos+skill_scroll_a);
					audio_play_sound(sfx_select,9,false);
					apply_effect_list(_skill.scr,undefined);
					global.sub_menu = 2;
					pos_skill = 0;
				}
			}
		}

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