/// @param msg_id
function scr_msg_game(_msg_id){
switch(_msg_id)
{
	//默认文本
	default:
			create_msg("...");
		break;
	case "item_pickup":
			create_msg("获得了"+string(global.g_msg_name)+"×"+string(global.g_msg_amount)+"。");
		break;
	case "HPTO0":
			create_msg(string(load_chara(global.player1).c_name)+"一行人倒下了...");
			create_msg("......");
		break;
	case "noresting":
			create_msg("现在不能在这里休息。");
		break;
	case "nosaving":
			create_msg("现在不能在这里保存。");
		break;
	case "itemunuseable":
			create_msg("这个物品不能使用。");
		break;
	case "undiscardable":
			create_msg("这个物品不能丢弃。");
		break;
	case "isfull":
			create_msg("当前状态已满。");
		break;
	case "discard":
			create_msg("丢弃了"+string(global.g_msg_amount)+"个"+string(global.g_msg_name)+"。");
		break;
	case "item_full":
			create_msg(string(load_chara(global.player1).c_name)+"不能再获得更多该物品了。");
		break;
	
		
	//物品交互文本
	case "impbag":
			create_msg("呃...这东西到底哪里重要了啊...",0,"罗琳",spr_e_player2,5);
			create_msg("这种事情可不要随便问哦，小罗。没准会引火上身呢。",0,"丝诺");
			create_msg("啊，好可怕，还是好好收着吧。",0,"罗琳",spr_e_player2,1);
		break;
	case "use":
			create_msg("这个东西要咋用啊...",0,"罗琳",spr_e_player2,4);
			create_msg("你摇晃它试试看？",0,"丝诺");
			create_msg("呃...它怎么就突然消失了啊...",0,"罗琳",spr_e_player2,5);
		break;
	case "apple":
			create_msg("每日一苹果，医生远离我。",0,"罗琳",spr_e_player2,0);
			create_msg("要看医生的时候还是要好好去看哦，小罗。",0,"丝诺");
			create_msg("唔咕咕，你怎么这么死板呀小丝。",0,"罗琳",spr_e_player2,5);
			create_msg("记得分我一半哦。",0,"丝诺");
		break;
	case "use_item_1":
			create_msg(string(global.g_msg_name)+"恢复了"+string(global.g_msg_amount)+"点HP。");
		break;
	case "use_item_1_isfull":
			create_msg(string(global.g_msg_name)+"的HP已满。");
		break;
	case "use_item_2":
			create_msg(string(global.g_msg_name)+"恢复了"+string(global.g_msg_amount)+"点MP。");
		break;
	case "use_item_2_isfull":
			create_msg(string(global.g_msg_name)+"的MP已满。");
		break;
	
		
	//TEST房间npc
	case "test_npc_1":
			create_msg("选择分支1",0,"测试选项npc");
			msg_option("选项1","test_npc_1-1");
			msg_option("选项2","test_npc_1-2");
		break;
		case "test_npc_1-1":
				create_msg("你选择了选项1",0,"测试选项npc");
			break;
		case "test_npc_1-2":
				create_msg("你选择了选项2",0,"测试选项npc");
			break;
	case "test_npc_2":
			create_msg("短文本测试",0,"测试文本npc");
			create_msg("英文字符测试。abcdefghijklmnopqrstuvwxzy 123456789!?",0,"测试文本npc2");
			create_msg("长文本测试\n一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四五六七八九十一二三四",0,"测试文本npc2");
		break;
	case "test_npc_3":
			create_msg("无npc名字测试");
		break;
	case "test_npc_4":
			create_msg("表情0",0,"表情测试npc",spr_e_player2,0);
			create_msg("表情1",0,"表情测试npc",spr_e_player2,1);
			create_msg("表情2",0,"表情测试npc",spr_e_player2,2);
			create_msg("表情3",0,"表情测试npc",spr_e_player2,3);
			create_msg("表情4",0,"表情测试npc",spr_e_player2,4);
			create_msg("表情5",0,"表情测试npc",spr_e_player2,5);
			create_msg("表情6",0,"表情测试npc",spr_e_player2,6);
			create_msg("表情7",0,"表情测试npc",spr_e_player2,7);
			create_msg("表情8",0,"表情测试npc",spr_e_player2,8);
			create_msg("表情9",0,"表情测试npc",spr_e_player2,9);
			create_msg("表情10",0,"表情测试npc",spr_e_player2,10);
		break;
	case "test_npc_5":
		create_msg("第一段对话",
				method(undefined,function()
				{
					ds_grid_set(room_status,1,2,1);
					if (instance_exists(inst_test_npc_5))
					{
						inst_test_npc_5.msg_id = "test_npc_5-1";
					}
				}),
				"npc5");
			break;
	case "test_npc_5-1":
		create_msg("第二段对话",0,"npc5");
		break;
	case "test_npc_6":
			if add_item_id(1,3)
			{
				create_msg("前面的道路很危险，请收下这个吧。",
					method(undefined,function()
					{
						ds_grid_set(room_status,1,0,1);
						if (instance_exists(inst_test_npc_6))
						{
							inst_test_npc_6.msg_id = "test_npc_6-1";
						}
					}),
				"送东西的npc",spr_e_player2,0);
				create_msg("获得了"+string(global.g_msg_name)+"×"+string(global.g_msg_amount)+"。");
				break;
			}
			else
			{
				create_msg("前面的道路很危险，请收下这个吧。",0,"送东西的npc",spr_e_player2,0);
				create_msg("获得了"+string(global.g_msg_name)+"。");
				create_msg("但是"+string(load_chara(global.player1).c_name)+"不能再获得更多的"+string(global.g_msg_name)+"了。",);
				create_msg("嗯...也许你可以晚点再来？",0,"送东西的npc",spr_e_player2,0);
				break;
			}
			case "test_npc_6-1":
				create_msg("祝你武运昌隆。",0,"送东西的npc",spr_e_player2,0);
				break;
		
}
}