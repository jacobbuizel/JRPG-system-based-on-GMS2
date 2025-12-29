if(ds_grid_get(inventory,0,0)!=0)
{
	inventoryEND = min(ds_grid_height(inventory),17);
	empty = false;
}

if(ds_grid_get(inventory,0,0)==0)
{
	inventoryEND = 0;
	empty = true;
}


if global.sub_menu == 1 && global.talking != true && menu_anm <= 2 && menu_cloes == false
{
	if !empty
	{
		//切换选项
		if(ds_grid_height(inventory)>1)
		{
			if xkey
			{
				//背包整理
				if sort == 0 || sort == 2
				{
					audio_play_sound(sfx_click,9,false);
					ds_grid_sort(inventory,2,true);
					sort = 1;
				}
				else if sort == 1
				{
					audio_play_sound(sfx_click,9,false);
					ds_grid_sort(inventory,2,false);
					sort = 2;
				}
			}
			
			//上下移动单格物品选框
			item_pos += dpkey - upkey;
			//右键一次跳5行
			if rpkey
			{
				scr_menu_movement_jump(id,"item_pos","item_scroll_a",ds_grid_height(inventory),inventoryEND,5,1,1);
			}
			//左键一次跳5行
			if lpkey
			{
			    scr_menu_movement_jump(id,"item_pos","item_scroll_a",ds_grid_height(inventory),inventoryEND,5,0,1);
			}
			
			//音效
			if dpkey || upkey || rpkey || lpkey
			{
				audio_play_sound(sfx_click,9,false);
			}
			
			// 把互斥键收集到一个数组或列表
			var _dir_keys = [ukey,dkey,lkey,rkey];

			// 统计按下了多少个互斥键
			var _pressed_count = 0;
			for (var i = 0; i < array_length(_dir_keys); i++)
			{
			    if (_dir_keys[i])
				{
					_pressed_count++;
				}
			}
			// 如果按下两个及以上，算互斥
			if (_pressed_count >= 2)
			{
			    wait_time = 30;
			}
			else if (_pressed_count == 1)
			{
			    if (wait_time > 0)
				{
					wait_time--;
				}
			}
			else
			{
			    wait_time = 30;
			}
			
			//长按快速切换选取
			if ukey || dkey || lkey || rkey
			{
				if wait_time > 0
				{
					wait_time--;
				}
			}
			else wait_time = 30;
			if wait_time <= 0
			{
				item_pos += dkey - ukey;
				//右键一次跳5行
				if rkey
				{
					scr_menu_movement_jump(id,"item_pos","item_scroll_a",ds_grid_height(inventory),inventoryEND,5,1,1);
				}
				//左键一次跳5行
				if lkey
				{
				    scr_menu_movement_jump(id,"item_pos","item_scroll_a",ds_grid_height(inventory),inventoryEND,5,0,1);
				}
				if !(_pressed_count >= 2)
				{
					audio_play_sound(sfx_click,9,false);
				}
				wait_time = 5;
			}
        }
		
		//保持选框在合法范围
		if item_pos >= inventoryEND
		{
			if inventoryEND+item_scroll_a < ds_grid_height(inventory)
			{
				item_scroll_a++;
				item_pos=inventoryEND-1;
			}
			else
			{
				item_scroll_a = 0;
				item_pos = 0;
			}
		}
		if item_pos < 0
		{
			if item_scroll_a > 0
			{
				item_scroll_a--;
				item_pos = 0;
			}
			else
			{
				item_scroll_a = ds_grid_height(inventory) - inventoryEND;
				item_pos = inventoryEND-1;
			}
		}
		
		//选择物品
		if akey && !key_cooldown[0]
		{
			key_cooldown[0]=1;
			global.sub_menu = 2;
			audio_play_sound(sfx_select,9,false);
		}
	}
	
	//关闭菜单
	if bkey && !key_cooldown[0]
	{
		key_cooldown[0]=1;
		menu_cloes = true;
		audio_play_sound(sfx_deselect,9,false);
	}
}
else if global.sub_menu == 2 && global.talking != true && menu_anm <= 2 && menu_cloes == false
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

	if bkey && !key_cooldown[0]
	{
		key_cooldown[0]=1;
		global.sub_menu = 1;
		pos = 0;
		audio_play_sound(sfx_deselect,9,false);
	}

	//应用选项
	if akey && !key_cooldown[0]
	{
		key_cooldown[0]=1;
		var _inventory = load_inventory(item_pos+item_scroll_a);
		switch(pos)
		{
		case 0:	
			//使用
			audio_play_sound(sfx_select,9,false);
			global.sub_menu = 1;
			//如果物品不可用
			if _inventory.scr==undefined
			{
				create_msg_box("itemunuseable");
			}
			//如果物品可用
			else
			{
				//这里是物品执行用的代码
				scr_item_script_execute(_inventory.scr);
			}
			break;
		case 1:
			//丢弃
			audio_play_sound(sfx_select,9,false);
			//判断是否可丢弃
			if _inventory.discardable!=1
			{
				create_msg_box("undiscardable");
				global.sub_menu = 1;
				pos = 0;
			}
			else
			{
				global.sub_menu = 3;
				discard_cursor = 2;
				discard_amount = 1;
			}
			break;
		}
	}
}
else if global.sub_menu == 3 && global.talking != true && menu_anm <= 2 && menu_cloes == false && !instance_exists(obj_menu_useitem)
{
	var _inventory = load_inventory(item_pos+item_scroll_a);
	// 左右循环切换位数
	if lpkey
	{
	    discard_cursor -= 1;
	    if (discard_cursor < 0) discard_cursor = 2;
	    audio_play_sound(sfx_click,9,false);
	}
	if rpkey
	{
	    discard_cursor += 1;
	    if (discard_cursor > 2) discard_cursor = 0;
	    audio_play_sound(sfx_click,9,false);
	}
	
    // 上下调整该位数字
    var digits = [floor(discard_amount/100)%10, floor(discard_amount/10)%10, discard_amount%10];
    if upkey
    {
        digits[discard_cursor] = (digits[discard_cursor] + 1) % 10;
        audio_play_sound(sfx_click,9,false);
    }
    if dpkey
    {
        digits[discard_cursor] = (digits[discard_cursor] + 9) % 10; // 循环到9
        audio_play_sound(sfx_click,9,false);
    }
	
	// 把互斥键收集到一个数组或列表
	var _dir_keys = [ukey,dkey,lkey,rkey];

	// 统计按下了多少个互斥键
	var _pressed_count = 0;
	for (var i = 0; i < array_length(_dir_keys); i++)
	{
		if (_dir_keys[i])
		{
			_pressed_count++;
		}
	}
	// 如果按下两个及以上，算互斥
	if (_pressed_count >= 2)
	{
		wait_time = 30;
	}
	else if (_pressed_count == 1)
	{
		if (wait_time > 0)
		{
			wait_time--;
		}
	}
	else
	{
		wait_time = 30;
	}
	
	//快速切换上下数字
    if wait_time <= 0
    {
		if ukey
		{
	        digits[discard_cursor] = (digits[discard_cursor] + 1) % 10;
	        audio_play_sound(sfx_click,9,false);
	    }
	    if dkey
	    {
	        digits[discard_cursor] = (digits[discard_cursor] + 9) % 10; // 循环到9
	        audio_play_sound(sfx_click,9,false);
	    }
		wait_time = 5;
	}
	
	discard_amount = digits[0]*100 + digits[1]*10 + digits[2];
	
    //确认丢弃
    if akey && !key_cooldown[0]
	{
		key_cooldown[0]=1;
        var max_amount = _inventory.amount;
        if discard_amount > max_amount
		{
            discard_amount = max_amount;
		}
		
		global.g_msg_name = _inventory.i_name;
		global.g_msg_amount = discard_amount;
        for (var i=0; i<discard_amount; i++)
        {
            scr_useitem(); //每次减少1
        }

        create_msg_box("discard"); //提示丢弃
        global.sub_menu = 1; //返回上层菜单
		pos = 0;
    }

    //按B取消
    if bkey && !key_cooldown[0]
	{
		key_cooldown[0]=1;
        global.sub_menu = 2;
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