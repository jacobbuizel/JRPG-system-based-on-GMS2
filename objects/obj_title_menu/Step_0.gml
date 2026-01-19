if !roomgoto && global.sub_menu == 0
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
			//开始游戏
			audio_play_sound(sfx_select,9,false);
			roomgoto = true;
			global.warping = 1;
			global.bgm = 0;
			instance_create_layer(x,y,"Instances",obj_warp_anm);
			break;
		case 1:
			//继续游戏
			audio_play_sound(sfx_select,9,false);
			instance_create_layer(x,y,"Instances",obj_menu_loading);
			break;
		case 2:
			//回想屋
			audio_play_sound(sfx_select,9,false);
			roomgoto = true;
			global.warping = 1;
			instance_create_layer(x,y,"Instances",obj_warp_anm);
			break;
		case 3:
			//设置
			audio_play_sound(sfx_select,9,false);
			instance_create_layer(x,y,"Instances",obj_menu_setting);
			break;
		case 4:
			//退出游戏
			audio_play_sound(sfx_select,9,false);
			roomgoto = true;
			global.warping = 1;
			global.bgm = 0;
			instance_create_layer(x,y,"Instances",obj_warp_anm);
			break;
		}
	}
	//返回
	if bkey && !key_cooldown[0]
	{
		key_cooldown[0]=1;
		pos = 4;
		audio_play_sound(sfx_deselect,9,false);
	}
}

if roomgoto && global.warping == 2
{
	switch(pos)
	{
	case 0:
		//开始游戏
		global.gamestart = false;
		global.gameload = false;
		reroomsatus();
		room_goto(room_TEST_1);
		break;
	case 1:
		//继续游戏
		break;
	case 2:
		//回想屋
		room_goto(room_CG);
		break;
	case 3:
		//设置 - 保持在标题画面，不跳转
		roomgoto = false;
		break;
	case 4:
		//退出游戏
		game_end();
		break;
	}
}