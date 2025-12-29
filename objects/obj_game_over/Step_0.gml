if !roomgoto && global.sub_menu == 0
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

	//应用选项
	if akey && !key_cooldown[0]
	{
		key_cooldown[0]=1;
		switch(pos)
		{
		case 0:
			//读取存档
			audio_play_sound(sfx_select,9,false);
			instance_create_layer(x,y,"Instances",obj_menu_loading);
			break;
		case 1:
			//返回主菜单
			audio_play_sound(sfx_select,9,false);
			roomgoto = true;
			global.warping = 1;
			instance_create_layer(x,y,"Instances",obj_warp_anm);
			break;
		}
	}
}

if roomgoto && global.warping == 2
{
	switch(pos)
	{
	case 0:
		//读取存档
		break;
	case 1:
		//返回主菜单
		game_restart();
		break;
	}
}