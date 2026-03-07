op_length = array_length(op_option);

if global.sub_menu == 1 && menu_wait == 0
{
	//切换选项
	var _move_v = dpkey - upkey;
	if ukey && dkey
	{
		wait_time_ud = 30;
	}
	if ukey || dkey
	{
		if wait_time_ud > 0
		{
			wait_time_ud--;
		}
	}
	else
	{
		wait_time_ud = 30;
	}
	if wait_time_ud <= 0
	{
		_move_v += dkey - ukey;
		wait_time_ud = 5;
	}
	if _move_v != 0
	{
		pos += _move_v;
		audio_play_sound(sfx_click, 9, false);
	}

	if pos >= op_length
	{
		pos = 0;
	}
	if pos < 0
	{
		pos = op_length - 1;
	}

	//切换音量滑块
	if pos <= 2
	{
		var _move_h = rpkey - lpkey;
		if rkey && lkey
		{
			wait_time_lr = 15;
		}
		if rkey || lkey
		{
			if wait_time_lr > 0
			{
				wait_time_lr--;
			}
		}
		else
		{
			wait_time_lr = 15;
		}
		if wait_time_lr <= 0
		{
			_move_h += rkey - lkey;
			wait_time_lr = 3;
		}

		if _move_h != 0
		{
			var _new_v;
			switch (pos)
			{
				case 0:
					_new_v = clamp(global.bgm_v + _move_h * 0.05, 0, 1);
					if abs(_new_v - global.bgm_v) > 0.0001
					{
						global.bgm_v = _new_v;
						audio_group_set_gain(audiogroup_BGM, global.bgm_v, 0);
						audio_play_sound(sfx_click, 9, false);
					}
					break;
				case 1:
					_new_v = clamp(global.sfx_v + _move_h * 0.05, 0, 1);
					if abs(_new_v - global.sfx_v) > 0.0001
					{
						global.sfx_v = _new_v;
						audio_group_set_gain(audiogroup_SFX, global.sfx_v, 0);
						audio_play_sound(sfx_click, 9, false);
					}
					break;
				case 2:
					_new_v = clamp(global.bgs_v + _move_h * 0.05, 0, 1);
					if abs(_new_v - global.bgs_v) > 0.0001
					{
						global.bgs_v = _new_v;
						audio_group_set_gain(audiogroup_BGS, global.bgs_v, 0);
						audio_play_sound(sfx_click, 9, false);
					}
					break;
			}
		}
	}
	else
	{
		wait_time_lr = 15;
	}

	var _auto_toggled_by_a = false;
	if akey && !key_cooldown[0]
	{
		key_cooldown[0] = 1;
		switch (pos)
		{
			case 3:
				global.auto_run = !global.auto_run;
				_auto_toggled_by_a = true;
				audio_play_sound(sfx_select, 9, false);
				break;
			case 4:
				global.bgm_v = 1;
				global.sfx_v = 1;
				global.bgs_v = 1;
				global.auto_run = false;
				audio_group_set_gain(audiogroup_BGM, global.bgm_v, 0);
				audio_group_set_gain(audiogroup_SFX, global.sfx_v, 0);
				audio_group_set_gain(audiogroup_BGS, global.bgs_v, 0);
				audio_play_sound(sfx_select, 9, false);
				break;
			case 5:
				audio_play_sound(sfx_select, 9, false);
				instance_destroy(self);
				break;
		}
	}

	//切换自动奔跑
	if pos == 3 && (rpkey || lpkey) && !_auto_toggled_by_a
	{
		global.auto_run = !global.auto_run;
		audio_play_sound(sfx_click, 9, false);
	}

	if bkey && !key_cooldown[0]
	{
		key_cooldown[0] = 1;
		audio_play_sound(sfx_deselect, 9, false);
		instance_destroy(self);
	}
}

if menu_wait > 0
{
	menu_wait--;
}