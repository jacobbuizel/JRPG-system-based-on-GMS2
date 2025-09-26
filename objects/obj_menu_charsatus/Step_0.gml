if global.sub_menu == 1 && menu_anm <= 2 && menu_cloes == false
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

	if bkey
	{
		menu_cloes = true;
		audio_play_sound(sfx_deselect,9,false);
	}

	//应用选项
	if akey
	{
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

if global.sub_menu == 2
{
	if bkey
	{
		global.sub_menu = 1;
		menu_level = 0;
		audio_play_sound(sfx_deselect,9,false);
	}
}
if menu_cloes = false
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