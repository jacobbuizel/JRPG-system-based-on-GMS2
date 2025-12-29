if global.sub_menu == 1
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
		pos=0;
	}
	if pos < 0
	{
		pos = op_length-1;
	}

	if bkey && !key_cooldown[0]
	{
		key_cooldown[0]=1;
		audio_play_sound(sfx_deselect,9,false);
		instance_destroy(self);
	}

	//应用选项
	if akey && !key_cooldown[0]
	{
		key_cooldown[0]=1;
		switch(pos)
		{
		case 0:	
			//返回主菜单
			audio_play_sound(sfx_select,9,false);
			roomgoto = 1;
			global.warping = 1;
			instance_create_layer(x,y,"Instances",obj_warp_anm);
			break;
		case 1:
			//返回桌面
			audio_play_sound(sfx_select,9,false);
			roomgoto = 2;
			global.warping = 1;
			instance_create_layer(x,y,"Instances",obj_warp_anm);
			break;
		}
	}
	if roomgoto != 0 && global.warping == 2
	{
		global.bgm = 0;
		if roomgoto == 1
		{
			game_restart();
		}
		if roomgoto == 2
		{
			game_end();
		}
	}
}