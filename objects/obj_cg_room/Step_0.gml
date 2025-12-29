if !roomgoto
{
	//切换选项
	pos += dpkey - upkey;
	if dpkey || upkey
	{
		audio_play_sound(sfx_click,9,false);
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

	//应用选项
	if akey && !key_cooldown[0]
	{
		key_cooldown[0]=1;
		switch(pos)
		{
		case 0:
			//音乐
			audio_play_sound(sfx_select,9,false);
			break;
		case 1:
			//回想
			audio_play_sound(sfx_select,9,false);
			break;
		case 2:
			//返回
			audio_play_sound(sfx_deselect,9,false);
			roomgoto = true;
			global.warping = 1;
			instance_create_layer(x,y,"Instances",obj_warp_anm);
			break;
		}
	}
	//返回
	if bkey && !key_cooldown[0]
	{
		key_cooldown[0]=1;
		if pos != 2
		{
			pos = 2;
			audio_play_sound(sfx_deselect,9,false);
		}
		else
		{
			audio_play_sound(sfx_deselect,9,false);
			roomgoto = true;
			global.warping = 1;
			instance_create_layer(x,y,"Instances",obj_warp_anm);
		}
	}
}

if roomgoto && global.warping == 2
{
	switch(pos)
	{
	case 0:
		//音乐
		break;
	case 1:
		//回想
		break;
	case 2:
		//返回
		room_goto(room_TITLE);
		break;
	}
}