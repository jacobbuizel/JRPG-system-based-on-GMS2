if global.sub_menu == 1 && global.talking != true
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

	if bkey
	{
		alarm[0] = 1;
		audio_play_sound(sfx_deselect,9,false);
	}

	//应用选项
	if akey
	{
		switch(pos)
		{
		case 0:	
			//进行短休
			if !global.noresting
			{
				audio_play_sound(sfx_select,9,false);
				roomgoto = 1;
				global.warping = 1;
				instance_create_layer(x,y,"Instances",obj_warp_anm);
			}
			else
			{
				audio_play_sound(sfx_deselect,9,false);
				alarm[1] = 1;
			}
			break;
		case 1:
			//进行长休
			if !global.noresting
			{
				audio_play_sound(sfx_select,9,false);
				roomgoto = 2;
				global.warping = 1;
				instance_create_layer(x,y,"Instances",obj_warp_anm);
			}
			else
			{
				audio_play_sound(sfx_deselect,9,false);
				alarm[1] = 1;
			}
			break;
		}
	}
	if roomgoto != 0 && global.warping == 2
	{
		if roomgoto == 1
		{
			global.time_h ++;
			restor_roomsatus(-1);
			room_restart();
		}
		if roomgoto == 2
		{
			global.time_h += 8;
			restor_roomsatus(-1);
			restor_roomsatus(-1);
			restor_roomsatus(-1);
			restor_roomsatus(-1);
			room_restart();
		}
	}
}