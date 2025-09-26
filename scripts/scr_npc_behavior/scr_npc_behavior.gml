function scr_npc_behavior(){
switch(npc_behavior)
{
	default:
		scr_npc_idle();//待机
		break;
	case 1:
		scr_npc_random_move();//随机移动
		break;
	case 2:
		scr_npc_talking();//谈话
		break;
	case 3:
		scr_npc_follow();//跟随
		break;
	case 4:
		scr_npc_ofollow();//贴紧跟随
		break;
	case 5:
		scr_npc_away();//远离
		break;
}
}