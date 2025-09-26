audio_play_sound(sfx_select,9,false);
switch(pos)
{
	case 0:
		//返回游戏
		menu_cloes = true;
		break;
	case 1:
		//背包
		instance_create_layer(0,0,"Instances",obj_menu_backpack);
		break;
	case 2:
		//人物状态
		instance_create_layer(0,0,"Instances",obj_menu_charsatus);
		break;
	case 3:
		//武器&防具
		instance_create_layer(0,0,"Instances",obj_menu_equipment);
		break;
	case 4:
		//技能&法术
		instance_create_layer(0,0,"Instances",obj_menu_skill);
		break;
	case 5:
		//日志
		break;
	case 6:
		//休息
		instance_create_layer(0,0,"Instances",obj_menu_resting);
		break;
	case 7:
		//设置
		instance_create_layer(0,0,"Instances",obj_menu_setting);
		break;
	case 8:
		//保存
		instance_create_layer(0,0,"Instances",obj_menu_loading);
		break;
	case 9:
		//退出游戏
		instance_create_layer(0,0,"Instances",obj_menu_exit);
		break;
}