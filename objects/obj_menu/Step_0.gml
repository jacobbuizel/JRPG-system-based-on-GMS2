op_length = array_length(op_option[menu_level]);

if global.sub_menu == 0 && menu_anm <= 2 && menu_cloes == false
{
	//切换选项
	pos += rpkey - lpkey;
	if rpkey || lpkey
	{
		audio_play_sound(sfx_click,9,false);
	}
	
	if rkey && lkey
	{
		wait_time=30;
	}
	if rkey || lkey
	{
		if wait_time > 0
		{
			wait_time--;
		}
	}
	else wait_time=30;
	if wait_time <= 0
	{
		pos += rkey - lkey;
		if !(rkey&&lkey)
		{
			audio_play_sound(sfx_click,9,false);
		}
		wait_time = 5;
	}

	if pos >= op_length
	{
		pos=0;
	}
	if pos < 0
	{
		pos = op_length-1;
	}

	if bkey
	{
		{
			audio_play_sound(sfx_select,9,false);
			menu_cloes = true;
		}
	}

	//应用选项
	if akey
	{
		var _sml = menu_level;
		switch(pos)
		{
		case 0:
			//返回游戏
			alarm[0]=1;
			break;
		case 1:
			//背包
			alarm[0]=1;
			break;
		case 2:
			//人物状态
			alarm[0]=1;
			break;
		case 3:
			//武器&防具
			alarm[0]=1;
			break;
		case 4:
			//技能&法术
			alarm[0]=1;
			break;
		case 5:
			//日志
			alarm[0]=1;
			break;
		case 6:
			//休息
			alarm[0]=1;
			break;
		case 7:
			//设置
			alarm[0]=1;
			break;
		case 8:
			//保存
			alarm[0]=1;
			break;
		case 9:
			//退出游戏
			alarm[0]=1;
			break;
		}
		if _sml != menu_level
		{
			pos = 0;
		}
		op_length = array_length(op_option[menu_level]);
	}
}
if menu_cloes = false
{
	if menu_anm > 0
	{
		menu_anm/=2;
	}
}
else
{
	if menu_anm < 100
	{
		menu_anm*=4;
	}
	else
	{
		instance_destroy(self);
	}
}