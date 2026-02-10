if global.sub_menu == 3 && global.talking != true && menu_anm <= 2 && menu_cloes == false
{
	//切换选项
	pos += upkey - dpkey;
	if upkey || dpkey
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
	
	pos_chara = global.player[pos];
	
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
		
		switch(pos)
		{
		case 0:
			//角色1
			if(u_scr!=undefined)
			{
				script_execute(u_scr);
			}
			else
			{
				if ds_grid_get(inventory,DS_INVENTORY.AMOUNT,item_pos+item_scroll_a)==1
				{
					menu_cloes = true;
				}
				scr_useitem();
			}
			break;
		case 1:	
			//角色2
			if(u_scr!=undefined)
			{
				script_execute(u_scr);
			}
			else
			{
				if ds_grid_get(inventory,DS_INVENTORY.AMOUNT,item_pos+item_scroll_a)==1
				{
					menu_cloes = true;
				}
				scr_useitem();
			}
			break;
		}
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