//物品表格枚举
enum DS_INVENTORY
{
	NAME = 0,
	AMOUNT = 1,
	I_ID = 2
}

/// @param id
function item_id(_id){
#region 初始化
var _i_name = "虚空404";
var _weight = 0;
var _price = 0;
var _rarity = 0;
var _type_i = "杂物";
var _descr = "一个装着一张写着虚空404破纸的破袋子。";
var _spr = spr_item;
var _scr = undefined;
var _i_id = 0;
var _discardable = 1;
var _consumables = 0;
#endregion
switch(_id)//物品数据
{
	#region
	default:
		//保持不变
		break;
	#endregion
	#region 极重无比的袋子
	case 0.1:
		_i_name = "极重无比的袋子";
		_weight = 200;
		_price = 0;
		_rarity = 0;
		_type_i = "杂物";
		_descr = "这里面装的到底是啥啊，为什么这么重啊？";
		_spr = spr_item_gr;
		_scr = undefined;
		_i_id = 0.1;
		_discardable = 1;
		_consumables = 0;
		break;
	#endregion
	#region 非常重要的袋子
	case 0.2:
		_i_name = "非常重要的袋子";
		_weight = 0;
		_price = 0;
		_rarity = 0;
		_type_i = "重要物品";
		_descr = "一个非常重要的袋子，可不要弄丢了哦。";
		_spr = spr_item_i;
		_scr = [{type: APP_EFFECT.MESSAGE,t_id:"impbag"}];
		_i_id = 0.2;
		_discardable = 0;
		_consumables = 0;
		break;
	#endregion
	#region 治疗药水
	case 1:
		_i_name = "治疗药水";
		_weight = 0.5;
		_price = 50;
		_rarity = 0;
		_type_i = "魔药";
		_descr = "这种红色药水在摇晃时都会微微发亮。饮用此药水后，你将恢复4~10的生命值。";
		_spr = spr_item_potion_r;
		_scr = [{type: APP_EFFECT.ITEM_POTION,t_id:[2,4,2]}];
		_i_id = 1;
		_discardable = 1;
		_consumables = 1;
		break;
	#endregion
	#region 高等治疗药水
	case 1.1:
		_i_name = "高等治疗药水";
		_weight = 0.5;
		_price = 100;
		_rarity = 1;
		_type_i = "魔药";
		_descr = "这种红色药水在摇晃时都会微微发亮。饮用此药水后，你将恢复8~20的生命值。";
		_spr = spr_item_potion_r1;
		_scr = [{type: APP_EFFECT.ITEM_POTION,t_id:[4,4,4]}];
		_i_id = 1.1;
		_discardable = 1;
		_consumables = 1;
		break;
	#endregion
	#region 强效治疗药水
	case 1.2:
		_i_name = "强效治疗药水";
		_weight = 0.5;
		_price = 800;
		_rarity = 2;
		_type_i = "魔药";
		_descr = "这种红色药水在摇晃时都会微微发亮。饮用此药水后，你将恢复16~40的生命值。";
		_spr = spr_item_potion_r2;
		_scr = [{type: APP_EFFECT.ITEM_POTION,t_id:[8,4,8]}];
		_i_id = 1.2;
		_discardable = 1;
		_consumables = 1;
		break;
	#endregion
	#region 极效治疗药水
	case 1.3:
		_i_name = "极效治疗药水";
		_weight = 0.5;
		_price = 8000;
		_rarity = 3;
		_type_i = "魔药";
		_descr = "这种红色药水在摇晃时都会微微发亮。饮用此药水后，你将恢复30~60的生命值。";
		_spr = spr_item_potion_r3;
		_scr = [{type: APP_EFFECT.ITEM_POTION,t_id:[10,4,20]}];
		_i_id = 1.3;
		_discardable = 1;
		_consumables = 1;
		break;
	#endregion
	#region 碎魔晶
	case 2:
		_i_name = "碎魔晶";
		_weight = 0.5;
		_price = 200;
		_rarity = 1;
		_type_i = "奇物";
		_descr = "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复2的法力值。";
		_spr = spr_item_magic_crystal;
		_scr = [{type: APP_EFFECT.ITEM_CRYSTAL,t_id:2}];
		_i_id = 2;
		_discardable = 1;
		_consumables = 1;
		break;
	#endregion
	#region	魔晶
	case 2.1:
		_i_name = "魔晶";
		_weight = 0.5;
		_price = 400;
		_rarity = 1;
		_type_i = "奇物";
		_descr = "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复4的法力值。";
		_spr = spr_item_magic_crystal;
		_scr = [{type: APP_EFFECT.ITEM_CRYSTAL,t_id:4}];
		_i_id = 2.1;
		_discardable = 1;
		_consumables = 1;
		break;
	#endregion
	#region 大块魔晶
	case 2.2:
		_i_name = "大块魔晶";
		_weight = 0.5;
		_price = 800;
		_rarity = 2;
		_type_i = "奇物";
		_descr = "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复6的法力值。";
		_spr = spr_item_magic_crystal;
		_scr = [{type: APP_EFFECT.ITEM_CRYSTAL,t_id:6}];
		_i_id = 2.2;
		_discardable = 1;
		_consumables = 1;
		break;
	#endregion
	#region 小块高等魔晶
	case 2.3:
		_i_name = "小块高等魔晶";
		_weight = 0.5;
		_price = 3200;
		_rarity = 2;
		_type_i = "奇物";
		_descr = "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复8的法力值。";
		_spr = spr_item_magic_crystal;
		_scr = [{type: APP_EFFECT.ITEM_CRYSTAL,t_id:8}];
		_i_id = 2.3;
		_discardable = 1;
		_consumables = 1;
		break;
	#endregion
	#region 高等魔晶
	case 2.4:
		_i_name = "高等魔晶";
		_weight = 0.5;
		_price = 6400;
		_rarity = 3;
		_type_i = "奇物";
		_descr = "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复10的法力值。";
		_spr = spr_item_magic_crystal;
		_scr = [{type: APP_EFFECT.ITEM_CRYSTAL,t_id:10}];
		_i_id = 2.4;
		_discardable = 1;
		_consumables = 1;
		break;
	#endregion
	#region 大块高等魔晶
	case 2.5:
		_i_name = "大块高等魔晶";
		_weight = 0.5;
		_price = 12800;
		_rarity = 3;
		_type_i = "奇物";
		_descr = "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复12的法力值。";
		_spr = spr_item_magic_crystal;
		_scr = [{type: APP_EFFECT.ITEM_CRYSTAL,t_id:12}];
		_i_id = 2.5;
		_discardable = 1;
		_consumables = 1;
		break;
	#endregion
	#region	小块纯净魔晶
	case 2.6:
		_i_name = "小块纯净魔晶";
		_weight = 0.5;
		_price = 25600;
		_rarity = 3;
		_type_i = "奇物";
		_descr = "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复14的法力值。";
		_spr = spr_item_magic_crystal;
		_scr = [{type: APP_EFFECT.ITEM_CRYSTAL,t_id:14}];
		_i_id = 2.6;
		_discardable = 1;
		_consumables = 1;
		break;
	#endregion
	#region 纯净魔晶
	case 2.7:
		_i_name = "纯净魔晶";
		_weight = 0.5;
		_price = 51200;
		_rarity = 4;
		_type_i = "奇物";
		_descr = "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复16的法力值。";
		_spr = spr_item_magic_crystal;
		_scr = [{type: APP_EFFECT.ITEM_CRYSTAL,t_id:16}];
		_i_id = 2.7;
		_discardable = 1;
		_consumables = 1;
		break;
	#endregion
	#region 大块纯净魔晶
	case 2.8:
		_i_name = "大块纯净魔晶";
		_weight = 0.5;
		_price = 102400;
		_rarity = 4;
		_type_i = "奇物";
		_descr = "这种奇异的水晶散发着蓝色的微光。吸收水晶中的魔力后，你将恢复20的法力值。";
		_spr = spr_item_magic_crystal;
		_scr = [{type: APP_EFFECT.ITEM_CRYSTAL,t_id:20}];
		_i_id = 2.8;
		_discardable = 1;
		_consumables = 1;
		break;
	#endregion
	#region 空白卷轴
	case 3:
		_i_name = "空白卷轴";
		_weight = 0;
		_price = 1;
		_rarity = 0;
		_type_i = "卷轴";
		_descr = "一张没有记录任何东西的空白卷轴。";
		_spr = spr_item_scroll;
		_scr = undefined;
		_i_id = 3;
		_discardable = 1;
		_consumables = 0;
		break;
	#endregion
	#region 杂草
	case 4:
		_i_name = "杂草";
		_weight = 0;
		_price = 0;
		_rarity = 0;
		_type_i = "材料";
		_descr = "一把看上去没什么用的杂草，不过可以当成燃料烧或是紧急备用粮。";
		_spr = spr_item_weed;
		_scr = undefined;
		_i_id = 4;
		_discardable = 1;
		_consumables = 0;
		break;
	#endregion
	#region 苹果
	case 5:
		_i_name = "苹果";
		_weight = 0.5;
		_price = 1;
		_rarity = 0;
		_type_i = "食品";
		_descr = "一颗熟透了的红苹果。";
		_spr = spr_item_apple;
		_scr = [{type: APP_EFFECT.MESSAGE,t_id:"apple"},{type: APP_EFFECT.USEITEM}];
		_i_id = 5;
		_discardable = 1;
		_consumables = 1;
		break;
	#endregion
	#region 木棍
	case 6:
		_i_name = "木棍";
		_weight = 0.2;
		_price = 0;
		_rarity = 0;
		_type_i = "材料";
		_descr = "一根木棍，或许可以用来做点什么。";
		_spr = spr_item_stick;
		_scr = undefined;
		_i_id = 6;
		_discardable = 1;
		_consumables = 0;
		break;
	#endregion
	#region 石头
	case 7:
		_i_name = "石头";
		_weight = 0.5;
		_price = 0;
		_rarity = 0;
		_type_i = "材料";
		_descr = "一颗坚硬的石头。";
		_spr = spr_item_rock;
		_scr = undefined;
		_i_id = 7;
		_discardable = 1;
		_consumables = 0;
		break;
	#endregion
	#region 断剑
	case 8:
		_i_name = "断剑";
		_weight = 3;
		_price = 1;
		_rarity = 0;
		_type_i = "杂物";
		_descr = "一把从中间断开来的剑，已经不能当作武器使用了。";
		_spr = spr_item_broken_sword;
		_scr = undefined;
		_i_id = 8;
		_discardable = 1;
		_consumables = 0;
		break;
	#endregion
}
return {
	i_name		: _i_name,
	weight		: _weight,
	price		: _price,
	rarity		: _rarity,
	type_i		: _type_i,
	descr		: _descr,
	spr			: _spr,
	scr			: _scr,
	i_id		: _i_id,
	discardable	: _discardable,
	consumables	: _consumables
}
}

//这里是处理添加物品的代码
/// @param id
/// @param amount*
function add_item_id(_id,_ref_amount){
if argument_count>1
{
	var _amount = argument[1];
}
else var _amount = 1;
var _inventory_id = item_id(_id);

var i_name		= _inventory_id.i_name;
var amount		= _amount;
var i_id		= _inventory_id.i_id;

global.g_msg_name = i_name;

//情况1，物品已经在物品栏中
for(var i=0;i<ds_grid_height(inventory);i++)
{
	var _inventory = load_inventory(i);
	if(_inventory.i_id == i_id)
	{
		//判断物品是否到达上限
		var _old_amount = ds_grid_get(inventory,DS_INVENTORY.AMOUNT,i);
		var _new_amount = _old_amount + amount;
		
		if (_new_amount > 999)
		{
			if _old_amount < 999
			{
				//限制获取量
				amount = 999 - _old_amount;
				ds_grid_set(inventory,DS_INVENTORY.AMOUNT,i,_inventory.amount+amount);
				global.g_msg_amount = amount;
				return true;
			}
			//超过上限，不能增加
			return false;
		}
		else
		{
			ds_grid_set(inventory,DS_INVENTORY.AMOUNT,i,_inventory.amount+amount);
			global.g_msg_amount = amount;
			return true;
		}
	}
}

//情况2，物品未在物品栏中
if (amount > 999)
{
	//限制获取新物品的上限数量
	amount = 999;
}
if(ds_grid_get(inventory,DS_INVENTORY.NAME,0)!=0)
{
	ds_grid_resize(inventory,inventory_w,ds_grid_height(inventory)+1);
}
var new_item = ds_grid_height(inventory)-1;
ds_grid_set(inventory,DS_INVENTORY.NAME,new_item,i_name);
ds_grid_set(inventory,DS_INVENTORY.AMOUNT,new_item,amount);
ds_grid_set(inventory,DS_INVENTORY.I_ID,new_item,i_id);

global.g_msg_amount = amount;
return true;
}

//加载物品数据
function load_inventory(_id){
	var _i_id = ds_grid_get(inventory,DS_INVENTORY.I_ID,_id)
	var _item = item_id(_i_id)
	return
	{
		i_name		: _item.i_name,
		amount		: ds_grid_get(inventory,DS_INVENTORY.AMOUNT,_id),
		i_id		: _i_id,
		
		weight		: _item.weight,
		price		: _item.price,
		rarity		: _item.rarity,
		type_i		: _item.type_i,
		descr		: _item.descr,
		spr			: _item.spr,
		scr			: _item.scr,
		discardable	: _item.discardable,
		consumables	: _item.consumables,
	}
}