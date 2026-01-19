op_length = array_length(op_option[menu_level]);

if global.sub_menu == 1 && menu_wait==0
{
	//切换选项
	pos += dpkey - upkey;
	if dpkey || upkey
	{
		audio_play_sound(sfx_click,9,false);
	}
	
	if ukey && dkey
	{
		wait_time=30;
	}
	if ukey || dkey
	{
		if wait_time > 0
		{
			wait_time--;
		}
	}
	else wait_time=30;
	if wait_time <= 0
	{
		pos += dkey - ukey;
		if !(dkey&&ukey)
		{
			audio_play_sound(sfx_click,9,false);
		}
		wait_time = 5;
	}

	if pos >= op_length
	{
		pos = 0;
	}
	if pos < 0
	{
		pos = op_length-1;
	}

	if bkey && !key_cooldown[0]
	{
		key_cooldown[0]=1;
		audio_play_sound(sfx_deselect,9,false);
		if menu_level <= 0
		{
			instance_destroy(self);
		}
		else
		{
			switch menu_level
			{
				case 1:
					menu_level--;
					pos = 0;
					op_length = array_length(op_option[menu_level]);
					break;
				case 2:
					menu_level--;
					pos = 0;
					op_length = array_length(op_option[menu_level]);
					break;
			}
		}
	}

	//应用选项
	if akey && !key_cooldown[0]
	{
		scr_setting_save();
		key_cooldown[0]=1;
		var _sml = menu_level;
		switch(menu_level)
		{
		case 0:
			audio_play_sound(sfx_select,9,false);
			switch(pos)
			{
			case 0:
				//声音
				menu_level = 1;
				break;
			case 1:
				//自动奔跑
				if global.auto_run
				{
					global.auto_run = false;
					op_option[0,1] = "自动奔跑:关";
				}
				else
				{
					global.auto_run = true;
					op_option[0,1] = "自动奔跑:开";
				}
				break;
			case 2:
				//高级设置
				break;
			case 3:
				//返回
				instance_destroy(self);
				break;
			}
			break;
		case 1:
			audio_play_sound(sfx_select,9,false);
			switch(pos)
			{
			case 0:
				//BGM大小
				op_snd = 1;
				menu_level = 2;
				break;
			case 1:
				//SFX大小
				op_snd = 2;
				menu_level = 2;
				break;
			case 2:
				//BGS大小
				op_snd = 3;
				menu_level = 2;
				break;
			case 3:
				//返回
				menu_level = 0;
				break;
			}
			break;
		case 2:
			audio_play_sound(sfx_select,9,false);
			switch(pos)
			{
				case 0:
					//100%
					if op_snd == 1
					{
						global.bgm_v = 1;
						audio_group_set_gain(audiogroup_BGM,global.bgm_v,0);
					}
					if op_snd == 2
					{
						global.sfx_v = 1;
						audio_group_set_gain(audiogroup_SFX,global.sfx_v,0);
					}
					if op_snd == 3
					{
						global.bgs_v = 1;
						audio_group_set_gain(audiogroup_BGS,global.bgs_v,0);
					}
					break;
				case 1:
					//80%
					if op_snd == 1
					{
						global.bgm_v = 0.8;
						audio_group_set_gain(audiogroup_BGM,global.bgm_v,0);
					}
					if op_snd == 2
					{
						global.sfx_v = 0.8;
						audio_group_set_gain(audiogroup_SFX,global.sfx_v,0);
					}
					if op_snd == 3
					{
						global.bgs_v = 0.8;
						audio_group_set_gain(audiogroup_BGS,global.bgs_v,0);
					}
					break;
				case 2:
					//60%
					if op_snd == 1
					{
						global.bgm_v = 0.6;
						audio_group_set_gain(audiogroup_BGM,global.bgm_v,0);
					}
					if op_snd == 2
					{
						global.sfx_v = 0.6;
						audio_group_set_gain(audiogroup_SFX,global.sfx_v,0);
					}
					if op_snd == 3
					{
						global.bgs_v = 0.6;
						audio_group_set_gain(audiogroup_BGS,global.bgs_v,0);
					}
					break;
				case 3:
					//40%
					if op_snd == 1
					{
						global.bgm_v = 0.4;
						audio_group_set_gain(audiogroup_BGM,global.bgm_v,0);
					}
					if op_snd == 2
					{
						global.sfx_v = 0.4;
						audio_group_set_gain(audiogroup_SFX,global.sfx_v,0);
					}
					if op_snd == 3
					{
						global.bgs_v = 0.4;
						audio_group_set_gain(audiogroup_BGS,global.bgs_v,0);
					}
					break;
				case 4:
					//20%
					if op_snd == 1
					{
						global.bgm_v = 0.2;
						audio_group_set_gain(audiogroup_BGM,global.bgm_v,0);
					}
					if op_snd == 2
					{
						global.sfx_v = 0.2;
						audio_group_set_gain(audiogroup_SFX,global.sfx_v,0);
					}
					if op_snd == 3
					{
						global.bgs_v = 0.2;
						audio_group_set_gain(audiogroup_BGS,global.bgs_v,0);
					}
					break;
				case 5:
					//关
					if op_snd == 1
					{
						global.bgm_v = 0;
						audio_group_set_gain(audiogroup_BGM,global.bgm_v,0);
					}
					if op_snd == 2
					{
						global.sfx_v = 0;
						audio_group_set_gain(audiogroup_SFX,global.sfx_v,0);
					}
					if op_snd == 3
					{
						global.bgs_v = 0;
						audio_group_set_gain(audiogroup_BGS,global.bgs_v,0);
					}
					break;
				case 6:
					//返回
						menu_level = 1;
					break;
				}
			break;
		}
		if _sml != menu_level
		{
			pos = 0;
		}
		op_length = array_length(op_option[menu_level]);
	}
}

if menu_wait
{
	menu_wait--
}